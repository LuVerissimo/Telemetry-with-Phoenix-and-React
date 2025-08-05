defmodule TelemetryDashboardWeb.TelemetryChannel do
  use TelemetryDashboardWeb, :channel

  def join("telemetry:metrics", _params, socket) do
    {:ok, socket}
  end

  # def join("telemetry:" <> _other(_params, socket)) do
  #   {:ok, %{reason: "unauthorized"}}
  # end
  def join("telemetry:" <> _topic, _params, socket) do
    {:error, %{reason: "unauthorized"}}
  end
end
