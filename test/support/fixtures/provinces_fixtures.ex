defmodule Sahraeczane.ProvincesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Sahraeczane.Provinces` context.
  """

  @doc """
  Generate a province.
  """
  def province_fixture(attrs \\ %{}) do
    {:ok, province} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> Sahraeczane.Provinces.create_province()

    province
  end
end
