defmodule MacroEnriquecedor.Mysql.Repo do
  use Ecto.Repo,
    otp_app: :data_orchestrator,
    adapter: Ecto.Adapters.MyXQL
end
