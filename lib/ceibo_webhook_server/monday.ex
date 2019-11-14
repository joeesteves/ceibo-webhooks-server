defmodule CeiboWebhookServer.Monday do
  defstruct [:data]

end

defimpl CeiboWebhookServer.Redminable, for: CeiboWebhookServer.Monday do
  def is_assigned_to(remineable, assigned_to_pattern) do
    column = get_in(remineable, ~w(event columnId))

    (column == "person" &&
       assigned_to_value(remineable) |> String.match?(assigned_to_pattern) &&
       {:ok, remineable}) ||
      {:filtered}
  end

  def card(remineable) do
    pulse = get_in(remineable, ~w(remineable items)) |> List.first

    {:ok,
     %{
       issue: %{
         project_id: CeiboWebhookServer.Redmine.proyect_id("isowean"),
         subject: Map.get(pulse, "name"),
         description: Map.get(pulse, "url")
       }
    }}
  end

  defp assigned_to_value(remineable) do
    person = get_in(remineable, ~w(value personsAndTeams)) |> List.first
    id = ~s(#{Map.get(person,"id")})
  end
end
