defmodule AdelWeb.ParkingRochelleLive.FormComponent do
  use AdelWeb, :live_component

  alias Adel.Parkings

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage parking_rochelle records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="parking_rochelle-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:nb_places]} type="number" label="Nb places" />
        <.input field={@form[:nb_autopartage]} type="number" label="Nb autopartage" />
        <.input field={@form[:nb_velo]} type="number" label="Nb velo" />
        <.input field={@form[:nb_velo_dispo]} type="number" label="Nb velo dispo" />
        <.input field={@form[:nb_2r_el_dispo]} type="number" label="Nb 2r el dispo" />
        <.input field={@form[:parking_string_id]} type="text" label="Parking string" />
        <.input field={@form[:ylat]} type="number" label="Ylat" step="any" />
        <.input field={@form[:nb_2_rm]} type="number" label="Nb 2 rm" />
        <.input field={@form[:nb_2_rm_dispo]} type="number" label="Nb 2 rm dispo" />
        <.input field={@form[:nb_2r_el]} type="number" label="Nb 2r el" />
        <.input field={@form[:xlong]} type="number" label="Xlong" step="any" />
        <.input field={@form[:nom]} type="text" label="Nom" />
        <.input field={@form[:nb_voitures_electriques]} type="number" label="Nb voitures electriques" />
        <.input field={@form[:nb_places_disponibles]} type="number" label="Nb places disponibles" />
        <.input field={@form[:nb_pr_dispo]} type="number" label="Nb pr dispo" />
        <.input field={@form[:nb_pmr]} type="number" label="Nb pmr" />
        <.input field={@form[:coord_y]} type="number" label="Coord y" step="any" />
        <.input field={@form[:coord_x]} type="number" label="Coord x" step="any" />
        <.input
          field={@form[:nb_voitures_electriques_dispo]}
          type="number"
          label="Nb voitures electriques dispo"
        />
        <.input field={@form[:total_count]} type="number" label="Total count" />
        <.input field={@form[:full_binary_text]} type="text" label="Full binary text" />
        <.input field={@form[:nb_pmr_dispo]} type="number" label="Nb pmr dispo" />
        <.input field={@form[:nb_pr]} type="number" label="Nb pr" />
        <.input field={@form[:other_id]} type="number" label="Other" />
        <.input field={@form[:nb_autopartage_dispo]} type="number" label="Nb autopartage dispo" />
        <.input field={@form[:date_comptage]} type="datetime-local" label="Date comptage" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Parking rochelle</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{parking_rochelle: parking_rochelle} = assigns, socket) do
    changeset = Parkings.change_parking_rochelle(parking_rochelle)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"parking_rochelle" => parking_rochelle_params}, socket) do
    changeset =
      socket.assigns.parking_rochelle
      |> Parkings.change_parking_rochelle(parking_rochelle_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"parking_rochelle" => parking_rochelle_params}, socket) do
    save_parking_rochelle(socket, socket.assigns.action, parking_rochelle_params)
  end

  defp save_parking_rochelle(socket, :edit, parking_rochelle_params) do
    case Parkings.update_parking_rochelle(
           socket.assigns.parking_rochelle,
           parking_rochelle_params
         ) do
      {:ok, parking_rochelle} ->
        notify_parent({:saved, parking_rochelle})

        {:noreply,
         socket
         |> put_flash(:info, "Parking rochelle updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_parking_rochelle(socket, :new, parking_rochelle_params) do
    case Parkings.create_parking_rochelle(parking_rochelle_params) do
      {:ok, parking_rochelle} ->
        notify_parent({:saved, parking_rochelle})

        {:noreply,
         socket
         |> put_flash(:info, "Parking rochelle created successfully")
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
