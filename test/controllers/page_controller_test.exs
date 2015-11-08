defmodule Finch.PageControllerTest do
  use Finch.ConnCase

  setup do
    {:ok, conn: conn()}
  end

  @static_page_content %{
    "/" => ["Finch", "Dis is home"],
  }

  for {path, contents} <- @static_page_content,
      x <- contents
  do
    test "GET #{path}, see #{x}", %{ conn: conn } do
      conn = get conn, unquote(path)
      body = html_response(conn, 200)
      assert body =~ unquote(x),
        "Expected to see '#{unquote(x)}' in #{unquote(path)} body"
    end
  end

  test "render 404 for unknown path" do
    conn = get conn, "/some/unknown/path"
    body = html_response(conn, 404)
    assert body =~ "Page not found"
  end
end
