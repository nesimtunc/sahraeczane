defmodule Sahraeczane.Provinces.Province do
  use Ecto.Schema
  import Ecto.Changeset

  schema "provinces" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(province, attrs) do
    province
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
