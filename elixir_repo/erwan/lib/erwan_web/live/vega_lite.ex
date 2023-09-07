defmodule AdelWeb.Live.VegaGraph do
  @moduledoc """
  AdelWeb.Live.VegaGraph is Vega Implementation as a live_component
  To add it to another live, just add these lines in the .heex :
    <.live_component
      module={AdelWeb.Live.VegaGraph}
      id="vega"
      selected_parking={@selected_parking}
    />
  """
  use AdelWeb, :live_component
  alias VegaLite
  alias Adel.Parkings

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
      |> VegaLite.data_from_values(real_data(assigns.selected_parking, assigns.module_name))
      |> VegaLite.encode_field(:x, "Base temps réel",
        type: :temporal,
        axis: %{tick_count: 25}
      )
      |> build_axis(
        assigns.select_axis_display["place_axis_checkbox"],
        assigns.select_axis_display["availability_axis_checkbox"]
      )
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

  defp build_axis(vl, "true", "false") do
    vl
    |> VegaLite.mark(:line, color: "#85C5A6")
    |> VegaLite.encode_field(:y, "places",
      type: :quantitative,
      title: "Nb de places",
      axis: %{title_color: "#85C5A6"}
    )
  end

  defp build_axis(vl, "false", "true") do
    vl
    |> VegaLite.mark(:line, color: "#85A9C5")
    |> VegaLite.encode_field(:y, "taux_doccupation",
      type: :quantitative,
      title: "Taux d'occupation (en %)",
      axis: %{title_color: "#85A9C5"}
    )
  end

  defp build_axis(vl, "true", "true") do
    vl
    |> VegaLite.layers([
      VegaLite.new()
      |> VegaLite.mark(:line, color: "#85C5A6")
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
  end

  defp build_axis(vl, "false", "false") do
    vl
    |> VegaLite.mark(:line, color: "#85A9C5")
    |> VegaLite.encode_field(:color, "no data selected !", type: :nominal)
  end

  defp real_data(parking_chosen, module_name) do
    module_name
    |> case do
      "Poitiers" ->
        parking_chosen
        |> Parkings.list_parkings_vega()

      "Rochelle" ->
        parking_chosen
        |> Parkings.list_rochelle_parkings_vega()
    end
  end
end
