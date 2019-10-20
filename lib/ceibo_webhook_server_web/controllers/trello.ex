defmodule CeiboWebhookServerWeb.TrelloController do
  use CeiboWebhookServerWeb, :controller

  def index(conn, _params) do
    json(conn, "HOLA MUNDO")
  end
end
