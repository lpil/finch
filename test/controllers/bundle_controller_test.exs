defmodule Finch.BundleControllerTest do
  use Finch.ConnCase

  # alias Finch.Bundle

  setup do
    {:ok, conn: conn}
  end

  test "GET index renders", %{conn: conn} do
    conn = get conn, bundle_path(conn, :index)
    assert html_response(conn, 200) =~ "Bundles"
  end

  test "GET new renders", %{conn: conn} do
    conn = get conn, bundle_path(conn, :new)
    assert html_response(conn, 200) =~ "New bundle"
  end
end
