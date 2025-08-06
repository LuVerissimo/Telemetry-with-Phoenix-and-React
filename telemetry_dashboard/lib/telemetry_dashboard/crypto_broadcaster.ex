defmodule TelemetryDashboard.CryptoBroadcaster do
  use GenServer
  require Logger

  @topic "crypto:prices"

  def start_link(_opts) do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  @impl true
  def init(_args) do
    api_key = Application.get_env(:telemetry_dashboard, :coingecko_api_key)

    if is_nil(api_key) do
      Logger.error("Coingecko API key is not set in the configuration")
    end

    :timer.send_interval(5000, self(), :fetch_and_broadcast)
    {:ok, %{api_key: api_key}}
  end

  @impl true
  def handle_info(:fetch_and_broadcast, %{api_key: api_key} = state) do
    ids = ["bitcoin", "ethereum", "ripple"]

    case TelemetryDashboard.CryptoAPIClient.get_prices(ids, api_key) do
      prices when is_map(prices) ->
        Phoenix.PubSub.broadcast(TelemetryDashboard.PubSub, @topic, {"crypto_prices", prices})

        Logger.info("Broadcasted crypto prices: #{inspect(prices)}")

      _ ->
        Logger.error("Failed to fetch crypto prices")
    end

    {:noreply, state}
  end
end
