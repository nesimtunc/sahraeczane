defmodule Sahraeczane.DistrictsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Sahraeczane.Districts` context.
  """

  @doc """
  Generate a district.
  """
  def district_fixture(attrs \\ %{}) do
    {:ok, province} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> Sahraeczane.Provinces.create_province()

    {:ok, district} =
      attrs
      |> Enum.into(%{
        name: "some name",
        province_id: province.id
      })
      |> Sahraeczane.Districts.create_district()

    district
  end
end
