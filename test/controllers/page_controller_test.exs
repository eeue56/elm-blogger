defmodule ElmBlogger.PageControllerTest do
  use ElmBlogger.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Hello ElmBlogger!"
  end
end
