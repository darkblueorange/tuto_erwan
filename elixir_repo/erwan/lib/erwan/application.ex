defmodule Erwan.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      ErwanWeb.Telemetry,
      # Ping the ParkingDataAPI
      Erwan.RetrieveParkingData,
      # Start the Ecto repository
      Erwan.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Erwan.PubSub},
      # Start Finch
      {Finch, name: Erwan.Finch},
      # Start the Endpoint (http/https)
      ErwanWeb.Endpoint
      # Start a worker by calling: Erwan.Worker.start_link(arg)
      # {Erwan.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Erwan.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ErwanWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
