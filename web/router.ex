defmodule Finch.Router do
  @moduledoc """
  Where it all begins. Mega exciting.
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
    resources "/bundles", BundleController, only: ~w(new index create)a

    # TODO: Remove
    resources "/people", PersonController
  end

  # Other scopes may use custom stacks.
  # scope "/api", Finch do
  #   pipe_through :api
  # end
end
