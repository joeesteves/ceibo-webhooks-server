defprotocol CeiboWebhookServer.Redminable do
  def is_assigned_to(redminable, data)
  def card(redminable)
end

defmodule CeiboWebhookServer.Redmine do
  alias CeiboWebhookServer.Redminable

  def is_assigned_to(redmineable, pattern) do
    Redminable.is_assigned_to(redmineable, pattern)
  end

  def card(redmineable) do
    Redminable.card(redmineable)
  end

  def post({:ok, card}) do
    HTTPoison.post(
      Application.get_env(:ceibo_webhook_server, :redmine_url),
      card |> Jason.encode!(),
      [
        {"content-type", "application/json"},
        {"X-Redmine-API-Key", Application.get_env(:ceibo_webhook_server, :redmine_key)}
      ]
    )
  end

  def post(_), do: false

  def project_id(name) do
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
end
