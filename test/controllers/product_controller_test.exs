defmodule Finch.ProductControllerTest do
  use Finch.ConnCase

  alias Finch.Product

  @attrs %{ display_name: "Warcraft 3", code: "war3" }
  @invalid_attrs @attrs |> Dict.delete( :display_name )

  setup do
    {:ok, conn: conn}
  end


  test "GET index renders list of products", %{conn: conn} do
    %Product{} |> Product.changeset(@attrs) |> Repo.insert!
    conn = get conn, product_path(conn, :index)
    body = html_response(conn, 200)
    assert body =~ "Products"
    assert body =~ @attrs.display_name
    assert body =~ @attrs.code
    assert body =~ "Create a new Product"
  end


  test "POST create redirects to index when ok", %{conn: conn} do
    conn = post conn, product_path(conn, :create), product: @attrs
    assert redirected_to(conn) == product_path(conn, :index)
  end

  test "POST create persists when ok", %{conn: conn} do
    refute Product |> Repo.get_by(@attrs)
    post conn, product_path(conn, :create), product: @attrs
    assert Product |> Repo.get_by(@attrs)
  end

  test "POST create renders new with errors when not ok", %{conn: conn} do
    conn = post conn, product_path(conn, :create), product: @invalid_attrs
    assert html_response(conn, 200) =~ "Products"
    assert html_response(conn, 200) =~ "be blank"
  end

  test "POST create doesn't persist when not ok", %{conn: conn} do
    post conn, product_path(conn, :create), product: @invalid_attrs
    count = Repo.one from p in Product, select: count(p.id)
    assert count == 0
  end
end
