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

_To add new remine proyects check pm.ceibo.co/projects.json?key=#{redmine_key}_

_To get trello model_id add .json to board url_

## Create TrelloHook

curl -X POST -H "Content-Type: application/json" \
https://api.trello.com/1/tokens/f02829cf05b39125377a641b1cd3e41681e23f3f1bb5c8aa81a5c9eb7de7f508/webhooks/ \
-d '{
  "key": "b18a9b19ee35f035ad85154792b4402b",
  "callbackURL": "http://hooks.ceibo.pm/trello",
  "idModel":"5c519e1e85490d20ec6e5c51",
  "description": "My first webhook"
}'
