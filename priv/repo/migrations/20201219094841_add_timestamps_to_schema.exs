defmodule Arkade.Repo.Migrations.AddTimestampsToSchema do
  use Ecto.Migration

  def change do
    alter table("holdings") do 
      add :inserted_at, :timestamp
      add :updated_at, :timestamp
    end 
  end
end
