defmodule PokemonRepo.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      {GRPC.Server.Supervisor, {PokemonRepo.Endpoint, 8080}}
    ]

    opts = [strategy: :one_for_one, name: PokemonRepo.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
