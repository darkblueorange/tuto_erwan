defmodule ErwanWeb.Live.VegaGraph do
  use ErwanWeb, :live_component
  alias VegaLite

  @impl true
  def update(_, socket) do
    spec =
      VegaLite.new(title: "Demo", width: :container, height: :container, padding: 5)
      # Load values. Values are a map with the attributes to be used by Vegalite
      |> VegaLite.data_from_values(fake_data())
      # Defines the type of mark to be used
      |> VegaLite.mark(:line)
      # Sets the axis, the key for the data and the type of data
      |> VegaLite.encode_field(:x, "date", type: :nominal)
      |> VegaLite.encode_field(:y, "total", type: :quantitative)
      # Output the specifcation
      |> VegaLite.to_spec()

    socket = assign(socket, id: socket.id)
    {:ok, push_event(socket, "vega_lite:#{socket.id}:init", %{"spec" => spec})}
  end

  @impl true
  def render(assigns) do
    # Here we have the element that will load the embedded view. Special note to data-id which is the
    # identifier that will be used by the hooks to understand which socket sent want.

    # We also identify the hook that will use this component using phx-hook.
    # Refer again to https://hexdocs.pm/phoenix_live_view/js-interop.html#client-hooks-via-phx-hook
    ~H"""
    <div class="vega">
      <div style="width:80%; height: 500px" id="vega-graph" phx-hook="VegaLite" phx-update="ignore" data-id={@id}/>
    </div>
    """
  end

  defp fake_data do
    today = Date.utc_today()
    until = today |> Date.add(10)

    Enum.map(Date.range(today, until), fn date ->
      %{total: Enum.random(1..100), date: Date.to_iso8601(date), name: "potato"}
    end)
  end
end
