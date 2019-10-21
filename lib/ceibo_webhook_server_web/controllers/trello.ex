defmodule CeiboWebhookServerWeb.TrelloController do
  use CeiboWebhookServerWeb, :controller

  def index(conn, params) do
    IO.inspect params
    json(conn, "HOLA MUNDO")
  end
end
