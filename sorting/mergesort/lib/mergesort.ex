defmodule Mergesort do
  @moduledoc """
  Documentation for `Mergesort`.
  """
  def print(ds), do: ds |> inspect |> IO.puts
  def compare_and_combine([], [], acc), do: acc
  def compare_and_combine(left, [], acc), do: acc ++ left
  def compare_and_combine([], right, acc), do: acc ++ right
  def compare_and_combine(left=[lhead|lrest], right=[rhead|rrest], acc) do
    cond do
      lhead < rhead -> compare_and_combine(lrest, right, acc ++ [lhead])
      true -> compare_and_combine(left, rrest, acc ++ [rhead])
    end
  end

  def sort([a]), do: [a]

  def sort(nums) do
    mid = div(Enum.count(nums), 2)
    {left, right} = Enum.split(nums, mid)
    compare_and_combine(sort(left), sort(right), [])
  end
end
