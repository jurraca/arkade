defmodule ArkadeWeb.PageController do
  use ArkadeWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
