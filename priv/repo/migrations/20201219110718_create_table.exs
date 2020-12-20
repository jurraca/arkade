defmodule Arkade.Repo.Migrations.CreateTable do
  use Ecto.Migration

  def change do
    create table("holdings") do
      add :company, :string
      add :cusip, :string
      add :date, :date
      add :fund, :string
      add :market_value, :integer
      add :shares, :integer
      add :ticker, :string
      add :weight, :string

      timestamps()
    end
  end
end
