defmodule Sahraeczane.Seeds do
  alias Sahraeczane.Provinces
  alias Sahraeczane.Districts

  def run do
    maybe_import_provinces_and_discrits()
  end

  defp maybe_import_provinces_and_discrits do
    if Provinces.list_provinces() |> Enum.empty?() do
      import_provinces_and_districts()
    end
  end

  def read_csv(file_name, headers) do
    local_path = if Mix.env() in [:dev, :prod], do: "./priv/repo/initial_data/", else: "./tmp/"
    file_path = (local_path <> file_name) |> Path.expand() |> Path.absname()

    File.stream!(file_path)
    |> Stream.drop(1)
    |> CSV.decode(
      validate_row_length: true,
      headers: headers
    )
    |> Enum.map(fn r ->
      {:ok, result} = r
      result
    end)
  end

  defp import_provinces_and_districts() do
    districts = read_csv("districts.csv", [:name, :province_id])
    provinces = read_csv("provinces.csv", [:id, :name])

    provinces
    |> Enum.each(fn province ->
      with {:ok, result} <- Provinces.create_province(province) do
        districts
        |> Enum.filter(fn district -> district.province_id == Integer.to_string(result.id) end)
        |> Enum.each(fn district ->
          IO.puts(
            "Province id from csv: #{district.province_id} #{district.name} and db record id : #{result.id} #{result.name}"
          )

          with {:ok, _} <-
                 Districts.create_district(%{
                   name: district.name,
                   province_id: result.id
                 }) do
          else
            {:error, _} -> IO.puts("District #{district.name} not created")
          end
        end)
      else
        {:error, _} -> IO.puts("Province #{province.name} not created")
      end
    end)
  end
end
