defmodule ErwanWeb.Live.VegaGraph do
  use ErwanWeb, :live_component
  alias VegaLite
  alias Erwan.Parkings

  require Logger

  @impl true
  def update(%{id: "vega"} = assigns, socket) do
    spec =
      VegaLite.new(
        title: "Nb places parking dispo",
        width: :container,
        height: :container,
        padding: 5
      )
      # Load values. Values are a map with the attributes to be used by Vegalite
      |> VegaLite.data_from_values(real_data(assigns.selected_parking))
      # Defines the type of mark to be used
      |> VegaLite.mark(:line)
      # Sets the axis, the key for the data and the type of data
      |> VegaLite.encode_field(:x, "derniere_mise_a_jour_base", type: :nominal)
      |> VegaLite.encode_field(:y, "places", type: :quantitative)

      # Output the specifcation
      |> VegaLite.to_spec()

    socket = socket |> assign(id: socket.id)
    {:ok, socket |> push_event("vega_lite:#{socket.id}:init", %{"spec" => spec})}
  end

  def handle_event("parking_selected", %{"parking_chosen" => parking_chosen}, socket) do
    {:noreply, socket}
  end

  @impl true
  def render(assigns) do
    # Here we have the element that will load the embedded view. Special note to data-id which is the
    # identifier that will be used by the hooks to understand which socket sent want.

    # We also identify the hook that will use this component using phx-hook.
    # Refer again to https://hexdocs.pm/phoenix_live_view/js-interop.html#client-hooks-via-phx-hook
    ~H"""
    <div class="vega">
      <div
        style="width:80%; height: 500px"
        id="vega-graph"
        phx-hook="VegaLite"
        phx-update="ignore"
        data-id={@id}
      />
    </div>
    """
  end

  defp real_data do
    Parkings.list_parkings("BLOSSAC TISON")
    |> Enum.map(fn parking ->
      %{}
      |> Map.put("places", parking.places)
      |> Map.put("derniere_mise_a_jour_base", parking.derniere_mise_a_jour_base)
    end)
  end

  defp real_data(parking_chosen) do
    Parkings.list_parkings(parking_chosen)
    |> Enum.map(fn parking ->
      %{}
      |> Map.put("places", parking.places)
      |> Map.put("derniere_mise_a_jour_base", parking.derniere_mise_a_jour_base)
    end)
  end
end
