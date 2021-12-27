defmodule PaginatorIssueTest do
  use ExUnit.Case
  doctest PaginatorIssue

  import Ecto.Query

  alias PaginatorIssue.Repo
  alias PaginatorIssue.User

  setup do
    1..100
    |> Enum.each(fn _ ->
      Repo.insert(%User{first_name: "string", last_name: "string", email: "string"})
    end)

    :ok
  end

  test "Having an issue here" do
    query = from(u in User, order_by: [asc: u.inserted_at, asc: u.id], select: %{user: u})

    assert %Paginator.Page{metadata: %{after: after_cursor}} = Repo.paginate(query)
    assert %Paginator.Page{metadata: %{after: ^after_cursor, before: ^after_cursor}} =
             Repo.paginate(query, after: after_cursor)
  end
end
