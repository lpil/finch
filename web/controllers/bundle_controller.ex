defmodule Finch.BundleController do
  @moduledoc """
  We can CRUD bundles!
  """
  use Finch.Web, :controller
  alias Finch.Bundle

  # plug :scrub_params, "bundle" when action in [:create, :update]

  def index(conn, _params) do
    render conn, "index.html", bundles: Bundle |> Repo.all
  end

  def new(conn, _params) do
    render conn, "new.html", changeset: Bundle.changeset
  end

  def create(_conn, _params) do
    raise NotImplementedError
  end
end
