defmodule Sahraeczane.PlacesTest do
  use Sahraeczane.DataCase

  alias Sahraeczane.Places

  describe "places" do
    alias Sahraeczane.Places.Place

    import Sahraeczane.PlacesFixtures

    @invalid_attrs %{address: nil, address2: nil, custom_id: nil, latitude: nil, longitude: nil, name: nil, phone: nil, type: nil, working_hours: nil}

    test "list_places/0 returns all places" do
      place = place_fixture()
      assert Places.list_places() == [place]
    end

    test "get_place!/1 returns the place with given id" do
      place = place_fixture()
      assert Places.get_place!(place.id) == place
    end

    test "create_place/1 with valid data creates a place" do
      valid_attrs = %{address: "some address", address2: "some address2", custom_id: "some custom_id", latitude: 120.5, longitude: 120.5, name: "some name", phone: "some phone", type: :pharmacy, working_hours: "some working_hours"}

      assert {:ok, %Place{} = place} = Places.create_place(valid_attrs)
      assert place.address == "some address"
      assert place.address2 == "some address2"
      assert place.custom_id == "some custom_id"
      assert place.latitude == 120.5
      assert place.longitude == 120.5
      assert place.name == "some name"
      assert place.phone == "some phone"
      assert place.type == :pharmacy
      assert place.working_hours == "some working_hours"
    end

    test "create_place/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Places.create_place(@invalid_attrs)
    end

    test "update_place/2 with valid data updates the place" do
      place = place_fixture()
      update_attrs = %{address: "some updated address", address2: "some updated address2", custom_id: "some updated custom_id", latitude: 456.7, longitude: 456.7, name: "some updated name", phone: "some updated phone", type: :hospital, working_hours: "some updated working_hours"}

      assert {:ok, %Place{} = place} = Places.update_place(place, update_attrs)
      assert place.address == "some updated address"
      assert place.address2 == "some updated address2"
      assert place.custom_id == "some updated custom_id"
      assert place.latitude == 456.7
      assert place.longitude == 456.7
      assert place.name == "some updated name"
      assert place.phone == "some updated phone"
      assert place.type == :hospital
      assert place.working_hours == "some updated working_hours"
    end

    test "update_place/2 with invalid data returns error changeset" do
      place = place_fixture()
      assert {:error, %Ecto.Changeset{}} = Places.update_place(place, @invalid_attrs)
      assert place == Places.get_place!(place.id)
    end

    test "delete_place/1 deletes the place" do
      place = place_fixture()
      assert {:ok, %Place{}} = Places.delete_place(place)
      assert_raise Ecto.NoResultsError, fn -> Places.get_place!(place.id) end
    end

    test "change_place/1 returns a place changeset" do
      place = place_fixture()
      assert %Ecto.Changeset{} = Places.change_place(place)
    end
  end
end
