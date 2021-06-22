defmodule Wabanex.Queries.Users.Get do
  alias Wabanex.{Repo, Schema.User}

  def call(id) do
    id
    |> Ecto.UUID.cast()
    |> handle_response()
  end

  defp handle_response(:error) do
    {:error, "INVALID_UUID"}
  end

  defp handle_response({:ok, uuid}) do
    case Repo.get(User, uuid) do
      nil -> {:error, "USER_NOT_FOUND"}
      user -> {:ok, user}
    end
  end
end
