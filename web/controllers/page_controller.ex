defmodule Finch.PageController do
  @moduledoc """
  A controller for rendering static pages. Gosh.
  """

  use Finch.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
