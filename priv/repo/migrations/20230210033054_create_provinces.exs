defmodule Sahraeczane.Repo.Migrations.CreateProvinces do
  use Ecto.Migration

  def change do
    create table(:provinces) do
      add :name, :string

      timestamps()
    end
  end
end
