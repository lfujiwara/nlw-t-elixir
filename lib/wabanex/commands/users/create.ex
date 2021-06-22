defmodule Wabanex.Commands.Users.Create do
  alias Wabanex.{Repo, Schema.User}

  def call(params) do
    params
    |> User.changeset()
    |> Repo.insert()
  end
end
