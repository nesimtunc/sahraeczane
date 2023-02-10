defmodule SahraeczaneWeb.ProvinceController do
  use SahraeczaneWeb, :controller

  alias Sahraeczane.Provinces
  alias Sahraeczane.Provinces.Province

  action_fallback SahraeczaneWeb.FallbackController

  def index(conn, _params) do
    provinces = Provinces.list_provinces()
    render(conn, "index.json", provinces: provinces)
  end

  def create(conn, %{"province" => province_params}) do
    with {:ok, %Province{} = province} <- Provinces.create_province(province_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.province_path(conn, :show, province))
      |> render("show.json", province: province)
    end
  end

  def show(conn, %{"id" => id}) do
    province = Provinces.get_province!(id)
    render(conn, "show.json", province: province)
  end

  def update(conn, %{"id" => id, "province" => province_params}) do
    province = Provinces.get_province!(id)

    with {:ok, %Province{} = province} <- Provinces.update_province(province, province_params) do
      render(conn, "show.json", province: province)
    end
  end

  def delete(conn, %{"id" => id}) do
    province = Provinces.get_province!(id)

    with {:ok, %Province{}} <- Provinces.delete_province(province) do
      send_resp(conn, :no_content, "")
    end
  end
end
