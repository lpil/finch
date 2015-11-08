defmodule Finch.Repo.Migrations.CreatePerson do
  use Ecto.Migration

  def change do
    # TODO: Remove
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

    create table(:items) do
      add :display_name, :string
      add :code, :string
      timestamps
    end
    create unique_index(:items, [:code])

    create table(:bundle_entries) do
      add :bundle_id,  references(:bundles)
      add :item_id, references(:items)
      timestamps
    end
    create unique_index(:bundle_entries, [:bundle_id, :item_id])
  end
end
