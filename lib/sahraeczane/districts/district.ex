defmodule Sahraeczane.Districts.District do
  use Ecto.Schema
  import Ecto.Changeset
  alias Sahraeczane.Provinces

  schema "districts" do
    field :name, :string
    belongs_to :province, Provinces.Province, foreign_key: :province_id

    timestamps()
  end

  def changeset(district, attrs) do
    district
    |> cast(attrs, [:name, :province_id])
    |> validate_required([:name, :province_id])
  end
end
