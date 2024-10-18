config :posgrest,
       MacroEnriquecedor.Repo,
       username: "",
       password: "",
       database: "",
       hostname: "",
       pool_size: 10,
       after_connect: {Postgrex, :query!, query_args}