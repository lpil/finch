defmodule Finch.FAQTest do
  use Finch.ModelCase

  alias Finch.FAQ

  test "changeset with valid attributes" do
    attrs = %{ question: "Foo?", answer: "Bar." }
    changeset = FAQ.changeset(%FAQ{}, attrs)
    assert changeset.valid?
  end

  test "changeset without question" do
    attrs = %{ answer: "Bar." }
    changeset = FAQ.changeset(%FAQ{}, attrs)
    refute changeset.valid?
  end

  test "changeset without answer" do
    attrs = %{ question: "Foo?" }
    changeset = FAQ.changeset(%FAQ{}, attrs)
    refute changeset.valid?
  end

  test "changeset with blank question" do
    attrs = %{ question: "", answer: "Bar." }
    changeset = FAQ.changeset(%FAQ{}, attrs)
    refute changeset.valid?
  end

  test "changeset with blank answer" do
    attrs = %{ question: "Foo?", answer: "" }
    changeset = FAQ.changeset(%FAQ{}, attrs)
    refute changeset.valid?
  end
end
