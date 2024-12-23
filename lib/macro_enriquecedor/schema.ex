defmodule MacroEnriquecedor.Schema do
  require MacroEnriquecedor.Validator

  defmacro create(schema_name, table_name, fields, _validations) do
    quote do
      defmodule unquote(schema_name) do
        use Ecto.Schema
        import Ecto.Changeset

        schema unquote(to_string(table_name)) do
          (unquote_splicing(
             Enum.map(fields, fn {field, type} ->
               quote do
                 field(unquote(field), unquote(type))
               end
             end)
           ))

          # MacroEnriquecedor.Validator.build(unquote(validations))
        end
      end
    end
  end
end
