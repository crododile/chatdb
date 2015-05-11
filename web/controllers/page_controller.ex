defmodule ChatDb.PageController do
  use ChatDb.Web, :controller

  plug :action

  def index(conn, _params) do
    render conn, "index.html"
  end
end
