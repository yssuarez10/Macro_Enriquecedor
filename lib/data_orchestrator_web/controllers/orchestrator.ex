defmodule DataOrchestratorWeb.Orchestrator do
  require MacroEnriquecedor.Schema
  use DataOrchestratorWeb, :controller
  import Ecto.Query

  def upsert(conn, params) do
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
    json(conn, %{id: "hola upsert"})
  end

  def select(conn, params) do
    module_name = String.to_atom(params["select"]["table"])
    if Code.ensure_loaded?(module_name) do
      IO.puts("El módulo #{module_name} existe")
      IO.inspect(module_name)
    else
      IO.puts("El módulo #{module_name} no existe")
      schema = new_module(module_name)
      IO.inspect(schema)
    end
    IO.inspect(get_query(params))
#    data = MacroEnriquecedor.Mysql.Repo.all(module_name)
#    IO.inspect(data)
    json(conn, %{id: "hola select"})
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

  defp get_dynamic_fields_schema(%{"select" => %{"where" => %{"conditions" => fields}}}) do
    Enum.map(fields, fn field ->
      {field["field"], field["type"]}
    end)
  end

  defp get_query(data) do
    table = data["select"]["table"]
    fields = data["select"]["data"]["fields"]
    conditions = data["select"]["where"]["conditions"]
    operator = data["select"]["where"]["operator"]
    case operator do
      "AND" -> MacroEnriquecedor.Mysql.Repo.all(from u in table, select: ^Enum.map(fields, &String.to_atom(&1)), where: u.name in ^Enum.map(conditions, fn condition  -> condition["value"] end))
      "OR" -> MacroEnriquecedor.Mysql.Repo.all(from u in table, select: ^Enum.map(fields, &String.to_atom(&1)), where: ^Enum.reduce(Enum.map(conditions, fn condition  -> condition["value"] end), dynamic(false), fn name, acc -> dynamic([u], ^acc or u.name == ^name) end))
      _ -> MacroEnriquecedor.Mysql.Repo.all(from u in table, select: ^fields)
    end
  end
end