defmodule Finch.PageController do
  @moduledoc """
  A controller for rendering static pages. Gosh.
  """
  use Finch.Web, :controller

  alias Finch.ErrorView

  def show(conn, %{ "path" => [] }) do
      render conn, "index.html"
  end
  def show(conn, %{ "path" => path }) do
    try do
      path = path |> Enum.join("/")
      render conn, "#{path}.html"
    rescue
      _ ->
        conn
        |> put_status(404)
        |> render ErrorView, "404.html"
    end
  end
end
