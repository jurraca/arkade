defmodule Arkade.Repo do
  use Ecto.Repo,
    otp_app: :arkade,
    adapter: Ecto.Adapters.Postgres
end
