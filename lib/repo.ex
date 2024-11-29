defmodule MySQL.Repo do
  use Ecto.Repo,
    otp_app: :my_sql,
    adapter: Ecto.Adapters.MyXQL
end
#
#defmodule Posgrest.Repo do
#  use Ecto.Repo,
#    otp_app: :posgrest,
#    adapter: Ecto.Adapters.Postgres
#end
#
#defmodule Oracle.Repo do
#  use Ecto.Repo,
#    otp_app: :oracle,
#    adapter: Ecto.Adapters.Jamdb.Oracle
#end