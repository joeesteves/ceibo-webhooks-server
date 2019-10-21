defmodule CeiboWebhookServerWeb.TrelloController do
  use CeiboWebhookServerWeb, :controller

  def index(conn, params) do
    redmine_response =
      HTTPoison.post(
        Application.get_env(:ceibo_webhook_server, :redmine_url),
        %{
          issue: %{
            project_id: 2,
            subject: "example",
          }
        } |> Jason.encode!,
        [
          {"content-type", "application/json"},
          {"X-Redmine-API-Key", Application.get_env(:ceibo_webhook_server, :redmine_key)}
        ]
      ) |> IO.inspect

    resp =
      case redmine_response do
        {:ok, %HTTPoison.Response{body: body}} ->
          body

        _ ->
          "ERROR"
      end

    json(conn, resp)
  end
end
