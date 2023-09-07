defmodule Adel.RetrieveParkingDataRochelle do
  @moduledoc """

  This module aimes to retrieve external Parking Data every second.

  """
  use GenServer
  require Logger

  alias Adel.Parkings

  def child_spec(opts) do
    %{
      id: __MODULE__,
      start: {__MODULE__, :start_link, [opts]}
    }
  end

  def start_link(opts \\ []),
    do: GenServer.start_link(__MODULE__, opts)

  def init(_opts) do
    Logger.info("***** RetrieveParkingDataRochelle INIT *****")

    send_as_loop()
  end

  def send_as_loop() do
    Task.start(fn ->
      Logger.info("[Rochelle] sending every 150 seconds a request")
      :timer.sleep(150_000)

      send_to()
      |> case do
        {:ok, result} ->
          result["records"]
          |> data_decode()

          send_as_loop()

        {:warning, _} ->
          Logger.warning("Warning catched - relaunching in 5 seconds...")
          :timer.sleep(5000)
          send_as_loop()

        {:error, error} ->
          Logger.error("Stopping because of #{inspect(error)}")
      end
    end)
  end

  def send_to() do
    url =
      "https://api.agglo-larochelle.fr/production/opendata/api/records/1.0/search/dataset=parking___places_disponibles_en_temps_reel"

    headers = [{"Content-Type", "application/json"}]

    case HTTPoison.get(url, headers) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, Jason.decode!(body)}

      {:ok, %HTTPoison.Response{status_code: 404}} ->
        Logger.error("404 content not found on #{url}")
        {:error, "404"}

      {:ok, %HTTPoison.Response{status_code: 500}} ->
        Logger.error("500 server error on #{url}")
        {:error, "500"}

      {:error, %HTTPoison.Error{reason: :nxdomain}} ->
        Logger.error("DNS error on #{url}")
        {:error, "DNS network error"}

      {:error, %HTTPoison.Error{reason: :timeout}} ->
        Logger.warning("Network Timeout error on #{url}, keeping")
        {:warning, nil}

      {:error, %HTTPoison.Error{reason: :connect_timeout}} ->
        Logger.warning("Connect Timeout error on #{url}, keeping")
        {:warning, nil}

      {:error, %HTTPoison.Error{reason: reason}} ->
        Logger.error("Unknow error #{inspect(reason)} on #{url}")
        {:error, "Unknown error #{inspect(reason)} on #{url}"}
    end
  end

  def data_decode(data) do
    data
    |> Enum.reduce([], fn
      %{
        "datasetid" => "parking___places_disponibles_en_temps_reel",
        "recordid" => _recordid,
        "fields" =>
          %{"id" => parking_string_id, "_id" => other_id, "_full_text" => full_binary_text} =
              fields
      },
      _acc1 ->
        fields
        |> Map.put("parking_string_id", parking_string_id)
        |> Map.put("other_id", other_id)
        |> Map.put("full_binary_text", full_binary_text)
        |> Parkings.create_parking_rochelle()

      result, acc1 ->
        # Ignore
        Logger.warning("Result uncatched: #{inspect(result)}")
        acc1
    end)
  end
end
