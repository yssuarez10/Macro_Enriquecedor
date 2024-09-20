defmodule Main do
  defstruct select: [], where: [], source: []

  def cnx (:oracle) do
    conn = :odbc
    {:ok, conn}
  end

  def cnx (:dynamo) do
    conn = :arn
    {:ok, conn}
  end

  def select(select= [], field) do
    {:ok, select ++ [field]}
  end
  def select(select= [], field = []) do
    select ++ field
  end

  defmodule Where do
    defstruct campo1: "", campo2: "", comparador: "", join: ""
    def new(campo1, comparador, campo2) do
      {:ok, [%Where{campo1: campo1, campo2: campo2, comparador: comparador, join: ""}]}
    end
    def addAnd(where = [], campo1, comparador, campo2) do
      {:ok, where ++ [%Where{campo1: campo1, campo2: campo2, comparador: comparador, join: :and}]}
    end

    def addOr(where = [], campo1, comparador, campo2) do
      {:ok, where ++[%Where{campo1: campo1, campo2: campo2, comparador: comparador, join: :or}]}
    end

  end
  def find(%Main{} = main) do
    cond do
      :oracle
      sql = buildSQL(:oracle, main)

      conex.excec(sql)

      :dynamo
      sql = buildSQL(:dynamo, main)
    end

  end

  defp buildSQL(:oracle, %Main{} = main) do
    '''
    SELECT #{Enum.join(main.select, ", ")} // id, name, phone, address
    WHERE
      #{Enum.each(main.where, fn %Where{} = where """
#{where.join} #{where.campo1} #{where.comparador} #{where.campo2}
""" end)}
'''
  end

end

prueba = Main

conex = prueba.cnx(:dynamo)

{:ok, select} = prueba.select([], 'id')
{:ok, select} = prueba.select(select, 'name')


{:ok, select} = prueba.select([],['id', 'name'])
{:ok, select} = prueba.select([],['address'])

{:ok, select} = prueba.select(select, 'phone')


{:ok, where} = prueba.Where.add("id", "=", "1234")
{:ok, where} = prueba.Where.addAnd("name", "!=", "Yeison")

prueba.find()
