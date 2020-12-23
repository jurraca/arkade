defmodule Arkade.Stats do 
    alias Arkade.{Repo, Holding}
    import Ecto.Query 

    def by_fund() do 
        Arkade.Holding
        |> group_by([h], [h.date, h.fund] )
        |> select([h],[h.date, h.fund, sum(h.market_value)])
        |> Repo.all() 
        |> Enum.map(fn [date, fund, value] -> %{date: date, fund: fund, market_value: value} end )
    end 

end 