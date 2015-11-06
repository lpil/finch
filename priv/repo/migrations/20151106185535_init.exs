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

  end
end
