defmodule PokemonRepo do
  @moduledoc """
  Fetches pokemon data from the pokeapi.
  Docs: https://pokeapi.co/docs/v2#pokemon
  """

  @move_fields ~w(id name accuracy effect_chance pp)
  @pokemon_fields ~w(id name base_experience is_default)
  @pokemon_url "https://pokeapi.co/api/v2/pokemon/"

  @spec get_pokemon(String.t()) :: {:ok, map} | {:error, any}
  def get_pokemon(id_or_name) do
    with {:ok, %{body: body, status_code: 200}} <- HTTPoison.get(@pokemon_url <> id_or_name),
         {:ok, %{"moves" => moves_resources} = pokemon} <- Jason.decode(body),
         {:ok, moves} <- get_moves(moves_resources) do
      {:ok,
       @pokemon_fields
       |> to_atom_map(pokemon)
       |> Map.put(:moves, moves)}
    else
      {:ok, sneaky_error} -> {:error, sneaky_error}
      error -> error
    end
  end

  defp get_moves(moves) do
    fetched_moves =
      moves
      |> Enum.take(3)
      |> Enum.map(fn %{"move" => %{"url" => url}} -> get_move(url) end)
      |> Enum.reject(&match?({:error, _}, &1))

    {:ok, fetched_moves}
  end

  def get_move(resource) do
    with {:ok, %{body: body, status_code: 200}} <- HTTPoison.get(resource),
         {:ok, move} <- Jason.decode(body) do
      to_atom_map(@move_fields, move)
    end
  end

  defp to_atom_map(allowed_fields, map) do
    map
    |> Map.take(allowed_fields)
    |> Map.new(fn {key, val} -> {String.to_atom(key), val} end)
  end
end
