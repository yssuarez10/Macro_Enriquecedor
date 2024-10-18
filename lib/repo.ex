defmodule MacroEnriquecedor.Repo do
  use Ecto.Repo,
      otp_app: :mi_app,
      adapter: Ecto.Adapters.Postgres

  def start_link(opts) do
    Ecto.Repo.start_link(__MODULE__, opts)
  end
end