defmodule Sahraeczane.DistrictsTest do
  use Sahraeczane.DataCase

  alias Sahraeczane.Districts
  alias Sahraeczane.ProvincesFixtures

  describe "districts" do
    alias Sahraeczane.Districts.District

    import Sahraeczane.DistrictsFixtures

    @invalid_attrs %{name: nil, province_id: nil}

    test "list_districts/0 returns all districts" do
      district = district_fixture()
      assert Districts.list_districts() == [district]
    end

    test "get_district!/1 returns the district with given id" do
      district = district_fixture()
      assert Districts.get_district!(district.id) == district
    end

    test "create_district/1 with valid data creates a district" do
      province = ProvincesFixtures.province_fixture()
      valid_attrs = %{name: "some name", province_id: province.id}

      assert {:ok, %District{} = district} = Districts.create_district(valid_attrs)
      assert district.name == "some name"
    end

    test "create_district/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Districts.create_district(@invalid_attrs)
    end

    test "update_district/2 with valid data updates the district" do
      district = district_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %District{} = district} = Districts.update_district(district, update_attrs)
      assert district.name == "some updated name"
    end

    test "update_district/2 with invalid data returns error changeset" do
      district = district_fixture()
      assert {:error, %Ecto.Changeset{}} = Districts.update_district(district, @invalid_attrs)
      assert district == Districts.get_district!(district.id)
    end

    test "delete_district/1 deletes the district" do
      district = district_fixture()
      assert {:ok, %District{}} = Districts.delete_district(district)
      assert_raise Ecto.NoResultsError, fn -> Districts.get_district!(district.id) end
    end

    test "change_district/1 returns a district changeset" do
      district = district_fixture()
      assert %Ecto.Changeset{} = Districts.change_district(district)
    end
  end
end
