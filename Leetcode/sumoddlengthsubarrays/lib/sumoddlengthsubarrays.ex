defmodule Sumoddlengthsubarrays do
  @moduledoc """
  Documentation for `Sumoddlengthsubarrays`.
  """
  # We have listed 3 different ways of solving this problem
  # First 2 solutions are commented please un-comment and explore
  # Solution 1

  # def sum(sublist_length, list, total)
  # when length(list) < sublist_length do
  #   total
  # end
  #
  # def sum(sublist_length, list, total)do
  #   sum_ = list
  #   |> Enum.take(sublist_length)
  #   |> Enum.sum
  #   sum(sublist_length, tl(list), total + sum_)
  # end

  # def sum_sub_array(array) do
  #   1..(Enum.count(array))//2
  #   |> Enum.map(&sum(&1, array, 0))
  #   |> Enum.sum
  # end

  # Solution 2
  # def sum_sub_array(array) do
  #   1..(Enum.count(array))//2
  #   |> Enum.map(&(Enum.chunk_every(array, &1, 1, :discard)))
  #   |> List.flatten
  #   |> Enum.sum
  #

  # Solution 3
  def sum_sub_array(array) do
    1..(Enum.count(array))//2
    |> Enum.flat_map(&(Enum.chunk_every(array, &1, 1, :discard)))
    |> Enum.flat_map(&(&1))
    |> Enum.sum
  end
end
