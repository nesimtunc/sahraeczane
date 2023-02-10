defmodule SahraeczaneWeb.ProvinceView do
  use SahraeczaneWeb, :view
  alias SahraeczaneWeb.ProvinceView

  def render("index.json", %{provinces: provinces}) do
    %{data: render_many(provinces, ProvinceView, "province.json")}
  end

  def render("show.json", %{province: province}) do
    %{data: render_one(province, ProvinceView, "province.json")}
  end

  def render("province.json", %{province: province}) do
    %{
      id: province.id,
      name: province.name
    }
  end
end
