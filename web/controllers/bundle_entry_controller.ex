defmodule Finch.BundleEntryController do
  @moduledoc """
  We can CRUD bundles!
  """
  use Finch.Web, :controller
  alias Finch.Bundle
  alias Finch.BundleEntry

  plug :scrub_params, "bundle_entry" when action in [:create]

  def create(conn, %{"bundle_id" => bundle_code, "bundle_entry" => x}) do
    bundle = Bundle |> Repo.get_by!( code: bundle_code )
    item_id = x["item_id"]
    attrs   = %{ bundle_id: bundle.id, item_id: item_id }
    %BundleEntry{}
    |> BundleEntry.changeset(attrs)
    |> Repo.insert
    |> case do
      {:ok, _} ->
        conn
        |> put_flash(:info, "Item added successfully.")
        |> redirect(to: bundle_path(conn, :show, bundle.code))

      {:error, _} ->
        conn
        |> put_flash(:info, "Cannot add this Item.")
        |> redirect(to: bundle_path(conn, :show, bundle.code))
    end
  end
end
