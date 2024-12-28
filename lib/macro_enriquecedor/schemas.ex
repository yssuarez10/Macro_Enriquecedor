defmodule MacroEnriquecedor.Schemas do
  require MacroEnriquecedor.Schema
  require MacroEnriquecedor.Validator

  MacroEnriquecedor.Schema.create(
    Usuario,
    "users",
    [
      {:name, :string},
      {:email, :string},
      {:inserted_at, :naive_datetime},
      {:updated_at, :naive_datetime}
    ],
    %{
      name: %{
        require: true,
        length: %{
          min: 2,
          max: 3
        }
      },
      email: %{
        required: true,
        unique: true,
        length: %{
          min: 3,
          max: 15
        }
      }
    }
  )
end
