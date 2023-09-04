defmodule ErwanWeb.ParkingLive.Index do
  use ErwanWeb, :live_view

  alias Erwan.Parkings
  alias Erwan.Parkings.Parking

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :parkings, Parkings.list_parkings())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Parking")
    |> assign(:parking, Parkings.get_parking!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Parking")
    |> assign(:parking, %Parking{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Parkings")
    |> assign(:parking, nil)
  end

  @impl true
  def handle_info({ErwanWeb.ParkingLive.FormComponent, {:saved, parking}}, socket) do
    {:noreply, stream_insert(socket, :parkings, parking)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    parking = Parkings.get_parking!(id)
    {:ok, _} = Parkings.delete_parking(parking)

    {:noreply, stream_delete(socket, :parkings, parking)}
  end
end
