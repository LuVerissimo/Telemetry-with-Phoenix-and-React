defmodule TelemetryDashboardWeb.TelemetryChannel do
  use TelemetryDashboardWeb, :channel
  require Logger

  @crypto_topic "crypto:prices"
  @telemetry_topic "telemetry:metrics"

  # Join crypto:prices and subscribe to PubSub
  def join("crypto:prices", _params, socket) do
    Logger.info("Client joined crypto:prices channel")

    :ok = Phoenix.PubSub.subscribe(TelemetryDashboard.PubSub, @crypto_topic)

    {:ok, socket}
  end

  def join("telemetry:metrics", _params, socket) do
    Logger.info("Client joined telemetry:metrics channel")

    :ok = Phoenix.PubSub.subscribe(TelemetryDashboard.PubSub, @telemetry_topic)

    {:ok, socket}
  end

  # Catch-all join handler
  def join(_topic, _params, _socket) do
    {:error, %{reason: "unauthorized"}}
  end

  def handle_info({"crypto_prices", prices}, socket) do
    Logger.debug("Pushing prices to client: #{inspect(prices)}")

    push(socket, "crypto_prices", prices)

    {:noreply, socket}
  end

  def handle_info({"telemetry_event", payload}, socket) do
    Logger.info("Pushing telemetry_event to client: #{inspect(payload)}")
    push(socket, "telemetry_event", payload)
    {:noreply, socket}
  end
end
