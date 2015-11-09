defmodule Finch.LayoutView do
  @moduledoc false
  use Finch.Web, :view

  def page_title(conn, assigns) do
    # TODO: Work out how to do this nicely
    assigns = assigns |> Dict.put :view_template, view_template(conn)
    conn
    |> view_module
    |> render_existing( "page_title", assigns )
    |> case do
      nil   -> "Finch"
      title -> title
    end
  end

  def prefixed_page_title(conn, assigns) do
    title = page_title( conn, assigns )
    case title do
      "Finch" -> "Finch"
      title   -> "Finch - #{title}"
    end
  end

  def current_user(conn) do
    Plug.Conn.get_session(conn, :current_user)
  end
end
