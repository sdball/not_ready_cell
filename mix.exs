defmodule NotReadyCell.MixProject do
  use Mix.Project

  def project do
    [
      app: :not_ready_cell,
      version: "0.1.0",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      mod: {NotReadyCell.Application, []}
    ]
  end

  defp deps do
    [
      {:kino, "~> 0.6.1"}
    ]
  end
end
