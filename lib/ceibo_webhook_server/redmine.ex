defmodule CeiboWebhookServer.Redmine do

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

defprotocol CeiboWebhookServer.Redminable do
  def is_assigned_to(asigned_to_pattern, data)
  def card(data)
end
