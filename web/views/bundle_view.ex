defmodule Finch.BundleView do
  @moduledoc false
  use Finch.Web, :view

  def render("page_title", assigns) do
    case assigns.view_template do
      "new.html"  -> "New bundle"
      "show.html" -> assigns.conn.assigns.bundle.display_name
      _           -> "Bundles"
    end
  end

  def product_names(products) do
    products
    |> Enum.map(fn p -> p.display_name end)
    |> Enum.join(", ")
  end
end
