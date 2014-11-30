defmodule Exelli.Mixfile do
  use Mix.Project

  def project do
    [app: :exelli,
     version: "0.1.0",
     elixir: "~> 1.0",
     deps: deps(Mix.env),
     package: package,
     description: description]
  end

  def application do
    [applications: [:logger],
     mod: {Exelli, []}]
  end

  defp deps(:prod) do
    [{:elli, github: "knutin/elli"}]
  end

  defp deps(:test) do
    deps(:prod) ++ [{ :httpoison, "~> 0.5.0" }]
  end

  defp deps(_) do
    deps(:prod)
  end

  defp description do
    """
    Elli wrapper in elixir, with some sugar syntax. (up to 2 times faster than Plug)
    """
  end

  defp package do
    [
        files: ~w(lib mix.exs test README* LICENSE*),
        licenses: ["Apache 2.0"],
        contributors: "Jędrzej Nowak"
    ]
  end
end
