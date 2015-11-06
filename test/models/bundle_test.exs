defmodule Finch.BundleTest do
  use Finch.ModelCase

  alias Finch.Bundle

  @attrs %{ name: "Potion Set" }

  test "changeset can be valid" do
    changeset = Bundle.changeset(%Bundle{}, @attrs)
    assert changeset.valid?
  end

  test "changeset is invalid without name" do
    attrs = Dict.delete @attrs, :name
    changeset = Bundle.changeset(%Bundle{}, attrs)
    refute changeset.valid?
  end

  test "changeset is invalid with a short name" do
    attrs = Dict.put @attrs, :name, "Hi"
    changeset = Bundle.changeset(%Bundle{}, attrs)
    refute changeset.valid?
  end

  test "changeset is invalid when name is already in use" do
    assert {:ok, _} =
      %Bundle{}
      |> Bundle.changeset(@attrs)
      |> Repo.insert
    assert {:error, changeset} =
      %Bundle{}
      |> Bundle.changeset(@attrs)
      |> Repo.insert
    assert changeset.errors == [name: "has already been taken"]
  end
end
