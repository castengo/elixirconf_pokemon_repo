defmodule PokemonRepo.PokemonService.Server do
  @moduledoc """
  Pokeapi Pokemon Service Server.

  Test by going to pokemon proto and running:
  `grpcurl -plaintext -proto pokeapi/pokemon.proto -d '{"name": "pikachu"}' localhost:8080 pokeapi.PokemonService.GetPokemon`
  """
  use GRPC.Server, service: Pokeapi.PokemonService.Service

  alias Pokeapi.{
    GetPokemonRequest,
    GetPokemonResponse,
    Pokemon
  }

  require Logger

  def get_pokemon(%GetPokemonRequest{name: name}, _stream) do
    with {:ok, pokemon} <- PokemonRepo.get_pokemon(name) do
      GetPokemonResponse.new(pokemon: Pokemon.new(pokemon))
    else
      _error ->
        Logger.info("Did not find pokemon named #{name}")
        GetPokemonResponse.new()
    end
  end
end
