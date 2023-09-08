defmodule AdelWeb.ParkingRochelleLive.Index do
  use AdelWeb, :live_view

  alias Adel.Parkings
  alias Adel.Parkings.ParkingRochelle

  @impl true
  def mount(_params, _session, socket) do
    parking_list = Parkings.list_rochelle_parkings()
    select_parking = Parkings.list_rochelle_parkings_reduced()

    {:ok,
     socket
     |> assign(:select_parking, %{
       "options" => [{"Tous les parkings", "Tous les parkings"} | select_parking]
     })
     |> assign(:selected_parking, nil)
     |> assign(:select_axis_display, %{
       "place_axis_checkbox" => "true",
       "availability_axis_checkbox" => "false"
     })
     |> assign(:module_name, "Rochelle")
     |> stream(:rochelle_parkings, parking_list)}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Parking rochelle")
    |> assign(:parking_rochelle, Parkings.get_parking_rochelle!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Parking rochelle")
    |> assign(:parking_rochelle, %ParkingRochelle{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Rochelle parkings")
    |> assign(:parking_rochelle, nil)
  end

  @impl true
  def handle_info(
        {AdelWeb.ParkingRochelleLive.FormComponent, {:saved, parking_rochelle}},
        socket
      ) do
    {:noreply, stream_insert(socket, :rochelle_parkings, parking_rochelle)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    parking_rochelle = Parkings.get_parking_rochelle!(id)
    {:ok, _} = Parkings.delete_parking_rochelle(parking_rochelle)

    {:noreply, stream_delete(socket, :rochelle_parkings, parking_rochelle)}
  end

  def handle_event(
        "parking_selected",
        %{"parking_chosen" => parking_chosen},
        socket
      ) do
    parking_data = Parkings.list_rochelle_parkings(parking_chosen)

    {:noreply,
     socket
     |> stream(:parkings, parking_data, reset: true)
     |> assign(:selected_parking, parking_chosen)}
  end

  def handle_event(
        "axis_selected",
        %{"place" => place, "taux d'occupation" => taux},
        socket
      ) do
    {:noreply,
     socket
     |> assign(:select_axis_display, %{
       "place_axis_checkbox" => place,
       "availability_axis_checkbox" => taux
     })
     |> assign(:selected_parking, socket.assigns.selected_parking)}
  end
end
