defmodule MacroEnriquecedorTest do
  use ExUnit.Case
  doctest MacroEnriquecedor

  test "greets the world" do
    assert MacroEnriquecedor.hello() == :world
  end
end
