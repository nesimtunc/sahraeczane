defmodule SahraeczaneWeb.PlaceLive.Show do
  use SahraeczaneWeb, :live_view

  alias Sahraeczane.Places
  alias Sahraeczane.Provinces
  alias Sahraeczane.Districts

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    place = Places.get_place!(id)
    provinces = Provinces.list_effected_provinces()
    districts = Districts.list_districts_by_province(place.province_id)

    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:place, place)
     |> assign(:provinces, provinces)
     |> assign(:districts, districts)
    }
  end

  defp page_title(:show), do: "Show Place"
  defp page_title(:edit), do: "Edit Place"
end
