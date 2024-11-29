defmodule Cnx do
  alias Db

#  defmacro build(configs) do
#    quote do
#      config = unquote(configs)
#      IO.inspect(config)
#      opts = [strategy: :one_for_one, name: Supervisor]
#      case config[:name] do
#        :my_sql -> MySQL.Repo.start_link(
#          username: config[:username],
#          password: config[:password],
#          database: config[:database],
#          hostname: config[:hostname],
#          port: config[:port],
#          pool_size: config[:pool_size]
#        )
#        :posgrest -> Posgrest.Repo.start_link(
#          username: config[:username],
#          password: config[:password],
#          database: config[:database],
#          hostname: config[:hostname],
#          port: config[:port],
#          pool_size: config[:pool_size]
#        )
#        :oracle -> Oracle.Repo.start_link(
#          username: config[:username],
#          password: config[:password],
#          database: config[:database],
#          hostname: config[:hostname],
#          port: config[:port],
#          pool_size: config[:pool_size]
#        )
#        _ -> {:error, :Conexion_no_permitida}
#      end
#    end
#  end
  defmacro build() do
    quote do
      Ecto.Repo.Supervisor.start_link(
        Ecto.Repo, :my_sql, Ecto.Adapters.MyXQL,
        [username: "usuario", password: "secret", database: "elixir", hostname: "db", port: 3306, pool_size: 10])
    end
  end
end