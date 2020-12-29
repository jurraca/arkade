defmodule Arkade.Stats do
  alias Arkade.{Repo, Holding}
  import Ecto.Query

  def by_fund() do
    Holding
    |> group_by([h], [h.date, h.fund])
    |> select([h], [h.date, h.fund, sum(h.market_value)])
    |> Repo.all()
    |> Enum.map(fn [date, fund, value] -> %{date: date, fund: fund, market_value: value} end)
  end

  def get_share_price(ticker, since \\ ~D[2020-12-21]) do
    Holding
    |> where([h], h.ticker == ^ticker)
    |> where([h], h.date > ^since)
    |> select([h], [h.date, h.shares, h.market_value])
    |> Repo.all()
    |> Enum.map(fn row -> calc_unit_price(row, ticker) end)
  end

  def calc_unit_price([date, shares, market_value], ticker) do
    %{
      ticker: ticker,
      date: date,
      share_price: Float.round(market_value / shares, 2)
    }
  end
end
