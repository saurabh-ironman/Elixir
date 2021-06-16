defmodule Bubblesort do
  @moduledoc """
  Documentation for `Bubblesort`.
  """
  def sort([]), do: []
  def sort([a|[]]), do: [a]
  def sort([first, second | rest]) do
    cond do
      first <= second -> [first | sort([second|rest])]
      true -> [second | sort([first | rest])]
    end
  end
  def bsort(input_list) do
    sorted_list = sort(input_list)
    cond do
      sorted_list == input_list -> sorted_list
      true -> bsort(sorted_list)
    end
  end
end
