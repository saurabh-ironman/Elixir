defmodule OrderedTree do
  @moduledoc """
  Documentation for `OrderedTree`.
  """
  def make_node(value) do
    {nil, value, nil}
  end
  def insert_val({left, value, right}, val) do
    cond do
      left == nil and val < value -> {make_node(val), value, nil}
      val < value -> {insert_val(left, val), value, nil}
      right == nil and val > value -> {left, value, make_node(val)}
      val > value -> {left, value, insert_val(right, val)}
    end
  end

  def insert_list(node, []) do
    node
  end

  def insert_list(node, [val | rest]) do
    insert_list(insert_val(node, val), rest)
  end

  def buildTree([root | rest]) do
    make_node(root)
    |> insert_list(rest)
  end
end
