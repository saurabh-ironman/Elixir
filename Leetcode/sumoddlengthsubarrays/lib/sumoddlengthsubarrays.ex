# defmodule Sumoddlengthsubarrays1 do
#   @moduledoc """
#   Documentation for `Sumoddlengthsubarrays`.
#   """
#   def sum_odd_arrays(arr, start_inx, odd_inx, sum) do
#     if odd_inx > Enum.count(arr) do
#       sum
#     else
#       sum = sum + (Enum.slice(arr, start_inx, odd_inx) |> Enum.sum)
#       sum_odd_arrays(arr, start_inx + 1, odd_inx + 1, sum)
#     end
#   end
#
#   def sum_sub_array([]), do: 0
#   def sum_sub_array([a]), do: a
#   def sum_sub_array(array) do
#     1..(array |> Enum.count)
#     |> Enum.filter(fn x -> rem(x, 2) != 0 end)
#     |> Enum.filter(&(rem(&1, 2) != 0))
#     |> (fn x -> sum_odd_arrays(array, 0, x, 0) end)
#   end
# end

defmodule Sumoddlengthsubarrays do

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
