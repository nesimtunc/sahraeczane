defmodule Sahraeczane.Repo do
  use Ecto.Repo,
    otp_app: :sahraeczane,
    adapter: Ecto.Adapters.Postgres
end
