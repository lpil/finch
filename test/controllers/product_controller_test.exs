defmodule Finch.ProductControllerTest do
  use Finch.ConnCase

  alias Finch.Bundle
  alias Finch.Product

  @attrs %{ display_name: "Warcraft 3", code: "war3" }
  @invalid_attrs @attrs |> Dict.delete( :display_name )
  @bundle_attrs %{ display_name: "Battle Net Chest", code: "bttl-cst" }

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
  end


  test "GET new renders", %{conn: conn} do
    bundle = new_bundle()
    conn = get conn, bundle_product_path(conn, :new, bundle)
    body = html_response(conn, 200)
    assert body =~ "New product"
    assert body =~ "Submit"
    assert body =~ bundle.display_name
  end


  test "POST create redirects to index when ok", %{conn: conn} do
    bundle = new_bundle()
    path = bundle_product_path(conn, :create, bundle)
    conn = post conn, path, product: @attrs
    assert redirected_to(conn) == bundle_path(conn, :show, bundle)
  end

  test "POST create persists product when ok", %{conn: conn} do
    bundle = new_bundle()
    refute Product |> Repo.get_by(@attrs)
    post conn, bundle_product_path(conn, :create, bundle), product: @attrs
    assert Product |> Repo.get_by(@attrs)
  end

  test "POST create creates association to bundle", %{conn: conn} do
    bundle = new_bundle()
    post conn, bundle_product_path(conn, :create, bundle), product: @attrs
    bundle =
      Bundle
      |> Bundle.preload_products
      |> Repo.get_by!( code: bundle.code )
      product_codes = bundle.products |> Enum.map(fn p -> p.code end)
    assert product_codes == [@attrs.code]
  end

  @tag :skip
  test "POST create displays info flash when ok", %{conn: conn} do
    # TODO: Figure out how to test the flash
    post conn, bundle_path(conn, :create), product: @attrs
    assert conn |> fetch_session |> get_session(:current_user)
    assert get_flash(conn, :info) =~ "Bundle created"
  end

  # test "POST create renders new with errors when not ok", %{conn: conn} do
  #   conn = post conn, bundle_path(conn, :create), bundle: @invalid_attrs
  #   assert html_response(conn, 200) =~ "New bundle"
  #   assert html_response(conn, 200) =~ "be blank"
  # end

  # test "POST create doesn't persist when not ok", %{conn: conn} do
  #   post conn, bundle_path(conn, :create), bundle: @invalid_attrs
  #   count = Repo.one from p in Bundle, select: count(p.id)
  #   assert count == 0
  # end

  def new_bundle(attrs \\ @attrs) do
    %Bundle{} |> Bundle.changeset(attrs) |> Repo.insert!
  end
end
