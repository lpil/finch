defmodule Finch.SessionView do
  @moduledoc false
  use Finch.Web, :view

  def render("page_title", _assigns) do
    "Log in"
  end
end
