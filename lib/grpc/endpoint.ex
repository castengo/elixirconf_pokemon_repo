defmodule PokemonRepo.Endpoint do
  use GRPC.Endpoint

  intercept(GRPC.Logger.Server)
  run(PokemonRepo.PokemonService.Server)
end
