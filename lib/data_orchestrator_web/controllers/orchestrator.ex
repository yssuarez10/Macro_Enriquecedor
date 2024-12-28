defmodule DataOrchestratorWeb.Orchestrator do
  use DataOrchestratorWeb, :controller
  require MacroEnriquecedor.Schema

  def execute(conn, _params) do
    users = MacroEnriquecedor.Mysql.Repo.all(MacroEnriquecedor.Schemas.Usuario)
    json(conn, users |> Enum.map(fn x -> %{id: x.id, name: x.name, email: x.email} end))
  end
end
