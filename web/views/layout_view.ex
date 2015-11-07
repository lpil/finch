defmodule Finch.LayoutView do
  @moduledoc false
  use Finch.Web, :view

  def page_title(conn, assigns) do
    # TODO: Move adding the view template name to a plug.
    assigns = assigns |> Dict.put :view_template, view_template(conn)
    render_existing( view_module(conn), "page_title", assigns )
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
end
