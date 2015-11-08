defmodule Finch.ItemControllerTest do
  use Finch.ConnCase

  alias Finch.Item

  @attrs %{ display_name: "Warcraft 3", code: "war3" }
  @invalid_attrs @attrs |> Dict.delete( :display_name )

  setup do
    {:ok, conn: conn}
  end


  test "GET index renders list of items", %{conn: conn} do
    %Item{} |> Item.changeset(@attrs) |> Repo.insert!
    conn = get conn, item_path(conn, :index)
    body = html_response(conn, 200)
    assert body =~ "Items"
    assert body =~ @attrs.display_name
    assert body =~ @attrs.code
    assert body =~ "Create a new Item"
  end


  test "POST create redirects to index when ok", %{conn: conn} do
    conn = post conn, item_path(conn, :create), item: @attrs
    assert redirected_to(conn) == item_path(conn, :index)
  end

  test "POST create persists when ok", %{conn: conn} do
    refute Item |> Repo.get_by(@attrs)
    post conn, item_path(conn, :create), item: @attrs
    assert Item |> Repo.get_by(@attrs)
  end

  test "POST create renders new with errors when not ok", %{conn: conn} do
    conn = post conn, item_path(conn, :create), item: @invalid_attrs
    body = html_response(conn, 200)
    assert body =~ "Items"
    assert body =~ "be blank"
  end

  test "POST create doesn't persist when not ok", %{conn: conn} do
    post conn, item_path(conn, :create), item: @invalid_attrs
    count = Repo.one from p in Item, select: count(p.id)
    assert count == 0
  end
end
