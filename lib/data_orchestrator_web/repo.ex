defmodule MySQL.Repo do
  use Ecto.Repo,
    otp_app: :my_sql,
    adapter: Ecto.Adapters.MyXQL
end
