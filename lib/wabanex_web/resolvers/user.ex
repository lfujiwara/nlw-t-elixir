defmodule WabanexWeb.Resolvers.User do
  def get(%{id: user_id}, _ctx), do: Wabanex.Queries.Users.Get.call(user_id)
  def create(%{input: params}, _ctx), do: Wabanex.Commands.Users.Create.call(params)
end
