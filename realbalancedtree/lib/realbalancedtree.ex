defmodule Realbalancedtree do
  @moduledoc """
  Documentation for `Realbalancedtree`.
  """
  def balancetree({{l, v, r}, val, right})
  when v > val do
    balancetree({{l, val, r}, v, right})
  end

  def balancetree({left, val, {l, v, r}})
  when v < val do
    balancetree({left, v, {l, val, r}})
  end

  # {{nil, 2, nil}, 3, {nil, 1, nil}}
  def balancetree({left, val, right}) do
    {left, val, right}
  end

  def buildTree([]) do
    nil
  end

  def buildTree(numbers) do
    mid = div(Enum.count(numbers), 2)
    {left, [node|right]} = Enum.split(numbers, mid)
    {buildTree(left), node, buildTree(right)}
  end

  def realbalancedtree(input_list) do
    balancetree(buildTree(input_list))
    #buildTree(input_list)
  end
end
