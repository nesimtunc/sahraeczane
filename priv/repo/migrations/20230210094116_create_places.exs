defmodule Sahraeczane.Repo.Migrations.CreatePlaces do
  use Ecto.Migration

  def change do
    create table(:places) do
      add :name, :string
      add :custom_id, :string
      add :latitude, :float
      add :longitude, :float
      add :phone, :string
      add :address, :string
      add :address2, :string
      add :working_hours, :string
      add :type, :string
      add :provice_id, references(:provinces, on_delete: :nothing)
      add :district_id, references(:districts, on_delete: :nothing)

      timestamps()
    end

    create index(:places, [:provice_id])
    create index(:places, [:district_id])
  end
end
