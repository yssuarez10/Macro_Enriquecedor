defmodule DataOrchestratorWeb.Orchestrator do
  alias DataOrchestratorWeb.Orchestrator.DataOrchestratorWeb.Orchestrator.Schema
  require MacroEnriquecedor.Schema
  use DataOrchestratorWeb, :controller
  import Ecto.Query
  alias User

  defp where(conditions) do
    IO.inspect(conditions, label: "reduce")
    Enum.map(conditions, fn x -> conditions(x) end)
   # Enum.reduce(conditions, [], fn e, acc -> [conditions["value"] | acc] end)
  end

  defp conditions(%{"field" => field, "operator" => operator, "value" => value}) do
    IO.inspect("#{field}, #{operator}, #{value}", label: "Cualquier simple")
  end

  defp conditions(%{"operator" => operator, "conditions" => conditions}) do
    IO.inspect(operator, label: "Operator")
    IO.inspect(conditions, label: "condiciones agrupada")
    where(conditions)
  end

  defp conditions(data) do
    IO.inspect(data, label: "Error, no se reconoció la condicion")
  end

  def execute(conn, params) do
    {:ok, response} =
      by_action(
        params["action"],
        params["source"],
        params["table"],
        params["data"]
      )
    json(conn, response)
  end

  defp by_action("upsert", source, table, data) do
    schema = Schema.build(data["schema_name"], table, data["fields"])
    where(data["where"])
    {:ok, %{msg: "success", data: []}}
  end

  defp by_action("select", source, table, data) do
    Schema.build(data["schema_name"], table, data["fields"])
    operator = data["operator"]
    select_fields = data["fields"]
    condition = data["condition"]
    IO.inspect(select_fields)
    case operator do
      "AND" -> {:ok, MacroEnriquecedor.Mysql.Repo.all(
        from u in table,
        select: ^Enum.map(select_fields, fn item -> String.to_atom(item["column_name"]) end),
        where: u.name in ^Enum.map(data["condition"], fn condition -> condition["value"] end))}
      "OR" -> {:ok, MacroEnriquecedor.Mysql.Repo.all(
        from u in table,
        select: ^Enum.map(select_fields, fn item -> String.to_atom(item["column_name"]) end),
        where: ^Enum.reduce(Enum.map(condition, fn conditions -> conditions["value"] end), dynamic(false), fn name, acc -> dynamic([u], ^acc or u.name == ^name) end))}
      _-> {:ok, MacroEnriquecedor.Mysql.Repo.all(
        from u in table,
        select: ^Enum.map(select_fields, fn item -> String.to_atom(item["column_name"]) end))}
    end
#    {:ok, %{msg: "success", data: []}}
  end

  defp by_action("delete", source, table, data) do
    Schema.build(data["schema_name"], table, data["fields"])
#    query = from u in table, where: ^data["search_field"] in ^Enum.map(data["condition"], fn condition -> condition["value"] end)
#    query = from u in table, where: u.name in ["a", "fgdfh"]
#    MacroEnriquecedor.Mysql.Repo.delete_all(query)
    {:ok, %{msg: "success", data: []}}
  end

  defp by_action(other, _source, _table, _data) do
    {:ok, %{msg: "#{other}: Invalid action"}}
  end

  defmodule DataOrchestratorWeb.Orchestrator.Schema do
    def build(schema_name, table, fields) do
      module_name = String.to_atom(schema_name)

      if Code.ensure_loaded?(module_name) do
        IO.puts("Module exist /// Recycling...")
        module_name
      else
        IO.puts("New module generated #{schema_name}")

        new_fields =
          fields
          |> Enum.map(fn x ->
            {
              String.to_atom(x["column_name"]),
              String.to_atom(x["type"])
            }
          end)

        new_module(module_name, table, new_fields)
      end
    end

    def build(_other) do
      IO.puts("Invalid schema")
    end

    defp new_module(module_name, table, fields) do
      # Inspeccionamos los campos generados para depuración
      IO.inspect(fields, label: "Campos generados")

      list = ensure_list(fields)

      MacroEnriquecedor.Schema.create(
        module_name,
        "users",
        # TODO: no está dejando pasar a lista de campos dinamicamente
        [
          {:name,:string},
          {:email,:string}
        ],
        %{
          name: %{required: true}
        }
      )
    end

    defp ensure_list(list) do
      if is_enumerable?(list) do
        list
      else
        []
      end
    end

    def is_enumerable?(variable) do
      Enumerable.impl_for(variable) != nil
    end
  end
end