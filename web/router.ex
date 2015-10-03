defmodule Finch.Router do
  @moduledoc """
  The router. Dispatches HTTP requests to controllers.
  """

  use Finch.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Finch do
    pipe_through :browser

    get "/", PageController, :index
  end

  # scope "/api", Finch do
  #   pipe_through :api
  # end
end
