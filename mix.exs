defmodule Exelli.Mixfile do
  use Mix.Project

  def project do
    [app: :exelli,
     version: "0.0.1",
     elixir: "~> 1.0",
     deps: deps(Mix.env)]
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
end
