defmodule Jsonprocessing do
  @moduledoc """
  Documentation for `Jsonprocessing`.
  """
  def readfile(file_name) do
    file = File.open!(file_name, [:read, :utf8])
    IO.stream(file, :line) |> Enum.take(250_000) |> inspect |> IO.puts()
    File.close(file)
  end
  def jsonprocessing(input_file) do
    readfile(input_file)
  end
end

Jsonprocessing.jsonprocessing("")
|> inspect
|> IO.puts()
