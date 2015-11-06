defmodule Finch.BundleControllerTest do
  use Finch.ConnCase

  alias Finch.Bundle

  @attrs %{ name: "Battle Net Chest" }
  @invalid_attrs @attrs |> Dict.delete( :name )

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


  test "POST create redirects to index when ok", %{conn: conn} do
    conn = post conn, bundle_path(conn, :create), bundle: @attrs
    assert redirected_to(conn) == bundle_path(conn, :index)
  end

  @tag :skip
  test "POST create displays info flash when ok", %{conn: conn} do
    # How do I do this?
    post conn, bundle_path(conn, :create), bundle: @attrs
    assert get_flash(conn, :info) =~ "Bundle created"
  end

  test "POST create persists when ok", %{conn: conn} do
    refute Bundle |> Repo.get_by(@attrs)
    post conn, bundle_path(conn, :create), bundle: @attrs
    assert Bundle |> Repo.get_by(@attrs)
  end

  test "POST create renders errors when not ok", %{conn: conn} do
    conn = post conn, person_path(conn, :create), person: @invalid_attrs
    assert html_response(conn, 200) =~ "New person"
  end

  test "POST create doesn't persist when not ok", %{conn: conn} do
    post conn, bundle_path(conn, :create), bundle: @invalid_attrs
    count = Repo.one from p in Bundle, select: count(p.id)
    assert count == 0
  end
end
