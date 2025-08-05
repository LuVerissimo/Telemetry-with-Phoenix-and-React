defmodule TelemetryDashboardWeb.UserSocket do
  use Phoenix.Socket

  ## Channels
  channel "telemetry:metrics", TelemetryDashboardWeb.TelemetryChannel

  transport(:websocket, Phoenix.Transports.WebSocket)

  def connect(_params, socket) do
    {:ok, socket}
  end

  def id(_socket), do: nil
end
