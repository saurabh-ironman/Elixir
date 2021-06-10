defmodule BinaryTree do
  @moduledoc """
  Documentation for `BinaryTree`.
  """
  # def buildtree(input_nodes) do
  #   root = hd(input_nodes)
  #   subtree = tl(input_nodes)
  #   if Enum.at(input_nodes, 1) != nil do
  #     left = Enum.at(input_nodes, 1)
  #   end
  #   if Enum.at(input_nodes, 2) != nil do
  #     right = Enum.at(input_nodes, 2)
  #   end
  #   {left, root, right}
  #   insert_node(subtree)
  # end
  #def something(nil|[]|basic_pattern_to_match, value) do
  # end
  #
  # def something(use_pattern_match_here, value) do
  # end
  def insert_nodes(_node, []) do
    nil
  end
  def insert_nodes(node, [left|values]) do
    if node = {nil, _val, nil} do
      left_node = make_node(left)
      updated_node = put_elem(node, 0, left_node)
      insert_node(left_node, [left|values])
    end
  end

  def make_node(value) do
    {nil, value, nil}
  end

  def buildtree([]) do
    {nil}
  end

  def buildtree([val]) do
    {nil, val, nil}
  end

  def buildtree([root|values]) do
    root_node = make_node(root)
    left = hd(values)
    remaining_values = tl(values)
    insert_nodes(root_node, [left | remaining_values])
  end
end

l1 = [1, 2, 3]

l1
|> BinaryTree.buildtree
|> inspect
|> IO.puts
