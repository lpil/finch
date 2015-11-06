defmodule Finch.Repo.Migrations.CreatePerson do
  use Ecto.Migration

  def change do
    create table(:people) do
      add :name, :string
      add :email, :string
      add :bio, :string
      add :number_of_pets, :integer
      timestamps
    end

    create table(:bundles) do
      add :name, :string
      timestamps
    end
    create unique_index(:bundles, [:name])
  end
end
