defmodule SahraeczaneWeb.ProvinceControllerTest do
  use SahraeczaneWeb.ConnCase

  import Sahraeczane.ProvincesFixtures

  alias Sahraeczane.Provinces.Province

  @create_attrs %{
    name: "some name"
  }
  @update_attrs %{
    name: "some updated name"
  }
  @invalid_attrs %{name: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all provinces", %{conn: conn} do
      conn = get(conn, Routes.province_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create province" do
    test "renders province when data is valid", %{conn: conn} do
      conn = post(conn, Routes.province_path(conn, :create), province: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.province_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "name" => "some name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.province_path(conn, :create), province: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update province" do
    setup [:create_province]

    test "renders province when data is valid", %{conn: conn, province: %Province{id: id} = province} do
      conn = put(conn, Routes.province_path(conn, :update, province), province: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.province_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "name" => "some updated name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, province: province} do
      conn = put(conn, Routes.province_path(conn, :update, province), province: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete province" do
    setup [:create_province]

    test "deletes chosen province", %{conn: conn, province: province} do
      conn = delete(conn, Routes.province_path(conn, :delete, province))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.province_path(conn, :show, province))
      end
    end
  end

  defp create_province(_) do
    province = province_fixture()
    %{province: province}
  end
end
