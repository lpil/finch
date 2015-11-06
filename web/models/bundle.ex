defmodule Finch.Bundle do
  @moduledoc """
  A bundle of products that may be owned by a person. Rad.
  """

  use Finch.Web, :model

  schema "bundles" do
    field :name, :string
    timestamps
  end

  @required_fields ~w(name)
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
    |> validate_length(:name, min: 4)
    |> unique_constraint(:name)
  end
end
