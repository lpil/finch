defmodule Finch.BundleEntryTest do
  use Finch.ModelCase

  alias Finch.Bundle
  alias Finch.BundleEntry
  alias Finch.Item

  @b_attrs %{ display_name: "Potion Set", code: "potion-set" }
  @i_attrs %{ display_name: "Potion Set", code: "potion-set" }

  test "item cannot be entered into the same bundle twice" do
    bundle = %Bundle{} |> Bundle.changeset(@b_attrs) |> Repo.insert!
    item   = %Item{}   |> Item.changeset(@b_attrs)   |> Repo.insert!
    assert {:ok, _} =
      %BundleEntry{}
      |> BundleEntry.changeset(%{ bundle_id: bundle.id, item_id: item.id })
      |> Repo.insert
    assert {:error, changeset} =
      %BundleEntry{}
      |> BundleEntry.changeset(%{ bundle_id: bundle.id, item_id: item.id })
      |> Repo.insert
    assert changeset.errors == [bundle: "already contains this item"]
  end
end
