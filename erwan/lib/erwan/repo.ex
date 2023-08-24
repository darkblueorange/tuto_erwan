defmodule Erwan.Repo do
  use Ecto.Repo,
    otp_app: :erwan,
    adapter: Ecto.Adapters.Postgres
end
