defmodule Sahraeczane.PlacesFixtures do
  alias Sahraeczane.Provinces
  alias Sahraeczane.Districts

  @moduledoc """
  This module defines test helpers for creating
  entities via the `Sahraeczane.Places` context.
  """

  @doc """
  Generate a place.
  """
  def place_fixture(attrs \\ %{}) do
    {:ok, province} = Provinces.create_province(%{name: "some name"})
    {:ok, district} = Districts.create_district(%{name: "some name", province_id: province.id})

    {:ok, place} =
      attrs
      |> Enum.into(%{
        address: "some address",
        address2: "some address2",
        custom_id: "some custom_id",
        latitude: 120.5,
        longitude: 120.5,
        name: "some name",
        phone: "some phone",
        type: :pharmacy,
        working_hours: "some working_hours",
        province_id: province.id,
        district_id: district.id
      })
      |> Sahraeczane.Places.create_place()

    place
  end
end
