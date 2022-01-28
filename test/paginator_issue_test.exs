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
    query = from(u in User, order_by: [asc: u.email, asc: u.id], select: %{user: u})

    assert %Paginator.Page{metadata: %{after: after_cursor}} =
      Repo.paginate(query, limit: 5, cursor_fields: [email: :asc, id: :asc], fetch_cursor_value_fun: fn
        map, key -> Map.get(map.user, key)
      end)

    assert %{email: email, id: id} = :erlang.binary_to_term(Base.decode64!(after_cursor))
    assert is_binary(email) and is_binary(id)

    assert %Paginator.Page{metadata: %{after: after_cursor, before: before_cursor}} =
      Repo.paginate(query, after: after_cursor)

    assert after_cursor == before_cursor
    assert %{email: nil, id: nil} = :erlang.binary_to_term(Base.decode64!(after_cursor))
  end
end
