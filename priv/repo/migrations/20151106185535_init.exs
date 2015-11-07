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

    create table(:products) do
      add :display_name, :string
      add :code, :string
      timestamps
    end
    create unique_index(:products, [:code])

    create table(:bundle_memberships) do
      add :bundle_id,  references(:bundles)
      add :product_id, references(:products)
      timestamps
    end
    create unique_index(:bundle_memberships, [:bundle_id, :product_id])
  end
end
