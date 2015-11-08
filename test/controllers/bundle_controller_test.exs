defmodule Finch.BundleControllerTest do
  use Finch.ConnCase

  alias Finch.Bundle

  @attrs %{ display_name: "Battle Net Chest", code: "bttl-cst" }
  @invalid_attrs @attrs |> Dict.delete( :display_name )

  setup do
    {:ok, conn: conn}
  end

  test "GET index renders list of items", %{conn: conn} do
    %Bundle{} |> Bundle.changeset(@attrs) |> Repo.insert!
    conn = get conn, bundle_path(conn, :index)
    body = html_response(conn, 200)
    assert body =~ "Bundles"
    assert body =~ @attrs.display_name
    assert body =~ @attrs.code
  end


  test "GET new renders", %{conn: conn} do
    conn = get conn, bundle_path(conn, :new)
    assert html_response(conn, 200) =~ "New bundle"
    assert html_response(conn, 200) =~ "Submit"
  end


  test "GET show renders 404 with an unknown bundle", %{conn: conn} do
    conn = get conn, bundle_path(conn, :show, %Bundle{ code: "123" })
    assert html_response(conn, 404) =~ "Page not found"
  end

  test "GET show renders bundle details", %{conn: conn} do
    bundle = %Bundle{} |> Bundle.changeset(@attrs) |> Repo.insert!
    conn = get conn, bundle_path(conn, :show, bundle)
    body = html_response(conn, 200)
    assert body =~ bundle.display_name
    assert body =~ bundle.code
  end


  test "POST create redirects to index when ok", %{conn: conn} do
    conn = post conn, bundle_path(conn, :create), bundle: @attrs
    assert redirected_to(conn) == bundle_path(conn, :index)
  end

  @tag :skip
  test "POST create displays info flash when ok", %{conn: conn} do
    # TODO: Figure out how to test the flash
    post conn, bundle_path(conn, :create), bundle: @attrs
    assert conn |> fetch_session |> get_session(:current_user)
    assert get_flash(conn, :info) =~ "Bundle created"
  end

  test "POST create persists when ok", %{conn: conn} do
    refute Bundle |> Repo.get_by(@attrs)
    post conn, bundle_path(conn, :create), bundle: @attrs
    assert Bundle |> Repo.get_by(@attrs)
  end

  test "POST create renders new with errors when not ok", %{conn: conn} do
    conn = post conn, bundle_path(conn, :create), bundle: @invalid_attrs
    assert html_response(conn, 200) =~ "New bundle"
    assert html_response(conn, 200) =~ "be blank"
  end

  test "POST create doesn't persist when not ok", %{conn: conn} do
    post conn, bundle_path(conn, :create), bundle: @invalid_attrs
    count = Repo.one from p in Bundle, select: count(p.id)
    assert count == 0
  end
end
