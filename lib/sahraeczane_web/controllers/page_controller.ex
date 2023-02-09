defmodule SahraeczaneWeb.PageController do
  use SahraeczaneWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
