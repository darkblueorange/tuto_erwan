defmodule ErwanWeb.Live.VegaGraph do
  @moduledoc """
  ErwanWeb.Live.VegaGraph is Vega Implementation as a live_component
  To add it to another live, just add these lines in the .heex :
    <.live_component
      module={ErwanWeb.Live.VegaGraph}
      id="vega"
      selected_parking={@selected_parking}
    />
  """
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
      |> VegaLite.encode_field(:x, "Base temps réel",
        type: :temporal,
        axis: %{tick_count: 25}
      )
      |> VegaLite.layers([
        VegaLite.new()
        # Defines the type of mark to be used
        |> VegaLite.mark(:line, color: "#85C5A6")
        # Sets the axis, the key for the data and the type of data
        |> VegaLite.encode_field(:y, "places",
          type: :quantitative,
          title: "Nb de places",
          axis: %{title_color: "#85C5A6"}
        ),
        VegaLite.new()
        |> VegaLite.mark(:line, color: "#85A9C5")
        |> VegaLite.encode_field(:y, "taux_doccupation",
          type: :quantitative,
          title: "Taux d'occupation (en %)",
          axis: %{title_color: "#85A9C5"}
        )
      ])
      |> VegaLite.resolve(:scale, y: :independent)
      # Output the specification
      |> VegaLite.to_spec()

    socket = socket |> assign(id: socket.id)
    {:ok, socket |> push_event("vega_lite:#{socket.id}:init", %{"spec" => spec})}
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

  defp real_data(parking_chosen) do
    parking_chosen
    |> Parkings.list_parkings_vega()
  end
end
