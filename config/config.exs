# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :data_orchestrator,
  generators: [timestamp_type: :utc_datetime]

# Configures the endpoint
config :data_orchestrator, DataOrchestratorWeb.Endpoint,
  url: [host: "localhost"],
  adapter: Bandit.PhoenixAdapter,
  render_errors: [
    formats: [json: DataOrchestratorWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: DataOrchestrator.PubSub,
  live_view: [signing_salt: "d5gH/OC8"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :data_orchestrator, DataOrchestrator.Mailer, adapter: Swoosh.Adapters.Local

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"

config :my_sql, MySQL.Repo,
  username: "usuario",
  password: "secret",
  database: "elixir",
  hostname: "db",
  port: 3306,
  show_sensitive_data_on_connection_error: true,
  pool_size: 10
