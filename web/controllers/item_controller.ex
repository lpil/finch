defmodule Finch.ItemController do
  @moduledoc """
  We can CRUD items!
  """
  use Finch.Web, :controller

  alias Ecto.Query
  alias Finch.Item

  plug :scrub_params, "item" when action in [:create] #, :update]

  def index(conn, _params) do
    items =
      Item
      |> Query.order_by([p], [p.display_name])
      |> Repo.all
      |> Repo.preload(:bundles)
    changeset =  Item.changeset
    render conn, "index.html", items: items, changeset: changeset
  end

  def create(conn, %{ "item" => params }) do
    %Item{}
    |> Item.changeset(params)
    |> Repo.insert
    |> case do
      {:ok, _item} ->
        conn
        |> put_flash(:info, "Item created successfully.")
        |> redirect( to: item_path(conn, :index) )

      {:error, changeset} ->
        conn
        |> render "new.html", changeset: changeset
    end
  end
end
