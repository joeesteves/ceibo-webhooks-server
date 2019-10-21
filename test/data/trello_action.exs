defmodule MockData do
  def trello_card_wrong_member do
    %{
      "action" => %{
        "data" => %{
          "board" => %{
            "id" => "5c519e1e85490d20ec6e5c51",
            "name" => "CRM",
            "shortLink" => "o01dbr7Y"
          },
          "card" => %{
            "id" => "5dadf7967c00800329db4a74",
            "idShort" => 5,
            "name" => "Test",
            "shortLink" => "rUfRTpTr"
          },
          "idMember" => "59aab85fa384ab635af13edc",
          "member" => %{
            "id" => "59aab85fa384ab635af13edc",
            "name" => "Carlos Flores"
          }
        },
        "type" => "addMemberToCard"
      }
    }
  end

  def trello_card do
    %{
      "action" => %{
        "data" => %{
          "board" => %{
            "id" => "5c519e1e85490d20ec6e5c51",
            "name" => "CRM",
            "shortLink" => "o01dbr7Y"
          },
          "card" => %{
            "id" => "5dadf7967c00800329db4a74",
            "idShort" => 5,
            "name" => "Test",
            "shortLink" => "rUfRTpTr"
          },
          "idMember" => "59aab85fa384ab635af13edc",
          "member" => %{
            "id" => "59aab85fa384ab635af13edc",
            "name" => "José Esteves"
          }
        },
        "type" => "addMemberToCard"
      }
    }
  end
end
