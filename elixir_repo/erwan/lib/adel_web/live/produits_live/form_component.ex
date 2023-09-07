defmodule AdelWeb.ProduitsLive.FormComponent do
  use AdelWeb, :live_component

  alias Adel.SuperTrucs

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage produits records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="produits-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:nom]} type="text" label="Nom" />
        <.input field={@form[:categorie]} type="text" label="Categorie" />
        <.input field={@form[:nombre]} type="number" label="Nombre" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Produits</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{produits: produits} = assigns, socket) do
    changeset = SuperTrucs.change_produits(produits)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"produits" => produits_params}, socket) do
    changeset =
      socket.assigns.produits
      |> SuperTrucs.change_produits(produits_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"produits" => produits_params}, socket) do
    save_produits(socket, socket.assigns.action, produits_params)
  end

  defp save_produits(socket, :edit, produits_params) do
    case SuperTrucs.update_produits(socket.assigns.produits, produits_params) do
      {:ok, produits} ->
        notify_parent({:saved, produits})

        {:noreply,
         socket
         |> put_flash(:info, "Produits updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_produits(socket, :new, produits_params) do
    case SuperTrucs.create_produits(produits_params) do
      {:ok, produits} ->
        notify_parent({:saved, produits})

        {:noreply,
         socket
         |> put_flash(:info, "Produits created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
