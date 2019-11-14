defmodule CeiboWebhookServer.Monday do
  defstruct [:data]

  alias CeiboWebhookServer.Monday

  def fetch_pulse(redmineable) do
    response =
      HTTPoison.post!(
        Application.get_env(:ceibo_webhook_server, :monday_url),
        pulse_id(redmineable) |> graphql(),
        [
          {"content-type", "application/json"},
          {"Authorization", Application.get_env(:ceibo_webhook_server, :monday_token)}
        ]
      )

    data = response.body |> Jason.decode!
    %Monday{data: data}
  end

  def post(card) do
    HTTPoison.post(
      Application.get_env(:ceibo_webhook_server, :redmine_url),
      card |> Jason.encode!(),
      [
        {"content-type", "application/json"},
        {"X-Redmine-API-Key", Application.get_env(:ceibo_webhook_server, :redmine_key)}
      ]
    )
  end

  defp graphql(pulse_id) do
    ~s({"query":"{items(ids: [#{pulse_id}], limit:1\){id name board{id}}}"})
  end

  defp pulse_id(redmineable) do
    data = get_in(redmineable.data, ~w(event pulseId))
  end
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
