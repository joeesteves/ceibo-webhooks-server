defmodule CeiboWebhookServer.TrelloActionParser do
  def filter(data) do
    action = get_in(data, ~w(action type))

    (action == "addMemberToCard" &&
       get_in(data, ~w(action data member name)) |> String.match?(~r/Esteves/) &&
       {:ok, data}) ||
      {:filtered}
  end

  def parse({:ok, data}) do
    card = get_in(data, ~w(action card))

    {:ok,
     %{
       issue: %{
         project_id: redmine_project_id("ceibo"),
         subject: card["name"]
       }
     }}
  end

  def parse(status), do: status

  def redmine_project_id(name) do
    %{
      "ceibo" => 2
    }
    |> Map.get(name)
  end
end
