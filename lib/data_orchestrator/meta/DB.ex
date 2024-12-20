defmodule DataOrchestrator.Meta.DB do
  defmacro create_repo(repo_name, otp_app, adapter) do
    quote do
      defmodule unquote(repo_name) do
        use Ecto.Repo,
          otp_app: unquote(otp_app),
          adapter: unquote(adapter)
      end
    end
  end

#   defmacro start_link(configs) do
#    quote do
#      config = unquote(configs)
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
end
