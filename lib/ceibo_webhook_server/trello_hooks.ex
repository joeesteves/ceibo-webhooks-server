defmodule CeiboWebhookServer.TrelloHooks do
  def create(model_id, project_redmine_name) do
    token = Application.get_env(:ceibo_webhook_server, :trello_token)
    key = Application.get_env(:ceibo_webhook_server, :trello_key)

    HTTPoison.post(
      "https://api.trello.com/1/tokens/#{token}/webhooks/",
      %{
        key: key,
        callbackURL: "http://hooks.ceibo.co/trello?project=#{project_redmine_name}",
        idModel: model_id,
        description: "#{project_redmine_name} redmine hook"
      }
      |> Jason.encode!(),
      [{"content-type", "application/json"}]
    )
    |> IO.inspect
  end
end
