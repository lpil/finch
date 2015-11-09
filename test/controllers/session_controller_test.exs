defmodule Finch.SessionControllerTest do
  use Finch.ConnCase

  alias Finch.User

  password = "12345678"
  @user_attrs %{
    email: "foo@bar.guru",
    password: password,
    password_confirmation: password,
  }

  setup do
    {:ok, conn: conn}
  end

  @tag :async
  test "GET new renders", %{conn: conn} do
    conn = get conn, session_path(conn, :new)
    body = html_response(conn, 200)
    assert body =~ "Sign in"
    assert body =~ "Password"
    assert body =~ "Email"
  end

  test "POST create adds user to session on success", %{conn: conn} do
    user = %User{} |> User.changeset(@user_attrs) |> Repo.insert!
    conn = post conn, session_path(conn, :create), user: @user_attrs
    assert get_session(conn, :current_user) == %{id: user.id}
    assert get_flash(conn, :info) == "Sign in successful!"
    assert redirected_to(conn) == "/"
  end

  test "POST create nulls session on failure", %{conn: conn} do
    %User{} |> User.changeset(@user_attrs) |> Repo.insert!
    attrs = @user_attrs |> Dict.put( :password, "oops" )
    conn = post conn, session_path(conn, :create), user: attrs
    assert get_session(conn, :current_user) == nil
    assert get_flash(conn, :error) =~ "Invalid"
    assert redirected_to(conn) == session_path(conn, :new)
  end

  test "POST create nulls session with unknown user", %{conn: conn} do
    conn = post conn, session_path(conn, :create), user: @user_attrs
    assert get_session(conn, :current_user) == nil
    assert get_flash(conn, :error) =~ "Invalid"
    assert redirected_to(conn) == session_path(conn, :new)
  end


  test "DELETE nulls current_user session", %{conn: conn} do
    %User{} |> User.changeset(@user_attrs) |> Repo.insert!
    conn = post conn, session_path(conn, :create), user: @user_attrs
    assert get_session(conn, :current_user)
    conn = delete conn, session_path(conn, :delete)
    refute get_session(conn, :current_user)
    assert get_flash(conn, :info) == "Signed out successfully."
    assert redirected_to(conn) == "/"
  end
end
