defmodule Binarytree2 do
  @moduledoc """
  Documentation for `Binarytree2`.
  """
  def make_node(value) do
    {nil, value, nil}
  end
  # def insert_val(node, val) do
  #   case node do
  #     {nil, value, nil} -> {make_node(val), value, nil}
  #     {left, value, nil} -> {left, value, make_node(val)}
  #     {left, value, right} -> {insert_val(left, val), value, right}
  #   end
  # end

  def insert_val({nil, value, nil}, val) do
    {make_node(val), value, nil}
  end
  
  def insert_val({left, value, nil}, val) do
    {left, value, make_node(val)}
  end

  def insert_val({left, value, right}, val) do
    {insert_val(left, val), value, right}
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
