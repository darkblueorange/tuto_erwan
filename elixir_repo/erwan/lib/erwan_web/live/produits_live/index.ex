defmodule AdelWeb.ProduitsLive.Index do
  use AdelWeb, :live_view

  alias Adel.SuperTrucs
  alias Adel.SuperTrucs.Produits

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :produits_collection, SuperTrucs.list_produits())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Produits")
    |> assign(:produits, SuperTrucs.get_produits!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Produits")
    |> assign(:produits, %Produits{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Produits")
    |> assign(:produits, nil)
  end

  @impl true
  def handle_info({AdelWeb.ProduitsLive.FormComponent, {:saved, produits}}, socket) do
    {:noreply, stream_insert(socket, :produits_collection, produits)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    produits = SuperTrucs.get_produits!(id)
    {:ok, _} = SuperTrucs.delete_produits(produits)

    {:noreply, stream_delete(socket, :produits_collection, produits)}
  end
end
