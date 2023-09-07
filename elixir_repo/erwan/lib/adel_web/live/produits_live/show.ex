defmodule AdelWeb.ProduitsLive.Show do
  use AdelWeb, :live_view

  alias Adel.SuperTrucs

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:produits, SuperTrucs.get_produits!(id))}
  end

  defp page_title(:show), do: "Show Produits"
  defp page_title(:edit), do: "Edit Produits"
end
