defmodule Sahraeczane.PlacesFixtures do
  alias Sahraeczane.Provinces
  alias Sahraeczane.Districts

  import Sahraeczane.ProvincesFixtures
  import Sahraeczane.DistrictsFixtures

  @moduledoc """
  This module defines test helpers for creating
  entities via the `Sahraeczane.Places` context.
  """

  @doc """
  Generate a place.
  """
  def place_fixture(attrs \\ %{}) do
    district = district_fixture


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
        province_id: district.province_id,
        district_id: district.id
      })
      |> Sahraeczane.Places.create_place()

    place
  end
end
