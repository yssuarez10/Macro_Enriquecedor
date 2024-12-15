defmodule DataOrchestratorWeb.Orchestrator do

  use  DataOrchestratorWeb, :controller

  def show(conn, params) do

    IO.inspect(params)


    # DB.start_link([name: :my_sql, username: "usuario", password: "secret", database: "elixir", hostname: "db", port: "3306", pool_size: "10"])


    json(conn, %{id: "hola"})
  end

end
