defmodule Finch.ItemTest do
  use Finch.ModelCase

  alias Finch.Item

  @attrs %{ display_name: "Cauldren 2", code: "cald-2" }

  @tag :async
  test "changeset can be valid" do
    changeset = Item.changeset(%Item{}, @attrs)
    assert changeset.valid?
  end

  @tag :async
  test "changeset is invalid without display_name" do
    attrs = Dict.delete @attrs, :display_name
    changeset = Item.changeset(%Item{}, attrs)
    refute changeset.valid?
    assert [display_name: _] = changeset.errors
  end

  @tag :async
  test "changeset is invalid without code" do
    attrs = Dict.delete @attrs, :code
    changeset = Item.changeset(%Item{}, attrs)
    refute changeset.valid?
  end

  @tag :async
  test "display name cannot be short" do
    attrs = Dict.put @attrs, :display_name, "123"
    changeset = Item.changeset(%Item{}, attrs)
    refute changeset.valid?
    assert [display_name: _] = changeset.errors
    attrs = Dict.put @attrs, :display_name, "1234"
    changeset = Item.changeset(%Item{}, attrs)
    assert changeset.valid?
  end

  @tag :async
  test "code cannot be short" do
    attrs = Dict.put @attrs, :code, "123"
    changeset = Item.changeset(%Item{}, attrs)
    refute changeset.valid?
    assert [code: _] = changeset.errors
    attrs = Dict.put @attrs, :code, "1234"
    changeset = Item.changeset(%Item{}, attrs)
    assert changeset.valid?
  end

  @tag :async
  test "code may only contain lowercase alphanumerics and hyphens" do
    attrs = Dict.put @attrs, :code, "hello-123"
    changeset = Item.changeset(%Item{}, attrs)
    assert changeset.valid?
    for code <- ["$&*dod1", "[abac]", "HELLO", "what  "] do
      attrs = Dict.put @attrs, :code, code
      changeset = Item.changeset(%Item{}, attrs)
      refute changeset.valid?, "'#{code}' should be an invalid code"
      assert [code: _] = changeset.errors
    end
  end

  test "changeset is invalid when code is already in use" do
    assert {:ok, _} =
      %Item{}
      |> Item.changeset(%{ display_name: "hello", code: "hello" })
      |> Repo.insert
    assert {:error, changeset} =
      %Item{}
      |> Item.changeset(%{ display_name: "goodbye", code: "hello" })
      |> Repo.insert
    assert changeset.errors == [code: "has already been taken"]
  end
end
