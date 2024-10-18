defmodule DataStruct do
  defstruct select: [], from: [], where: []

  defimpl String.Chars do
    def to_string(%DataStruct{select: select, from: from, where: where}) do
      "#{select}, #{from}, #{where}}"
    end
  end
end