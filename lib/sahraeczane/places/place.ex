defmodule Sahraeczane.Places.Place do
  use Ecto.Schema
  import Ecto.Changeset

  schema "places" do
    field :address, :string
    field :address2, :string
    field :custom_id, :string
    field :latitude, :float
    field :longitude, :float
    field :name, :string
    field :phone, :string
    field :type, Ecto.Enum, values: [:pharmacy, :hospital, :other]
    field :working_hours, :string
    belongs_to :province, Provinces.Province, foreign_key: :province_id
    belongs_to :district, Provinces.Province, foreign_key: :district_id

    timestamps()
  end

  @doc false
  def changeset(place, attrs) do
    place
    |> cast(attrs, [
      :name,
      :custom_id,
      :latitude,
      :longitude,
      :phone,
      :province_id,
      :district_id,
      :address,
      :address2,
      :working_hours,
      :type
    ])
    |> validate_required([
      :name,
      :custom_id,
      :province_id,
      :district_id,
      :latitude,
      :longitude,
      :address,
      :type
    ])
  end
end
