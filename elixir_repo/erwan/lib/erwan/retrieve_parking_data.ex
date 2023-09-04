defmodule Erwan.RetrieveParkingData do
  @moduledoc """

  This module aimes to retrieve external Parking Data every second.

  """
  use GenServer
  require Logger

  # alias Erwan.Repo

  def child_spec(opts) do
    %{
      id: __MODULE__,
      start: {__MODULE__, :start_link, [opts]}
    }
  end

  def start_link(opts \\ []),
    do: GenServer.start_link(__MODULE__, opts)

  def init(_opts) do
    Logger.info("***** RetrieveParkingData INIT *****")

    send_as_loop()
  end

  def send_as_loop() do
    Task.start(fn ->
      Logger.info("sending every second a request")
      :timer.sleep(2000)

      send_to()
      |> case do
        {:ok, result} ->
          Logger.info("Data received: #{inspect(result)}")
          send_as_loop()

        {:error, error} ->
          Logger.error("Stopping because of #{inspect(error)}")
      end
    end)
  end

  def send_to() do
    url =
      "https://data.grandpoitiers.fr/api/explore/v2.1/catalog/datasets/mobilites-stationnement-des-parkings-en-temps-reel/records"

    headers = [{"Content-Type", "application/json"}]

    case HTTPoison.get(url, headers) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, Jason.decode!(body)}

      {:ok, %HTTPoison.Response{status_code: 404}} ->
        Logger.error("404 content not found on #{url}")
        {:error, "404"}

      {:ok, %HTTPoison.Response{status_code: 500}} ->
        Logger.error("500 Rasa server error on #{url}")
        {:error, "500"}

      {:error, %HTTPoison.Error{reason: :nxdomain}} ->
        Logger.error("DNS error on #{url}")
        {:error, "DNS network error"}

      {:error, %HTTPoison.Error{reason: :timeout}} ->
        Logger.warning("Network Timeout error on #{url}, keeping")
        {:ok, nil}

      {:error, %HTTPoison.Error{reason: :connect_timeout}} ->
        Logger.warning("Connect Timeout error on #{url}, keeping")
        {:ok, nil}

      {:error, %HTTPoison.Error{reason: reason}} ->
        Logger.error("Unknow error #{inspect(reason)} on #{url}")
        {:error, "Unknown error #{inspect(reason)} on #{url}"}
    end
  end
end
