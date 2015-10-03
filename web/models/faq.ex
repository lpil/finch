defmodule Finch.FAQ do
  @moduledoc """
  An FAQ is a question and answer pair.
  """

  use Finch.Web, :model

  schema "faqs" do
    field :question, :string
    field :answer,   :string
    timestamps
  end


  @required_fields ~w(question answer)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> validate_question
    |> validate_answer
  end


  defp validate_question(model) do
    model
    |> validate_length(:question, min: 1, max: 250)
  end

  defp validate_answer(model) do
    model
    |> validate_length(:answer, min: 1)
  end
end
