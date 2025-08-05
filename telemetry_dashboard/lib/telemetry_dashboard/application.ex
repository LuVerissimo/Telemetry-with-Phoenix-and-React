defmodule TelemetryDashboard.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      TelemetryDashboardWeb.Telemetry,
      TelemetryDashboard.Repo,
      {DNSCluster,
       query: Application.get_env(:telemetry_dashboard, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: TelemetryDashboard.PubSub},
      TelemetryDashboard.CryptoBroadcaster, # GenServer to fetch and broadcast crypto prices
      # Start the Finch HTTP client for sending emails
      {Finch, name: TelemetryDashboard.Finch},
      # Start a worker by calling: TelemetryDashboard.Worker.start_link(arg)
      # {TelemetryDashboard.Worker, arg},
      # Start to serve requests, typically the last entry
      TelemetryDashboardWeb.Endpoint
    ]

    TelemetryDashboard.TelemetryHandler.attach_to_event([:phoenix, :endpoint, :stop])

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: TelemetryDashboard.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    TelemetryDashboardWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
