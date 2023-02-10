defmodule Sahraeczane.Seeds do
    alias Sahraeczane.Provinces

    def run do
        maybe_import_provinces()
    end

    def maybe_import_provinces do
        if Provinces.list_provinces() |> Enum.empty? do
            import_provinces("provinces.csv")
        end
    end

    def import_provinces(file_name) do
        local_path = if Mix.env() == :dev, do: "./priv/repo/initial_data/", else: "./tmp/"
        file_path = (local_path <> file_name) |> Path.expand() |> Path.absname()

        File.stream!(file_path)
        |> Stream.drop(1)
        |> CSV.decode(
            validate_row_length: true,
            headers: [:id, :name]
        )
        |> Enum.each(fn r ->
            {:ok, result} = r

            with {:ok, _} <- Provinces.create_province(result) do
                IO.puts("Province #{result.name} created")
            else
                {:error, _} -> IO.puts("Province #{result.name} not created")
            end
        end)
    end

end
