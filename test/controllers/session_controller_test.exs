defmodule Finch.SessionControllerTest do
  use Finch.ConnCase

  setup do
    {:ok, conn: conn}
  end

  test "GET new renders", %{conn: conn} do
    conn = get conn, session_path(conn, :new)
    body = html_response(conn, 200)
    assert body =~ "Log in"
    assert body =~ "Password"
    assert body =~ "Email"
  end
end
