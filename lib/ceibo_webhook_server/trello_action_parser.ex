defmodule CeiboWebhookServer.TrelloActionParser do
  def filter(data) do
    action = get_in(data, ~w(action type))

    (action == "addMemberToCard" &&
       get_in(data, ~w(action data member name)) |> String.match?(~r/Esteves/) &&
       {:ok, data}) ||
      {:filtered}
  end

  def parse({:ok, data}) do
    project = get_in(data, ~w(project)) || "ceibo"
    card = get_in(data, ~w(action data card))
    short_link = Map.get(card, "shortLink")

    {:ok,
     %{
       issue: %{
         project_id: redmine_project_id(project),
         subject: Map.get(card, "name"),
         description: "https://trello.com/c/#{short_link}"
       }
     }}
  end

  def parse(status), do: status

  defp redmine_project_id(name) do
    %{
      "ceibo" => 2
    }
    |> Map.get(name)
  end
end
