defmodule Finch.SessionView do
  @moduledoc false
  use Finch.Web, :view

  def render("page_title", _assigns) do
    "Sign in"
  end
end
