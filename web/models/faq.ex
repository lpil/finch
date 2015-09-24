defmodule Finch.FAQ do
  use Finch.Web, :model

  schema "faqs" do
    field :question, :string
    field :answer,   :string
    timestamps
  end

  @required ~w(question answer)
  @optional ~w()

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required, @optional)
    |> validate_length(:question, min: 1)
    |> validate_length(:answer,   min: 1)
  end
end
