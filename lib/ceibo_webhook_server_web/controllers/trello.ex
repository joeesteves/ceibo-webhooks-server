defmodule CeiboWebhookServerWeb.TrelloController do
  use CeiboWebhookServerWeb, :controller
  alias CeiboWebhookServer.TrelloActionParser

  def index(conn, params) do
    parsed_card =
      TrelloActionParser.filter(params)
      |> TrelloActionParser.parse

    result =
      case parsed_card do
        {:ok, card} ->
          HTTPoison.post(
            Application.get_env(:ceibo_webhook_server, :redmine_url),
            card |> Jason.encode!(),
            [
              {"content-type", "application/json"},
              {"X-Redmine-API-Key", Application.get_env(:ceibo_webhook_server, :redmine_key)}
            ]
          )

        _ ->
          {:filtered}
      end

    resp =
      case result do
        {:ok, %HTTPoison.Response{body: body}} ->
          body

        _ ->
          "ERROR"
      end

    json(conn, resp)
  end

  def validate(conn,_params) do
    json(put_status(conn, 200), "Hey")
  end
end
