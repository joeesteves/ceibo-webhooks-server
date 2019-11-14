defprotocol CeiboWebhookServer.Redminable do
  def is_assigned_to(redminable, data)
  def card(redminable)
end

defmodule CeiboWebhookServer.Redmine do
  alias CeiboWebhookServer.Redminable

  def is_assigned_to(redmineable, pattern) do
    Redminable.is_assigned_to(redmineable, pattern)
  end

  def card(remineable) do
    false
  end

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
