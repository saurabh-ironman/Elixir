defmodule Balancedtree do
  @moduledoc """
  Documentation for `Balancedtree`.
  """
  def make_node(val) do
    {nil, val, nil}
  end
# [1, 2, 3, 4, 5, 6, 7, 8]
  def createbalancebinarytree([]) do
    nil
  end

  def createbalancebinarytree(numbers) do
    mid = div(Enum.count(numbers), 2)
    {left, [root|right]} = Enum.split(numbers, mid)
    {createbalancebinarytree(left), root, createbalancebinarytree(right)}
  end

  def balancedtree(input_list) do
    createbalancebinarytree(input_list)
  end
end
