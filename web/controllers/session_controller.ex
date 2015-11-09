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

  def create(conn, %{ "user" => params }) do
    user = User |> Repo.get_by( email: params["email"] )
    pass = params["password"]
    if valid_sign_in?( user, pass ) do
      conn
      |> put_session(:current_user, %{id: user.id})
      |> put_flash(:info, "Sign in successful!")
      |> redirect(to: "/")
    else
      conn
      |> put_session(:current_user, nil)
      |> put_flash(:error, "Invalid username/password combination!")
      |> redirect(to: session_path(conn, :new))
    end
  end

  def delete(conn, _params) do
    conn
    |> put_session(:current_user, nil)
    |> put_flash(:info, "Signed out successfully.")
    |> redirect(to: "/")
  end


  defp valid_sign_in?(user, password) do
    if user do
      Bcrypt.checkpw( password, user.password_digest )
    else
      false
    end
  end
end
