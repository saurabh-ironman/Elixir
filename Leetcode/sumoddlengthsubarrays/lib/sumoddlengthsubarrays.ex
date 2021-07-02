defmodule Sumoddlengthsubarrays do
  @moduledoc """
  Documentation for `Sumoddlengthsubarrays`.
  """
  def sum(sublist_length, list, total)
  when length(list) < sublist_length do
    total
  end

  def sum(sublist_length, list, total)do
    sum_ = list
    |> Enum.take(sublist_length)
    |> Enum.sum
    sum(sublist_length, tl(list), total + sum_)
  end

  def sum_sub_array(array) do
    1..(Enum.count(array))//2
    |> Enum.map(&sum(&1, array, 0))
    |> Enum.sum
  end
end
