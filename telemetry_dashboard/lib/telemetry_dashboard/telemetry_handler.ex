defmodule TelemetryDashboard.TelemetryHandler do
  require Logger

  @doc """
  Attaches handlers telemetry events broadcast to Phoenix.
  """
   def attach_to_event(event_name) do
    # Create a unique ID for the handler by joining the event_name list
    handler_id = Enum.map_join(event_name, ":", &Atom.to_string/1)

    :telemetry.attach(
      "#{handler_id}-handler", # Use the string representation here
      event_name,
      &handle_event/4,
      nil
    )
  end

  defp handle_event(event_name, measurements, metadata, _config) do
    # TelemetryDashboard.TelemetryHandler.attach_to_event([:phoenix, :endpoint, :stop]) was causing errors
    # "converted" list to string
    topic = event_name
    |> Enum.map(&Atom.to_string/1)
    |> Enum.join(":")
    |> (&"telemetry:#{&1}").()

    payload = %{
      measurements: measurements,
      metadata: metadata
    }

    Phoenix.PubSub.broadcast(TelemetryDashboard.PubSub, topic, {"telemetry_event", payload})
  end
end
