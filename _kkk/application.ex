defmodule MacroEnriquecedor.Application do

  use Application

  def start(_type, _args) do
    children = [
#      MySQL.Repo,
#      Posgrest.Repo
    ]

    opts = [strategy: :one_for_one, name: Supervisor]
    Supervisor.start_link(children, opts)
  end
end