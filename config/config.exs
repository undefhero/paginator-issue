import Config

config :paginator_issue, PaginatorIssue.Repo,
  database: "paginator_issue_repo",
  username: "postgres",
  password: "postgres",
  hostname: "localhost"


config :paginator_issue, ecto_repos: [PaginatorIssue.Repo]
