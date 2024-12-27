defmodule DataOrchestratorWeb.Orchestrator do
  alias DataOrchestratorWeb.Orchestrator.DataOrchestratorWeb.Orchestrator.Schema
  require MacroEnriquecedor.Schema
  use DataOrchestratorWeb, :controller

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
    Schema.build(data["schema_name"], table, data["fields"])
    {:ok, %{msg: "success", data: %{}}}
  end

  defp by_action("select", source, table, data) do
    Schema.build(data["schema_name"], table, data["fields"])
    {:ok, %{msg: "success", data: []}}
  end

  defp by_action("delete", source, table, data) do
    Schema.build(data["schema_name"], table, data["fields"])
    {:ok, %{msg: "Deleted"}}
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
        [],
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
