defmodule Sahraeczane.Repo.Migrations.CreateDistricts do
  use Ecto.Migration

  def change do
    create table(:districts) do
      add :name, :string
      add :province_id, references(:provinces, on_delete: :delete_all)

      timestamps()
    end

    create index(:districts, [:province_id])
  end
end
