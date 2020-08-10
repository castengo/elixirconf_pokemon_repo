defmodule PokemonRepo.MixProject do
  use Mix.Project

  def project do
    [
      app: :pokemon_repo,
      version: "0.1.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {PokemonRepo.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:pokemon_proto, github: "castengo/elixirconf_pokemon_proto"},
      # used to get pokemon from pokemon api
      {:httpoison, "~> 1.6"},
      {:jason, "~> 1.2"}
    ]
  end
end
