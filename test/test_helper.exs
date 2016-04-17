ExUnit.start

Mix.Task.run "ecto.create", ~w(-r ElmBlogger.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r ElmBlogger.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(ElmBlogger.Repo)

