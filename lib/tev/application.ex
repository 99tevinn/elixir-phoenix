defmodule Tev.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      TevWeb.Telemetry,
      Tev.Repo,
      {DNSCluster, query: Application.get_env(:tev, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Tev.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Tev.Finch},
      # Start a worker by calling: Tev.Worker.start_link(arg)
      # {Tev.Worker, arg},
      # Start to serve requests, typically the last entry
      TevWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Tev.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    TevWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
