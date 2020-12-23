defmodule ArkadeWeb.PageController do
  use ArkadeWeb, :controller

  def index(conn, _params) do
    rows = Arkade.Stats.by_fund()
    render(conn, "index.html", data: rows)
  end
end
