defmodule Finch.User do
  @moduledoc """
  Finch has users!
  """
  use Finch.Web, :model
  alias Comeonin.Bcrypt

  schema "users" do
    field :email, :string
    field :password_digest, :string
    timestamps

    field :password,              :string, virtual: true
    field :password_confirmation, :string, virtual: true
  end


  @required_fields ~w(email password password_confirmation)
  @optional_fields ~w()


  @email_regex ~r/\A.+@.+\..+\z/


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

    |> validate_format(:email, @email_regex)
    |> unique_constraint(:email)

    |> validate_confirmation(:password)
    |> hash_password
  end


  defp hash_password(changeset) do
    password = changeset |> get_change(:password)
    if changeset.valid? && password do
      hashed = Bcrypt.hashpwsalt( password )
      changeset |> put_change(:password_digest, hashed)
    else
      changeset
    end
  end
end
