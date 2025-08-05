defmodule TelemetryDashboardWeb.UserSocket do
  use Phoenix.Socket

  channel "telemetry:metrics", TelemetryDashboardWeb.TelemetryChannel
end
