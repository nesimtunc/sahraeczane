defmodule Sahraeczane.PlacesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Sahraeczane.Places` context.
  """

  @doc """
  Generate a place.
  """
  def place_fixture(attrs \\ %{}) do
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
        working_hours: "some working_hours"
      })
      |> Sahraeczane.Places.create_place()

    place
  end
end
