defmodule RedmineTest do
  use ExUnit.Case
  alias CeiboWebhookServer.{Monday, Redmine}

  describe "is_assigned_to" do
    test "monday" do
      data = %{
        "event" => %{
          "columnId" => "person",
          "value" => %{
            "personsAndTeams" => [%{"id" => 1234 }]
          }
        }
      }
      redmineable = %Monday{data: data}
      assert {:ok, _} = Redmine.is_assigned_to(redmineable, ~r(1234))
      assert {:filtered} = Redmine.is_assigned_to(redmineable, ~r(12345))
    end
  end
end
