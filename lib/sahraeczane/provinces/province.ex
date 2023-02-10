defmodule Sahraeczane.Provinces.Province do
  alias Sahraeczane.Districts
  use Ecto.Schema
  import Ecto.Changeset

  schema "provinces" do
    field :name, :string
    has_many :districts, Districts.District, foreign_key: :province_id

    timestamps()
  end

  @doc false
  def changeset(province, attrs) do
    province
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
