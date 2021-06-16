defmodule Quicksort do
  @moduledoc """
  Documentation for `Quicksort`.
  """
  def sort([]), do: []
  def sort([a]), do: [a]
  def sort([pivot|rest]) do
    {smaller, bigger} = Enum.split_with(rest, &(&1 < pivot))
    sort(smaller) ++ [pivot] ++ sort(bigger)
  end
end
