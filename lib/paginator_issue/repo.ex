defmodule PaginatorIssue.Repo do
  use Ecto.Repo,
    otp_app: :paginator_issue,
    adapter: Ecto.Adapters.Postgres

  use Paginator,
    limit: 5,
    cursor_fields: [email: :asc, id: :asc],
    include_total_count: true
end
