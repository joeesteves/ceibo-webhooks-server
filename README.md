# To create new trello hooks

```bash
$> iex -S mix
$> CeiboWebhookServer.TrelloHooks.create(model_id, redmine_project_alias)

```

* Must have TRELLO_KEY and TRELLO_TOKEN as env variables

* Also project must be listed on trello_action_parser

```elixir
  defp redmine_project_id(name) do
    %{
      "bar" => 11,
      "ceibo" => 2,
      "batogo" => 3,
      "crosshero" => 9,
      "isowean" => 10,
      "lucius" => 5,
      "mu" => 4,
      "zonatic" => 8,
      "innopor" => 12
    }
    |> Map.get(name)
  end
```

To add new remine proyects check pm.ceibo.co/projects.json?key=#{redmine_key}

To get trello model_id add .json to board url
