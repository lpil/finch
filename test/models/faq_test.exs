defmodule Finch.FAQTest do
  use Finch.ModelCase

  alias Finch.FAQ

  @attrs %{answer: "Is it good?", question: "Yes."}

  describe "changeset validations" do
    it "can be valid" do
      changeset = FAQ.changeset(%FAQ{}, @attrs)
      assert changeset.valid?
    end

    it "is invalid without an answer" do
      attrs = %{ @attrs | answer: "" }
      changeset = FAQ.changeset(%FAQ{}, attrs)
      refute changeset.valid?
    end

    it "is invalid without a question" do
      attrs = %{ @attrs | question: "" }
      changeset = FAQ.changeset(%FAQ{}, attrs)
      refute changeset.valid?
    end

    it "is invalid with a really long question" do
      question = """
      Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam
      nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat,
      sed diam voluptua. At vero eos et accusam et justo duo dolores et ea
      rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem
      ipsum dolor sit amet?
      """
      attrs = %{ @attrs | question: question }
      changeset = FAQ.changeset(%FAQ{}, attrs)
      refute changeset.valid?
    end
  end
end
