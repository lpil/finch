defmodule Finch.Mixfile do
  use Mix.Project

  def project do
    [
      app: :finch,
      version: "0.0.1",
      elixir: "~> 1.0",
      elixirc_paths: elixirc_paths(Mix.env),
      compilers: [:phoenix] ++ Mix.compilers,
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      aliases: aliases,
      deps: deps,
    ]
  end

  def application do
    [
      mod: {Finch, []},
      applications: ~w(
        phoenix phoenix_html cowboy logger phoenix_ecto postgrex
      )a
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_),     do: ["lib", "web"]

  defp deps do
    [
      # Web framework
      {:phoenix, "~> 1.0.3"},
      # Database wrapper
      {:phoenix_ecto, "~> 1.1"},
      # Database connector
      {:postgrex, ">= 0.0.0"},
      # HTML view layer
      {:phoenix_html, "~> 2.1"},
      # Frontend refreshing
      {:phoenix_live_reload, "~> 1.0", only: :dev},
      # Web server
      {:cowboy, "~> 1.0"},

      # Style linting
      {:dogma, "~> 0.0"},
      # Automatic test runner
      {:mix_test_watch, "~> 0.0"},
    ]
  end

  defp aliases do
    [
      "ecto.seed": ["run priv/repo/seeds.exs"],
      "ecto.setup": ~w[ecto.create ecto.migrate ecto.seed],
      "ecto.reset": ~w[ecto.drop ecto.setup],
    ]
  end
end
