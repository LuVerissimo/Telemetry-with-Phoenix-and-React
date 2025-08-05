defmodule TelemetryDashboard.CryptoBroadcaster do
  use GenServer
  require Logger

  @topic "crypto:prices"

  def start_link(_opts) do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  @impl true
  def init(nil) do
    :timer.send_interval(5000, self(), :fetch_and_broadcast)
    {:ok, %{}}
  end

  @impl true
  def handle_info(:fetch_and_broadcast, state) do
    ids = ["bitcoin", "ethereum", "ripple"]

    case TelemetryDashboard.CryptoApiClient.get_prices(ids) do
      prices when is_map(prices) ->
        Phoenix.PubSub.broadcast(TelemetryDashboard.PubSub, @topic, {"crypto_prices", prices})

      Logger.info("Broadcasted crypto prices: #{inspect(prices)}") ->
        -Logger.error("Failed to fetch crypto prices")
    end

    {:noreply, state}
  end
end
