defmodule MondayTest do
  use ExUnit.Case
  alias CeiboWebhookServer.{Monday}

  describe("monday") do
    test "fecth_pulse" do
      data = %{
        "event" => %{
          "pulseId" => 355784054,
          "columnId" => "person",
          "value" => %{
            "personsAndTeams" => [%{"id" => 1234}]
          }
        }
      }

      redmineable = %Monday{data: data}
      pulse = Monday.fetch_pulse(redmineable)
      assert [item] = pulse.data["data"]["items"]
    end
  end
end
