defmodule Finch.SessionController do
  @moduledoc """
  Log in, log out, all that jazz.
  """
  use Finch.Web, :controller
  alias Finch.User
  alias Comeonin.Bcrypt

  plug :scrub_params, "user" when action in [:create]

  def new(conn, _params) do
    render conn, "new.html", changeset: User.changeset
  end

  def create(conn, %{ "user" => %{ "email" => email, "password" => pass }}) do
    if is_binary(email) and is_binary(pass) do
      attempt_login(conn, email, pass)
    else
      fail_login(conn)
    end
  end

  def delete(conn, _params) do
    conn
    |> put_session(:current_user, nil)
    |> put_flash(:info, "Signed out successfully.")
    |> redirect(to: "/")
  end


  defp attempt_login(conn, email, pass) do
    user = User |> Repo.get_by( email: email )
    valid = user && Bcrypt.checkpw( pass, user.password_digest )
    if valid do
      conn
      |> put_session(:current_user, %{id: user.id})
      |> put_flash(:info, "Sign in successful!")
      |> redirect(to: "/")
    else
      fail_login(conn)
    end
  end

  defp fail_login(conn) do
    conn
    |> put_session(:current_user, nil)
    |> put_flash(:error, "Invalid username/password combination!")
    |> redirect(to: session_path(conn, :new))
  end
end
