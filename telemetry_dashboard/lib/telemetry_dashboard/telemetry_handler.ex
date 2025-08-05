defmodule TelemetryDashboard.TelemetryHandler do
  require Logger

  @doc """
  Attaches handlers telemetry events broadcast to Phoenix.
  """
  def attach_to_event(event_name) do
    :telemetry.attach(
      "#{event_name}-handler",
      event_name,
      &handle_event/4,
      nil
    )
  end

  defp handle_event(event_name, measurements, metadata, _config) do
    topic = "telemetry:#{Enum.join(event_nameme, ":")}"

    payload = %{
      measurements: measurements,
      metadata: metadata
    }

    Phoenix.PubSub.broadcast(
      TelemetryDashboard.PubSub,
      topic,
      {"telemetry_event", event_name, payload}
    )
  end
end
