defmodule CeiboWebhookServerWeb.MondayController do
  use CeiboWebhookServerWeb, :controller
  alias CeiboWebhookServer.{Redmine, Monday}

  def index(conn, params) do
    monday_hook = %Monday{data: params}

    case Redmine.is_assigned_to(monday_hook, "10652967") do
      {:ok, redminable} ->
        redminable
        |>Monday.fetch_pulse
        |> Redmine.card
        |> Redmine.post
      _ -> false
    end

    json(conn, "thanks for the hook")
  end
end
