defmodule PaginatorIssue.User do
  use Ecto.Schema

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "users" do
    field :first_name, :string
    field :last_name, :string
    field :email, :string

    timestamps()
  end
end
