defmodule Finch.Repo.Migrations.Init do
  use Ecto.Migration

  def change do
    create table(:faqs) do
      add :question, :text, null: false
      add :answer,   :text, null: false

      timestamps
    end

  end
end
