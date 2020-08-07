defmodule PokemonTest do
  use ExUnit.Case
  doctest Pokemon

  test "greets the world" do
    assert Pokemon.hello() == :world
  end
end
