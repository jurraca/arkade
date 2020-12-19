defmodule Arkade.Repo.Migrations.ModifyNumType do
  use Ecto.Migration

  def change do
    alter table("holdings") do 
      modify :"weight(%)", :float
      modify :"market value($)", :float
    end
  end
end
