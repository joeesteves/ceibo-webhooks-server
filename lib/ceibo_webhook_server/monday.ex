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
    [item | _] = get_in(redmineable.data, ~w(data items))

    {:ok,
     %{
       issue: %{
         project_id: CeiboWebhookServer.Redmine.project_id("isowean"),
         subject: item["name"],
         description: pulse_url(item["board"]["id"], item["id"])
       }
    }}
  end

  defp assigned_to_value(data, assigned_to_pattern) do
    persons = get_in(data, ~w(value personsAndTeams))

    Enum.any?(persons, fn person ->
      ~s(#{Map.get(person, "id")}) |> String.match?(assigned_to_pattern)
    end)
  end

  defp pulse_url(board_id, pulse_id) do
    "https://isowean.monday.com/boards/#{board_id}/pulses/#{pulse_id}"
  end
end
