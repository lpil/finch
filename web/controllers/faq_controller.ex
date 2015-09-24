defmodule Finch.FAQController do
  use Finch.Web, :controller

  alias Finch.FAQ

  plug :scrub_params, "faq" when action in [:create, :update]

  def index(conn, _params) do
    faqs = Repo.all(FAQ)
    render(conn, "index.html", faqs: faqs)
  end

  def new(conn, _params) do
    changeset = FAQ.changeset(%FAQ{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"faq" => faq_params}) do
    changeset = FAQ.changeset(%FAQ{}, faq_params)

    case Repo.insert(changeset) do
      {:ok, _faq} ->
        conn
        |> put_flash(:info, "Faq created successfully.")
        |> redirect(to: faq_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    faq = Repo.get!(FAQ, id)
    render(conn, "show.html", faq: faq)
  end

  def edit(conn, %{"id" => id}) do
    faq = Repo.get!(FAQ, id)
    changeset = FAQ.changeset(faq)
    render(conn, "edit.html", faq: faq, changeset: changeset)
  end

  def update(conn, %{"id" => id, "faq" => faq_params}) do
    faq = Repo.get!(FAQ, id)
    changeset = FAQ.changeset(faq, faq_params)

    case Repo.update(changeset) do
      {:ok, faq} ->
        conn
        |> put_flash(:info, "Faq updated successfully.")
        |> redirect(to: faq_path(conn, :show, faq))
      {:error, changeset} ->
        render(conn, "edit.html", faq: faq, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    faq = Repo.get!(FAQ, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(faq)

    conn
    |> put_flash(:info, "Faq deleted successfully.")
    |> redirect(to: faq_path(conn, :index))
  end
end
