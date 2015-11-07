defmodule Finch.BundleView do
  @moduledoc false
  use Finch.Web, :view

  def render("page_title", %{ view_template: view_template }) do
    case view_template do
      "new.html" -> "New bundle"
      _          -> "Bundles"
    end
  end
end
