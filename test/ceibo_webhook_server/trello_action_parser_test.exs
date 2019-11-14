defmodule TrelloActionParserTest do
  use ExUnit.Case
  Code.require_file("test/data/trello_action.exs")

  alias CeiboWebhookServer.TrelloActionParser

  describe "trello parser" do
    test "addMemeber && Esteves" do
      data = MockData.trello_card()

      assert {:ok, _} = TrelloActionParser.filter(data)
    end

    test "addMemeber && not Esteves" do
      data = MockData.trello_card_wrong_member()

      assert {:filtered} == TrelloActionParser.filter(data)
    end

    test "parse ok card" do
      data = MockData.trello_card()

      assert {:ok, card} = TrelloActionParser.filter(data) |> TrelloActionParser.parse() |> IO.inspect
      assert (~w(project_id subject)a -- Map.keys(card.issue)) == []
    end

    test "parse filtered" do
      data = MockData.trello_card_wrong_member()

      assert {:filtered} == TrelloActionParser.filter(data) |> TrelloActionParser.parse()
    end
  end
end
