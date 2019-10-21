defmodule TrelloActionParserTest do
  use ExUnit.Case
  Code.require_file("test/data/trello_action.exs")

  describe "trello parser" do
    test "addMemeber && Esteves" do
      data = MockData.trello_card()

      assert CeiboWebhookServer.TrelloActionParser.parse(data) == {:ok}
    end
    test "addMemeber && not Esteves" do
      data = MockData.trello_card_wrong_member()

      assert CeiboWebhookServer.TrelloActionParser.parse(data) == {:filtered}
    end
  end
end
