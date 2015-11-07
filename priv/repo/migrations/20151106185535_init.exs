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
      add :display_name, :string
      add :code, :string
      timestamps
    end
    create unique_index(:bundles, [:display_name])
    create unique_index(:bundles, [:code])
  end
end
