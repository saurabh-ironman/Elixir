defmodule BinaryTreeTest do
  use ExUnit.Case
  doctest BinaryTree

  test "make tree with: 1, 2, 3" do
    input = [1, 2, 3]
    expected = {{nil, 2, nil}, 1, {nil, 3, nil}}
    assert BinaryTree.buildtree(input) == expected
  end
end

[1, 2, 3, 4, 5, 6, 7, 8, 9]
