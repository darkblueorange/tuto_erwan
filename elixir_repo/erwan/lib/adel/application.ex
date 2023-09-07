defmodule Adel.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      AdelWeb.Telemetry,
      # Ping the ParkingDataAPI
      Adel.RetrieveParkingDataPoitiers,
      Adel.RetrieveParkingDataRochelle,
      # Start the Ecto repository
      Adel.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Adel.PubSub},
      # Start Finch
      {Finch, name: Adel.Finch},
      # Start the Endpoint (http/https)
      AdelWeb.Endpoint
      # Start a worker by calling: Adel.Worker.start_link(arg)
      # {Adel.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Adel.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    AdelWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
