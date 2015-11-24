defmodule Finch.PageControllerTest do
  use Finch.ConnCase

  static_pages = %{
    "/" => ["Finch", "Dis is home"],
    "/" => [],
  }

  setup do
    {:ok, conn: conn()}
  end

  for {path, contents} <- static_pages do
    test "GET #{path}", %{ conn: conn } do
      conn = get conn, unquote(path)
      assert html_response(conn, 200)
    end

    for x <- contents do
      test "GET #{path}, see #{x}", %{ conn: conn } do
        conn = get conn, unquote(path)
        body = html_response(conn, 200)
        assert body =~ unquote(x),
          "Expected to see '#{unquote(x)}' in #{unquote(path)} body"
      end
    end
  end

  test "render 404 for unknown path" do
    conn = get conn, "/some/unknown/path"
    body = html_response(conn, 404)
    assert body =~ "Page not found"
  end
end
