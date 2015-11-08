defmodule Finch.ItemView do
  @moduledoc false
  use Finch.Web, :view

  def render("page_title", assigns) do
    case assigns.view_template do
      "new.html"  -> "New item"
      _           -> "Items"
    end
  end
end
