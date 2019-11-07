defmodule CeiboWebhookServer.Trello do
  defstruct [:data]
end

defimpl CeiboWebhookServer.Redminable, for: CeiboWebhookServer.Trello do
  def card(data) do
    data
  end
end
