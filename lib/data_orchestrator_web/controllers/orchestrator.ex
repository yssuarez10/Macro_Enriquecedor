defmodule DataOrchestratorWeb.Orchestrator do
  require MacroEnriquecedor.Schema
  use DataOrchestratorWeb, :controller

  def show(conn, params) do
    # IO.inspect(params["upsert"]["table"])

    module_name = String.to_atom(params["upsert"]["table"])

    if Code.ensure_loaded?(module_name) do
      IO.puts("El módulo MyModule existe")
      IO.inspect(module_name)
    else
      IO.puts("El módulo MyModule no existe")
      schema = new_module(module_name)
      IO.inspect(schema)
    end

    data = MacroEnriquecedor.Mysql.Repo.all(module_name)

    IO.inspect(data)

    json(conn, %{id: "hola"})
  end

  defp new_module(module_name) do
    MacroEnriquecedor.Schema.create(
      module_name,
      "users",
      [
        {:name, :string},
        {:email, :string}
      ],
      %{
        name: %{required: true}
      }
    )
  end
end
