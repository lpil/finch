defmodule Finch.BundleController do
  @moduledoc """
  We can CRUD bundles!
  """
  use Finch.Web, :controller
  alias Finch.Bundle

  plug :scrub_params, "bundle" when action in [:create] #, :update]

  def index(conn, _params) do
    render conn, "index.html", bundles: Bundle |> Repo.all
  end

  def new(conn, _params) do
    render conn, "new.html", changeset: Bundle.changeset
  end

  def create(conn, %{"bundle" => params}) do
    %Bundle{}
    |> Bundle.changeset(params)
    |> Repo.insert
    |> case do
      {:ok, _} ->
        conn
        |> put_flash(:info, "Bundle created successfully.")
        |> redirect(to: bundle_path(conn, :index))

      {:error, changeset} ->
        conn
        |> put_flash(:info, "Bundle created successfully.")
        |> redirect(to: bundle_path(conn, :index))
    end
  end
end
