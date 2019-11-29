defmodule ExAliyunAmqp.MixProject do
  use Mix.Project

  def project do
    [
      app: :ex_aliyun_amqp,
      version: "0.1.0",
      elixir: "~> 1.7",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      description: description(),
      package: package(),
      deps: deps(),
      docs: docs(),
      source_url: "https://github.com/edragonconnect/ex_aliyun_amqp"
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:amqp, "~> 1.3"},
      {:ex_doc, "~> 0.21.2", only: :dev, runtime: false}
    ]
  end

  defp description do
    "Aliyun AMQP SDK for Elixir/Erlang"
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README.md", "LICENSE.md"],
      maintainers: ["Naupio Z.Y Huang", "Xin Zou"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/edragonconnect/ex_aliyun_amqp"}
    ]
  end

  defp docs do
    [main: "readme",
     formatter_opts: [gfm: true],
     extras: [
       "README.md"
     ]]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]
end
