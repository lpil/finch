defmodule Finch.PageController do
  @moduledoc """
  Controller for static page requests.
  """

  use Finch.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
