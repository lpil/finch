defmodule Finch.ProductController do
  @moduledoc """
  We can CRUD products!
  """
  use Finch.Web, :controller

  alias Ecto.Query
  alias Finch.Product

  plug :scrub_params, "product" when action in [:create] #, :update]

  def index(conn, _params) do
    products =
      Product
      |> Query.order_by([p], [p.display_name])
      |> Repo.all
      |> Repo.preload(:bundles)
    changeset =  Product.changeset
    render conn, "index.html", products: products, changeset: changeset
  end

  def create(conn, %{ "product" => params }) do
    %Product{}
    |> Product.changeset(params)
    |> Repo.insert
    |> case do
      {:ok, _product} ->
        conn
        |> put_flash(:info, "Product created successfully.")
        |> redirect( to: product_path(conn, :index) )

      {:error, changeset} ->
        conn
        |> render "new.html", changeset: changeset
    end
  end
end
