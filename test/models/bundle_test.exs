defmodule Finch.BundleTest do
  use Finch.ModelCase

  alias Finch.Bundle
  alias Finch.BundleMembership
  alias Finch.Product

  @attrs %{ display_name: "Potion Set", code: "potion-set" }

  @tag :async
  test "changeset can be valid" do
    changeset = Bundle.changeset(%Bundle{}, @attrs)
    assert changeset.valid?
  end

  @tag :async
  test "changeset is invalid without display_name" do
    attrs = Dict.delete @attrs, :display_name
    changeset = Bundle.changeset(%Bundle{}, attrs)
    refute changeset.valid?
    assert [display_name: _] = changeset.errors
  end

  @tag :async
  test "changeset is invalid without code" do
    attrs = Dict.delete @attrs, :code
    changeset = Bundle.changeset(%Bundle{}, attrs)
    refute changeset.valid?
    assert [code: _] = changeset.errors
  end

  @tag :async
  test "display name cannot be short" do
    attrs = Dict.put @attrs, :display_name, "123"
    changeset = Bundle.changeset(%Bundle{}, attrs)
    refute changeset.valid?
    assert [display_name: _] = changeset.errors
    attrs = Dict.put @attrs, :display_name, "1234"
    changeset = Bundle.changeset(%Bundle{}, attrs)
    assert changeset.valid?
  end

  @tag :async
  test "code cannot be short" do
    attrs = Dict.put @attrs, :code, "123"
    changeset = Bundle.changeset(%Bundle{}, attrs)
    refute changeset.valid?
    assert [code: _] = changeset.errors
    attrs = Dict.put @attrs, :code, "1234"
    changeset = Bundle.changeset(%Bundle{}, attrs)
    assert changeset.valid?
  end

  @tag :async
  test "code may only contain lowercase alphanumerics and hyphens" do
    attrs = Dict.put @attrs, :code, "hello-123"
    changeset = Bundle.changeset(%Bundle{}, attrs)
    assert changeset.valid?
    for code <- ["$&*dod1", "[abac]", "HELLO", "what  "] do
      attrs = Dict.put @attrs, :code, code
      changeset = Bundle.changeset(%Bundle{}, attrs)
      refute changeset.valid?, "'#{code}' should be an invalid code"
      assert [code: _] = changeset.errors
    end
  end

  test "changeset is invalid when display_name is already in use" do
    assert {:ok, _} =
      %Bundle{}
      |> Bundle.changeset(%{ display_name: "hello", code: "hello" })
      |> Repo.insert
    assert {:error, changeset} =
      %Bundle{}
      |> Bundle.changeset(%{ display_name: "hello", code: "goodbye" })
      |> Repo.insert
    assert changeset.errors == [display_name: "has already been taken"]
  end

  test "changeset is invalid when code is already in use" do
    assert {:ok, _} =
      %Bundle{}
      |> Bundle.changeset(%{ display_name: "hello", code: "hello" })
      |> Repo.insert
    assert {:error, changeset} =
      %Bundle{}
      |> Bundle.changeset(%{ display_name: "goodbye", code: "hello" })
      |> Repo.insert
    assert changeset.errors == [code: "has already been taken"]
  end

  test "can have many products" do
    bundle = %Bundle{} |> Bundle.changeset(@attrs) |> Repo.insert!
    products = for n <- 1..2 do
      attrs = %{ display_name: "Foo#{n}", code: "foo#{n}" }
      prod  = %Product{} |> Product.changeset(attrs) |> Repo.insert!
      attrs = %{ bundle_id: bundle.id, product_id: prod.id }
      %BundleMembership{}
      |> BundleMembership.changeset(attrs)
      |> Repo.insert!
      prod
    end
    bundle = Bundle |> Repo.one |> Repo.preload(:products)
    assert bundle.products == products
  end
end
