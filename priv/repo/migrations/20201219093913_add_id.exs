defmodule Arkade.Repo.Migrations.AddId do
  use Ecto.Migration

  def change do
    alter table("holdings") do
      add :id, :id 
    end 

    create index("holdings", [:ticker])
  end
end
