defmodule Finch.BundleController do
  @moduledoc """
  We can CRUD bundles!
  """
  use Finch.Web, :controller
  alias Finch.Bundle
  alias Finch.BundleEntry
  alias Finch.Item
  alias Finch.ErrorView
  alias Ecto.Query

  plug :scrub_params, "bundle" when action in [:create]

  def index(conn, _params) do
    bundles = Bundle |> Repo.all |> Repo.preload(:items)
    render conn, "index.html", bundles: bundles
  end

  def new(conn, _params) do
    render conn, "new.html", changeset: Bundle.changeset
  end

  def show(conn, %{ "id" => id }) do
    Bundle
    |> Bundle.preload_items
    |> Repo.get_by( code: id )
    |> case do
      nil ->
        conn
        |> put_status(404)
        |> render ErrorView, "404.html"

      bundle ->
        items = Repo.all Query.from( i in Item, select: {i.code, i.id} )
        entry = BundleEntry.changeset
        attrs = [bundle: bundle, items: items, entry: entry]
        render conn, "show.html", attrs
    end
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
        |> render "new.html", changeset: changeset
    end
  end
end
