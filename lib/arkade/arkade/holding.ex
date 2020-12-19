defmodule Arkade.Holding do
  use Ecto.Schema
  import Ecto.Changeset

  schema "holdings" do
    field :company, :string
    field :cusip, :string
    field :date, :date
    field :fund, :string
    field :market_value, :integer
    field :shares, :integer
    field :ticker, :string
    field :weight, :string

    timestamps()
  end

  @doc false
  def changeset(holding, attrs) do
    holding
    |> cast(attrs, [:date, :fund, :company, :ticker, :cusip, :shares, :market_value, :weight])
    |> validate_required([:date, :fund, :company, :ticker, :cusip, :shares, :market_value, :weight])
  end

  def load_from_raw(rows) do 
    entries = rows 
      |> Enum.filter(fn item -> item !== nil end)
      |> Enum.map(fn row -> Map.to_list(row) end )
      #|> Enum.map(fn row -> changeset(row, []) end)
    
    Arkade.Repo.insert_all(Arkade.Holding, entries)
  end 
end
