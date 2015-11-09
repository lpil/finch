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
    assert body =~ "Log in"
    assert body =~ "Password"
    assert body =~ "Email"
  end

  test "POST create adds user to session on success" do
    user = %User{} |> User.changeset(@user_attrs) |> Repo.insert!
    conn = post conn, session_path(conn, :create), user: @user_attrs
    assert get_session(conn, :current_user) == %{id: user.id}
    assert get_flash(conn, :info) == "Sign in successful!"
    assert redirected_to(conn) == "/"
  end

  test "POST create nulls session on failure" do
    %User{} |> User.changeset(@user_attrs) |> Repo.insert!
    attrs = @user_attrs |> Dict.put( :password, "oops" )
    conn = post conn, session_path(conn, :create), user: attrs
    assert get_session(conn, :current_user) == nil
    assert get_flash(conn, :error) =~ "Invalid"
    assert redirected_to(conn) == session_path(conn, :new)
  end
end
