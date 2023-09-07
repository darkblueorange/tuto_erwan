defmodule AdelWeb.ParkingLive.FormComponent do
  use AdelWeb, :live_component

  alias Adel.Parkings

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage parking records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="parking-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:nom]} type="text" label="Nom" />
        <.input field={@form[:places]} type="number" label="Places" />
        <.input field={@form[:capacite]} type="number" label="Capacite" />
        <.input
          field={@form[:derniere_mise_a_jour_base]}
          type="datetime-local"
          label="Derniere mise a jour base"
        />
        <.input
          field={@form[:derniere_actualisation_bo]}
          type="datetime-local"
          label="Derniere actualisation bo"
        />
        <.input field={@form[:taux_doccupation]} type="number" label="Taux doccupation" />

        <.input field={@form[:parking_id]} type="number" label="Parking" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Parking</.button>
        </:actions>
      </.simple_form>
    </div>
    """

    # <.input field={@form[:geo_point_2d]} type="text" label="Geo point 2d" />
  end

  @impl true
  def update(%{parking: parking} = assigns, socket) do
    changeset = Parkings.change_parking(parking)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"parking" => parking_params}, socket) do
    changeset =
      socket.assigns.parking
      |> Parkings.change_parking(parking_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"parking" => parking_params}, socket) do
    save_parking(socket, socket.assigns.action, parking_params)
  end

  defp save_parking(socket, :edit, parking_params) do
    case Parkings.update_parking(socket.assigns.parking, parking_params) do
      {:ok, parking} ->
        notify_parent({:saved, parking})

        {:noreply,
         socket
         |> put_flash(:info, "Parking updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_parking(socket, :new, parking_params) do
    case Parkings.create_parking(parking_params) do
      {:ok, parking} ->
        notify_parent({:saved, parking})

        {:noreply,
         socket
         |> put_flash(:info, "Parking created successfully")
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
