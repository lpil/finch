defmodule Finch.Repo.Migrations.Init do
  use Ecto.Migration

  def change do
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

    create table(:users) do
      add :email, :string
      add :password_digest, :string
      timestamps
    end
    create unique_index(:users, [:email])
  end
end
