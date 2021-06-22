defmodule Wabanex.Schema.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Bcrypt

  @primary_key {:id, :binary_id, autogenerate: true}

  @fields [:email, :password, :name]

  schema "users" do
    field :email, :string
    field :name, :string
    field :password, :string

    timestamps()
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @fields)
    |> validate_required(@fields)
    |> validate_length(:password, min: 6)
    |> validate_length(:name, min: 2)
    |> validate_format(:email, ~r/^[\w.!#$%&’*+\-\/=?\^`{|}~]+@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*$/i)
    |> hash_password()
    |> unique_constraint([:email])
  end

  defp hash_password(changeset) do
    changeset
    |> change(%{password: Bcrypt.hash_pwd_salt(get_field(changeset, :password, ""))})
  end
end
