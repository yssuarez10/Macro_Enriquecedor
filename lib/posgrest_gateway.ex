#defmodule PosgrestGateway do
#  import Ecto.Query
#  require Logger
#
#  def find_data({} = data) do
#    query =
#      from(i in data.source,
#        where: i.data == ^data.where,
#        select: %{
#          data.select
#        }
#      )
#    Repo.all(query)
#    |> extract()
#  end
#
#  defp extract([]), do: {:error, :data_not_found}
#  defp extract(result) when is_list(result), do: {:ok, result |> List.first()}
#  defp extract(nil), do: {:error, :data_not_found}
#  defp extract(error), do: {:error, error}
#end