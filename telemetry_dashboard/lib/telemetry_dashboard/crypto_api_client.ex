defmodule TelemetryDashboard.CryptoApiClient do
  @moduledoc """
  Client for interacting with the Crypto API.
  """

  @base_url "https://api.coingecko.com/api/v3"

  @doc """
  Fetches the current price of a cryptocurrency by its ID.
  """
  def get_prices(ids) do
    ids_string = Enum.join(ids, ",")

    Req.get!("#{@base_url}/simple/price",
      params: %{
        ids: ids_string,
        vs_currencies: "usd"
      }
    )
    |> Req.Response.body()
  end
end
