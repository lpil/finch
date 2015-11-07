defmodule Finch.BundleTest do
  use Finch.ModelCase

  alias Finch.Bundle

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
  end

  @tag :async
  test "changeset is invalid without code" do
    attrs = Dict.delete @attrs, :code
    changeset = Bundle.changeset(%Bundle{}, attrs)
    refute changeset.valid?
  end

  @tag :async
  test "changeset is invalid with a short display_name" do
    attrs = Dict.put @attrs, :display_name, "Hi!"
    changeset = Bundle.changeset(%Bundle{}, attrs)
    refute changeset.valid?
  end

  @tag :async
  test "changeset is invalid with a short code" do
    attrs = Dict.put @attrs, :code, "hey"
    changeset = Bundle.changeset(%Bundle{}, attrs)
    refute changeset.valid?
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
end
