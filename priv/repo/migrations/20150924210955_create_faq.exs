defmodule Finch.Repo.Migrations.CreateFAQ do
  use Ecto.Migration

  def change do
    create table(:faqs) do
      add :question, :string
      add :answer, :string

      timestamps
    end

  end
end
