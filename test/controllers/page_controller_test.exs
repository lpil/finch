defmodule Finch.PageControllerTest do
  use Finch.ConnCase

  test "GET /" do
    conn = get conn(), "/"
    assert html_response(conn, 200) =~ "Finch"
  end
end
