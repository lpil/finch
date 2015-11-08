defmodule Finch.ProductController do
  @moduledoc """
  We can CRUD products!
  """
  use Finch.Web, :controller
  alias Ecto.Query
  alias Finch.Product
  alias Finch.Bundle
  alias Finch.BundleMembership
  alias Finch.ErrorView

  plug :scrub_params, "product" when action in [:create] #, :update]

  def index(conn, _params) do
    products =
      Product
      |> Query.order_by([p], [p.display_name])
      |> Repo.all 
      |> Repo.preload(:bundles)
    render conn, "index.html", products: products
  end

  def new(conn, %{ "bundle_id" => bundle_code }) do
    bundle = get_bundle( bundle_code )
    changeset =  Product.changeset
    render conn, "new.html", changeset: changeset, bundle: bundle
  end

  def create(conn, %{ "product" => params, "bundle_id" => bundle_code }) do
    bundle = get_bundle( bundle_code )
    %Product{}
    |> Product.changeset(params)
    |> Repo.insert
    |> case do
      {:ok, product} ->
        %BundleMembership{ bundle_id: bundle.id, product_id: product.id, }
        |> Repo.insert!
        conn
        |> put_flash(:info, "Product created successfully.")
        |> redirect( to: bundle_path(conn, :show, bundle) )

      {:error, changeset} ->
        conn
        |> render "new.html", changeset: changeset, bundle: bundle
    end
    redirect conn, to: bundle_path(conn, :show, bundle_code)
  end


  defp get_bundle(code) do
    Bundle |> Repo.get_by!( code: code )
  end
end
