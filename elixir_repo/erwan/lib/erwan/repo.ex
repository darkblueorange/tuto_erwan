defmodule Adel.Repo do
  use Ecto.Repo,
    otp_app: :adel,
    adapter: Ecto.Adapters.Postgres
end
