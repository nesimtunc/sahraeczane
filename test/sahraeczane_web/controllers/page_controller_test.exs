defmodule SahraeczaneWeb.PageControllerTest do
  use SahraeczaneWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Places"
  end
end
