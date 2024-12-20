defmodule MacroEnriquecedor.Schema do
  require MacroEnriquecedor.Validator
  import Ecto.Changeset
  import Ecto.Query

  defmacro create(schema_name, fields, validations) do
    quote do
      defmodule unquote(schema_name) do
        use Ecto.Schema
        import Ecto.Changeset

        schema unquote(to_string(schema_name)) do
          # Iterar sobre los campos y generar campos de acuerdo a los datos
          for {field, type} <- unquote(fields) do
            field(unquote(field), unquote(type))
          end

          MacroEnriquecedor.Validator.build(unquote(validations))
        end
      end
    end
  end
end
