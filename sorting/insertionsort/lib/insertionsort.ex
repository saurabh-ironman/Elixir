defmodule Insertionsort do
  @moduledoc """
  Documentation for `Insertionsort`.
  """
  def isort(first, []), do: [first]
  def isort(first, [key|rest]) do
    cond do
      first > key -> [key|isort(first, rest)]
      true -> [first|isort(key, rest)]
    end
  end
  def sort([]), do: []
  def sort([first|rest]) do
    sorted_list = isort(first, rest)
    cond do
      sorted_list == [first|rest] -> sorted_list
      true -> sort(sorted_list)
    end
  end
end
