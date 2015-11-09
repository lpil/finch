defmodule Finch.SessionController do
  @moduledoc """
  Log in, log out, all that jazz.
  """
  use Finch.Web, :controller
  alias Finch.User

  # plug :scrub_params, "bundle" when action in [:create]

  def new(conn, _params) do
    render conn, "new.html", changeset: User.changeset
  end
end
