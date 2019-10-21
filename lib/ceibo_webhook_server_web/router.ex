defmodule CeiboWebhookServerWeb.Router do
  use CeiboWebhookServerWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/trello", CeiboWebhookServerWeb do
    pipe_through :api
    get "/", TrelloController, :index
    post "/", TrelloController, :index
  end
end
