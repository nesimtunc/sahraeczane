defmodule SahraeczaneWeb.DistrictControllerTest do
  use SahraeczaneWeb.ConnCase

  import Sahraeczane.DistrictsFixtures

  alias Sahraeczane.Districts.District
  alias Sahraeczane.ProvincesFixtures

  @create_attrs %{
    name: "some name"
  }
  @update_attrs %{
    name: "some updated name"
  }
  @invalid_attrs %{name: nil, province_id: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all districts", %{conn: conn} do
      conn = get(conn, Routes.district_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create district" do
    test "renders district when data is valid", %{conn: conn} do
      province = ProvincesFixtures.province_fixture()

      new_district = %{name: @create_attrs.name, province_id: province.id}

      conn = post(conn, Routes.district_path(conn, :create), district: new_district)

      assert %{"id" => id} = json_response(conn, 201)["data"]
      conn = get(conn, Routes.district_path(conn, :show, id))

      province_id = province.id

      assert %{
               "id" => ^id,
               "name" => "some name",
               "province_id" => ^province_id
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.district_path(conn, :create), district: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update district" do
    setup [:create_district]

    test "renders district when data is valid", %{
      conn: conn,
      district: %District{id: id} = district
    } do
      conn = put(conn, Routes.district_path(conn, :update, district), district: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.district_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "name" => "some updated name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, district: district} do
      conn = put(conn, Routes.district_path(conn, :update, district), district: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete district" do
    setup [:create_district]

    test "deletes chosen district", %{conn: conn, district: district} do
      conn = delete(conn, Routes.district_path(conn, :delete, district))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.district_path(conn, :show, district))
      end
    end
  end

  defp create_district(_) do
    district = district_fixture()
    %{district: district}
  end
end
