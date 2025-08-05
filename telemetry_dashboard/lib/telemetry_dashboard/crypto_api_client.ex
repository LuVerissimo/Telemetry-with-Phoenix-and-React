defmodule TelemetryDashboard.CryptoAPIClient do
  @moduledoc """
  Client for interacting with the Crypto API.
  """

  @base_url "https://api.coingecko.com/api/v3"
  @api_key Application.get_env(:telemetry_dashboard, :coingecko_api_key)

  @doc """
  Fetches the current price of a cryptocurrency by its ID.
  """
  def get_prices(ids) do
    ids_string = Enum.join(ids, ",")

    response = Req.get!(
      url: "#{@base_url}/simple/price",
      params: %{
        ids: ids_string,
        vs_currencies: "usd",
      },
      headers: [
        {"x-cg-pro-api-key", @api_key}
      ]
    )

    response.body
  end
end
