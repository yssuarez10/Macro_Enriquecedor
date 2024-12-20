defmodule Program do
  alias User
  alias MySQL.Repo
  import Cnx
  alias DataConnections

  def newUser(params, name, email) do
#    {:ok, _pid} = build(params)
    %User{}
    |> User.changeset(%{name: name, email: email})
    |> MySQL.Repo.insert()
    |> case do
        {:ok, user} ->
           IO.puts("Usuario creado: #{user.name}")
           {:ok, user}
        {:error, changeset} ->
           IO.puts("Error al crear el usuario: #{inspect(changeset.errors)}")
           {:error, changeset}
#        Process.exit(_pid, :normal)
    end
  end

#    def newUser(configs, name, email) do
#      %User{}
#      |> User.changeset(%{name: name, email: email})
#      |> MySQL.Repo.insert()
#      |> case do
#        {:ok, user} ->
#          IO.puts("Usuario creado: #{user.name}")
#          {:ok, user}
#        {:error, changeset} ->
#          IO.puts("Error al crear el usuario: #{inspect(changeset.errors)}")
#          {:error, changeset}
#        end
#      end

end