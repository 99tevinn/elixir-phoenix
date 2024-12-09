defmodule Tev.Repo do
  use Ecto.Repo,
    otp_app: :tev,
    adapter: Ecto.Adapters.Postgres
end
