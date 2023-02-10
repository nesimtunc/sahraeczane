defmodule SahraeczaneWeb.DistrictController do
  use SahraeczaneWeb, :controller

  alias Sahraeczane.Districts
  alias Sahraeczane.Districts.District

  action_fallback SahraeczaneWeb.FallbackController

  def index(conn, _params) do
    districts = Districts.list_districts()
    render(conn, "index.json", districts: districts)
  end

  def create(conn, %{"district" => district_params}) do
    with {:ok, %District{} = district} <- Districts.create_district(district_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.district_path(conn, :show, district))
      |> render("show.json", district: district)
    end
  end

  def show(conn, %{"id" => id}) do
    district = Districts.get_district!(id)
    render(conn, "show.json", district: district)
  end

  def update(conn, %{"id" => id, "district" => district_params}) do
    district = Districts.get_district!(id)

    with {:ok, %District{} = district} <- Districts.update_district(district, district_params) do
      render(conn, "show.json", district: district)
    end
  end

  def delete(conn, %{"id" => id}) do
    district = Districts.get_district!(id)

    with {:ok, %District{}} <- Districts.delete_district(district) do
      send_resp(conn, :no_content, "")
    end
  end
end
