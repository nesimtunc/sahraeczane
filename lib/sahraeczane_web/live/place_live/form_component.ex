defmodule SahraeczaneWeb.PlaceLive.FormComponent do
  use SahraeczaneWeb, :live_component

  alias Sahraeczane.Places
  alias Sahraeczane.Districts

  @impl true
  def update(%{place: place} = assigns, socket) do
    changeset = Places.change_place(place)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"place" => place_params}, socket) do
    changeset =
      socket.assigns.place
      |> Places.change_place(place_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  @impl true
  def handle_event("province_changed", params, socket) do
    place = Map.get(params, "place")
    province_id = Map.get(place, "province_id")
    districts = Districts.list_districts_by_province(province_id)
    {:noreply, assign(socket, :districts, districts)}
  end

  def handle_event("save", %{"place" => place_params}, socket) do
    save_place(socket, socket.assigns.action, place_params)
  end

  defp save_place(socket, :edit, place_params) do
    case Places.update_place(socket.assigns.place, place_params) do
      {:ok, _place} ->
        {:noreply,
         socket
         |> put_flash(:info, "Place updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_place(socket, :new, place_params) do
    case Places.create_place(place_params) do
      {:ok, _place} ->
        {:noreply,
         socket
         |> put_flash(:info, "Place created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
