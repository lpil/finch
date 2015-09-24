defmodule Finch.FAQControllerTest do
  use Finch.ConnCase

  alias Finch.FAQ

  @valid_attrs %{answer: "Foo?", question: "Bar."}
  @invalid_attrs %{}

  setup do
    {:ok, conn: conn}
  end

  describe "GET index" do
    it "lists all entries on index" do
      conn = get conn, faq_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing faqs"
    end
  end

  describe "GET new" do
    it "renders form for new resources", %{conn: conn} do
      conn = get conn, faq_path(conn, :new)
      assert html_response(conn, 200) =~ "New faq"
    end
  end


  describe "POST create" do
    test "creates resource and redirects when data is valid", %{conn: conn} do
      conn = post conn, faq_path(conn, :create), faq: @valid_attrs
      assert redirected_to(conn) == faq_path(conn, :index)
      assert Repo.get_by(FAQ, @valid_attrs)
    end

    test "does not create resource and renders errors when data is invalid", %{conn: conn} do
      conn = post conn, faq_path(conn, :create), faq: @invalid_attrs
      assert html_response(conn, 200) =~ "New faq"
    end
  end


  describe "GET show" do
    test "shows chosen resource", %{conn: conn} do
      faq = Repo.insert! %FAQ{}
      conn = get conn, faq_path(conn, :show, faq)
      assert html_response(conn, 200) =~ "Show faq"
    end

    test "renders page not found when id is nonexistent", %{conn: conn} do
      assert_raise Ecto.NoResultsError, fn ->
        get conn, faq_path(conn, :show, -1)
      end
    end
  end


  describe "GET edit" do
    test "renders form for editing chosen resource", %{conn: conn} do
      faq = Repo.insert! %FAQ{}
      conn = get conn, faq_path(conn, :edit, faq)
      assert html_response(conn, 200) =~ "Edit faq"
    end
  end


  describe "PATCH update" do
    test "updates chosen resource and redirects when data is valid", %{conn: conn} do
      faq = Repo.insert! %FAQ{}
      conn = put conn, faq_path(conn, :update, faq), faq: @valid_attrs
      assert redirected_to(conn) == faq_path(conn, :show, faq)
      assert Repo.get_by(FAQ, @valid_attrs)
    end

    test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
      faq = Repo.insert! %FAQ{}
      conn = put conn, faq_path(conn, :update, faq), faq: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit faq"
    end
  end


  describe "DELETE delete" do
    test "deletes chosen resource", %{conn: conn} do
      faq = Repo.insert! %FAQ{}
      conn = delete conn, faq_path(conn, :delete, faq)
      assert redirected_to(conn) == faq_path(conn, :index)
      refute Repo.get(FAQ, faq.id)
    end
  end
end
