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

  scope "/", Finch do
    pipe_through :browser

    resources "/bundles", BundleController, except: ~w(update edit delete)a do
      post "/entry", BundleEntryController, :create, as: :entry
    end
    resources "/items", ItemController, only: ~w(index create)a

    # TODO: Remove
    resources "/people", PersonController

    get "/*path", PageController, :show
  end
end
