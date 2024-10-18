defmodule MacroMain do
  defmacro defenriquecer(fuente, data) do
    quote do
        "Hola, voy a enriquecer en una BD: #{unquote(fuente)} con la data: #{unquote(data)}"
    end
  end
end

defmodule Cnx do
  require MacroEnriquecedor.Repo
  def initCnx(:posgrest, database, host, username, pass, port) do
    {:ok, :posgrest, cnx} -> Repo.star_link(database, host, username, pass, port)
  end
  
  def initCnx(:oracle, database, host, username, pass, port) do
    {:ok, :oracle, cnx} -> Repo.star_link(database, host, username, pass, port)
  end
end