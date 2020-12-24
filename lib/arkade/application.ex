defmodule Arkade.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Arkade.Repo,
      # Start the Telemetry supervisor
      ArkadeWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Arkade.PubSub},
      # Start the Endpoint (http/https)
      ArkadeWeb.Endpoint,
      Arkade.Cron
      # Start a worker by calling: Arkade.Worker.start_link(arg)
      # {Arkade.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Arkade.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    ArkadeWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
