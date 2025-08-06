defmodule TelemetryDashboard.TelemetryBroadcaster do
  use GenServer
  require Logger

  @telemetry_topic "telemetry:metrics"

  def start_link(_opts) do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  @impl true
  def init(state) do
    # Attach to any events you're interested in
    :telemetry.attach(
      "telemetry-dashboard-endpoint-stop",
      [:phoenix, :endpoint, :stop],
      &__MODULE__.handle_event/4,
      nil
    )

    {:ok, state}
  end

  def handle_event(event_name, measurements, metadata, _config) do
    payload = %{
      event: event_name,
      measurements: measurements,
      metadata: metadata,
      timestamp: DateTime.utc_now()
    }

    Logger.info("Broadcasted telemetry event: #{inspect(event_name)}")

    Phoenix.PubSub.broadcast(
      TelemetryDashboard.PubSub,
      @telemetry_topic,
      {"telemetry_event", payload}
    )
  end
end
