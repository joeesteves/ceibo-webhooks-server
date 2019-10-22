defmodule CeiboWebhookServerWeb.Router do
  use CeiboWebhookServerWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/trello", CeiboWebhookServerWeb do
    pipe_through :api
    post "/", TrelloController, :index
  end

  scope "/monday", CeiboWebhookServerWeb do
    pipe_through :api
    post "/", MondayController, :index
  end
end
