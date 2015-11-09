defmodule Finch.UserTest do
  use Finch.ModelCase

  alias Finch.User
  alias Comeonin.Bcrypt

  password = "123456"
  @attrs %{
    email: "louis@lpil.uk",
    password: password,
    password_confirmation: password,
  }

  @tag :async
  test "changeset can be valid" do
    changeset = User.changeset(%User{}, @attrs)
    assert changeset.valid?
  end

  @tag :async
  test "changeset is invalid without email" do
    attrs = Dict.delete @attrs, :email
    changeset = User.changeset(%User{}, attrs)
    refute changeset.valid?
    assert [email: _] = changeset.errors
  end

  @tag :async
  test "changeset is invalid without password" do
    attrs = Dict.delete @attrs, :password
    changeset = User.changeset(%User{}, attrs)
    refute changeset.valid?
    assert [password: _] = changeset.errors
  end

  @tag :async
  test "changeset is invalid without password_confirmation" do
    attrs = Dict.delete @attrs, :password_confirmation
    changeset = User.changeset(%User{}, attrs)
    refute changeset.valid?
    assert [password_confirmation: _] = changeset.errors
  end

  @tag :async
  test "changeset is invalid unless password and confirmation match" do
    attrs = Dict.put @attrs, :password_confirmation, "foobar"
    refute attrs.password == attrs.password_confirmation
    changeset = User.changeset(%User{}, attrs)
    refute changeset.valid?
    assert [password_confirmation: _] = changeset.errors
  end

  @tag :async
  test "email must look like an email" do
    attrs = Dict.put @attrs, :email, "123"
    changeset = User.changeset(%User{}, attrs)
    refute changeset.valid?
    assert [email: _] = changeset.errors
    attrs = Dict.put @attrs, :email, "a@b.c"
    changeset = User.changeset(%User{}, attrs)
    assert changeset.valid?
  end

  @tag :async
  test "passwords are hashed" do
    changeset = User.changeset(%User{}, @attrs)
    digest = Ecto.Changeset.get_change( changeset, :password_digest )
    refute @attrs.password == digest
    assert Bcrypt.checkpw( @attrs.password, digest )
  end

  @tag :async
  test "password_digest does not get set if password is nil" do
    attrs = Dict.delete @attrs, :password
    changeset = User.changeset(%User{}, attrs)
    refute Ecto.Changeset.get_change(changeset, :password_digest)
    refute changeset.valid?
  end

  @tag :async
  test "password_digest does not get set if password is not confirmed" do
    attrs = Dict.put @attrs, :password_confirmation, "foobar"
    refute attrs.password == attrs.password_confirmation
    changeset = User.changeset(%User{}, attrs)
    refute Ecto.Changeset.get_change(changeset, :password_digest)
    refute changeset.valid?
  end

  test "emails must be unique" do
    assert {:ok, _} =
      %User{}
      |> User.changeset(@attrs)
      |> Repo.insert
    assert {:error, changeset} =
      %User{}
      |> User.changeset(@attrs)
      |> Repo.insert
    assert changeset.errors == [email: "has already been taken"]
  end
end
