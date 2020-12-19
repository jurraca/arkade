# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :arkade,
  ecto_repos: [Arkade.Repo]

# Configures the endpoint
config :arkade, ArkadeWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "HoLBLoKcSGBihyy5FT9esz3mps/iae02G8K9xwyXbpzm+N+AE1ujf/z9hVKglaxt",
  render_errors: [view: ArkadeWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Arkade.PubSub,
  live_view: [signing_salt: "Ht8thCqr"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
