defmodule SahraeczaneWeb.PlaceLive.Index do
  use SahraeczaneWeb, :live_view

  alias Sahraeczane.Places
  alias Sahraeczane.Places.Place
  alias Sahraeczane.Provinces
  alias Sahraeczane.Districts
  

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :places, list_places())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Place")
    |> assign(:place, Places.get_place!(id))
  end

  defp apply_action(socket, :new, _params) do
    provinces = Provinces.list_provinces()
    first_province = provinces |> Enum.at(1)

    socket
    |> assign(:provinces, provinces)
    |> assign(:districts, Districts.list_districts_by_province(first_province.id))
    |> assign(:page_title, "New Place")
    |> assign(:place, %Place{
      province_id: first_province.id
    })
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Places")
    |> assign(:place, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    place = Places.get_place!(id)
    {:ok, _} = Places.delete_place(place)

    {:noreply, assign(socket, :places, list_places())}
  end

  @impl true
  def handle_event("province_changed", params, socket) do
    IO.inspect(params)
    # {:noreply, assign(socket, :districts, Districts.list_districts_by_province(params["province_id"]))}
    {:noreply, socket}
  end

  defp list_places do
    Places.list_places()
  end
end
