defmodule DataOrchestratorWeb.Orchestrator do
  use DataOrchestratorWeb, :controller

  def show(conn, params) do
    IO.inspect(params)

    json(conn, %{id: "hola"})
  end
end
