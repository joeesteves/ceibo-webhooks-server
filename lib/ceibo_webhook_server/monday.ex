defmodule CeiboWebhookServer.Monday do
  defstruct [:data]

end

defimpl CeiboWebhookServer.Redminable, for: CeiboWebhookServer.Monday do
  def is_assigned_to(redmineable, assigned_to_pattern) do
    data = get_in(redmineable.data, ~w(event))
    column = get_in(data, ~w(columnId))

    (column == "person" &&
       assigned_to_value(data, assigned_to_pattern) &&
       {:ok, redmineable}) ||
      {:filtered}
  end

  def card(redmineable) do
    pulse = get_in(redmineable, ~w(remineable items)) |> List.first

    {:ok,
     %{
       issue: %{
         project_id: CeiboWebhookServer.Redmine.project_id("isowean"),
         subject: Map.get(pulse, "name"),
         description: Map.get(pulse, "url")
       }
    }}
  end

  defp assigned_to_value(data, assigned_to_pattern) do
    persons = get_in(data, ~w(value personsAndTeams))

    Enum.any?(persons, fn person ->
      ~s(#{Map.get(person, "id")}) |> String.match?(assigned_to_pattern)
    end)
  end
end
