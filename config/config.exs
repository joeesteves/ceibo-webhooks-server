# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config
config :ceibo_webhook_server,
  redmine_url: "https://pm.ceibo.co/issues.json",
  redmine_key: System.get_env("REDMINE_KEY"),
  trello_key: System.get_env("TRELLO_KEY"),
  trello_token: System.get_env("TRELLO_TOKEN"),
  monday_token: System.get_env("MONDAY_TOKEN")

# Configures the endpoint
config :ceibo_webhook_server, CeiboWebhookServerWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "mICqlbI5hfC4VTpX1KXglUXq7fMHzwA6znnH54QgT/HIzPEyPn+336W+axCFAgHi",
  render_errors: [view: CeiboWebhookServerWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: CeiboWebhookServer.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
