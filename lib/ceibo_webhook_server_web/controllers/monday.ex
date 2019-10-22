defmodule CeiboWebhookServerWeb.MondayController do
  use CeiboWebhookServerWeb, :controller
  alias CeiboWebhookServer.TrelloActionParser

  def index(conn, params) do
    IO.inspect(params)
    json(conn, params)
  end
end
