defmodule CeiboWebhookServer.TrelloActionParser do
  def parse(data) do
    action = get_in(data, ["action", "type"])

    if action == "addMemberToCard" do
      member_name = get_in(data, ["action", "data", "member", "name"])

      String.match?(member_name, ~r/Esteves/) && {:ok} || {:filtered}
    else
      {:filtered}
    end
  end
end
