defmodule Finch.BundleEntry do
  @moduledoc """
  A join between Bundles and Items.
  """

  use Finch.Web, :model

  schema "bundle_entries" do
    belongs_to :bundle, Finch.Bundle
    belongs_to :item,   Finch.Item
    timestamps
  end

  @required_fields ~w(bundle_id item_id)
  @optional_fields ~w()


  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset do
    %__MODULE__{} |> changeset
  end
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
