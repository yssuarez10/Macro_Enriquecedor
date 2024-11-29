#import Config
#
#config :macro_enriquecedor, ecto_repos: [MySQL.Repo, Posgrest.Repo]
#
#config :my_sql, MySQL.Repo,
#  username: System.get_env("DB_USER") || "usuario",
#  password: System.get_env("DB_PASSWORD") || "secret",
#  database: System.get_env("DB_NAME") || "elixir",
#  hostname: System.get_env("DB_HOST") || "db",
#  port: String.to_integer(System.get_env("DB_PORT") || "3306"),
#  pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10")
#
#config :posgrest, Posgrest.Repo,
#  username: System.get_env("DB_USER") || "user",
#  password: System.get_env("DB_PASSWORD") || "user12345",
#  database: System.get_env("DB_NAME") || "meta_database",
#  hostname: System.get_env("DB_HOST") || "db",
#  port: String.to_integer(System.get_env("DB_PORT") || "5432"),
#  pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10")