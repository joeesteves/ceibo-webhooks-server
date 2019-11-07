defmodule CeiboWebhookServer.Monday do
  defstruct [:data]

end

defimpl CeiboWebhookServer.Redminable, for: CeiboWebhookServer.Monday do
  def is_assigned_to(asigned_to_pattern, data) do
    column = get_in(data, ~w(event columnId))

    (column == "person" &&
       assigned_to_value(data) |> String.match?(assigned_to_pattern) &&
       {:ok, data}) ||
      {:filtered}
  end

  def card(data) do
    pulse = get_in(data, ~w(data items)) |> List.first

    {:ok,
     %{
       issue: %{
         project_id: CeiboWebhookServer.Redmine.proyect_id("isowean"),
         subject: Map.get(pulse, "name"),
         description: Map.get(pulse, "url")
       }
    }}
  end

  defp assigned_to_value(data) do
    person = get_in(data, ~w(value personsAndTeams)) |> List.first
    id = ~s(#{Map.get(person,"id")})
  end
end
