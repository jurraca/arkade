defmodule Arkade.Holding do
  use Ecto.Schema
  import Ecto.Changeset
  alias Arkade.{Fetcher, Csv}

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
    |> validate_required([
      :date,
      :fund,
      :company,
      :ticker,
      :cusip,
      :shares,
      :market_value,
      :weight
    ])
  end

  @doc """
    This takes a single parsed CSV as a list of rows (maps with column headers), and inserts the rows in to the DB.
  """
  def load_from_raw(rows) do
    entries =
      rows
      |> Enum.filter(fn item -> item !== nil end)
      |> Enum.map(fn row -> Map.to_list(row) end)

    Arkade.Repo.insert_all(Arkade.Holding, entries)
  end

  @doc """
    Run the fetcher, get a list of CSVs for each fund, and parse it. 
    Pass this list of parsed CSVs to the loader. 
  """
  def fetch_and_load() do
    Fetcher.fetch()
    |> Enum.map(fn item -> Csv.parse(item) end)
    |> Enum.map(fn fund -> load_from_raw(fund) end)
  end
end
