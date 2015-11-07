defmodule Finch.Product do
  @moduledoc """
  A product is an item in a bundle.
  """

  use Finch.Web, :model

  schema "products" do
    field :display_name, :string
    field :code, :string
    timestamps

    has_many :bundle_memberships, Finch.BundleMembership
    has_many :bundles, through: [:bundle_memberships, :bundle]
  end


  # TODO: Make it so display name and code can only be set on create

  @required_fields ~w(display_name code)
  @optional_fields ~w()

  @code_regex ~r/\A[a-z0-9-]+\z/
  @code_fmt_msg "may only contain alphanumerics and hyphens"


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

    |> validate_length(:display_name, min: 4)
    |> unique_constraint(:display_name)

    |> validate_length(:code, min: 4)
    |> validate_format(:code, @code_regex, message: @code_fmt_msg)
    |> unique_constraint(:code)
  end
end
