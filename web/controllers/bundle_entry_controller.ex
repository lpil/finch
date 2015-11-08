defmodule Finch.BundleEntryController do
  @moduledoc """
  We can CRUD bundles!
  """
  use Finch.Web, :controller
  alias Finch.Bundle
  alias Finch.BundleEntry
  alias Finch.Item

  plug :scrub_params, "bundle" when action in [:create] #, :update]

  # def create(conn, %{"bundle" => params}) do
  #   %BundleEntry{}
  #   |> Bundle.changeset(params)
  #   |> Repo.insert
  #   |> case do
  #     {:ok, _} ->
  #       conn
  #       |> put_flash(:info, "Bundle created successfully.")
  #       |> redirect(to: bundle_path(conn, :index))

  #     {:error, changeset} ->
  #       conn
  #       |> render "new.html", changeset: changeset
  #   end
  # end
end
