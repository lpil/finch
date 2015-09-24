defmodule Finch.Mixfile do
  use Mix.Project

  @version "0.0.1"

  def project do
    [
      app: :finch,
      version: @version,
      elixir: "~> 1.0",
      elixirc_paths: elixirc_paths(Mix.env),
      compilers: [:phoenix] ++ Mix.compilers,
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      deps: deps
    ]
  end

  def application do
    [
      mod: {Finch, []},
      applications: [
        :phoenix,
        :phoenix_html,
        :cowboy,
        :logger,
        :phoenix_ecto,
        :postgrex,
      ]
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_),     do: ["lib", "web"]

  defp deps do
    [
      # Web framework
      {:phoenix, "~> 1.0.2"},
      # Web server
      {:cowboy, "~> 1.0"},

      # DSL for querying DB
      {:phoenix_ecto, "~> 1.1"},
      # DB connector
      {:postgrex, ">= 0.0.0"},

      # HTML views
      {:phoenix_html, "~> 2.1"},
      # Live reload frontend changes
      {:phoenix_live_reload, "~> 1.0", only: :dev},

      # Code linter
      {:ex_spec, "~> 0.3", only: :test},

      # Code linter
      {:dogma, only: :dev},
      # Automatic test runner
      {:mix_test_watch, only: :dev},
    ]
  end
end
