defmodule DataOrchestrator.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      DataOrchestratorWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:data_orchestrator, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: DataOrchestrator.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: DataOrchestrator.Finch},
      # Start a worker by calling: DataOrchestrator.Worker.start_link(arg)
      # {DataOrchestrator.Worker, arg},
      # Start to serve requests, typically the last entry
      DataOrchestratorWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: DataOrchestrator.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    DataOrchestratorWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
