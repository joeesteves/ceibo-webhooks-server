defmodule RedmineTest do
  use ExUnit.Case
  alias CeiboWebhookServer.{Monday, Redmine}

  describe("monday") do
    test "is_assigned_to" do
      data = %{
        "event" => %{
          "columnId" => "person",
          "value" => %{
            "personsAndTeams" => [%{"id" => 1234}]
          }
        }
      }

      redmineable = %Monday{data: data}
      assert {:ok, _} = Redmine.is_assigned_to(redmineable, ~r(1234))
      assert {:filtered} = Redmine.is_assigned_to(redmineable, ~r(12345))
    end

    test "card" do
      data = %{
        "account_id" => 3_597_594,
        "data" => %{
          "items" => [
            %{
              "board" => %{"id" => "355784046"},
              "id" => "355784054",
              "name" => "Renglón 2"
            }
          ]
        }
      }

      redmineable = %Monday{data: data}
      assert {:ok, _} = Redmine.card(redmineable)
    end
  end
end
