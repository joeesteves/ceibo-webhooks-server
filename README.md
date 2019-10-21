# To create new trello hooks

```bash
$> iex -S mix
$> CeiboWebhookServer.TrelloHooks.create(model_id, redmine_project_alias)

```

* Must have TRELLO_KEY and TRELLO_TOKEN as env variables
* Also project must be listed on trello_action_parser

To add new remine proyects check pm.ceibo.co/projects.json?key=#{redmine_key}

To get trello model_id add .json to board url
