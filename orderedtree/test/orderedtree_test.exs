defmodule OrderedTreeTest do
  use ExUnit.Case
  doctest OrderedTree

  test "one node" do
    input = [5]
    expected = {nil, 5, nil}
    assert OrderedTree.buildTree(input) == expected
  end

  test "two node" do
    input = [5, 3]
    expected = {{nil, 3, nil}, 5, nil}
    assert OrderedTree.buildTree(input) == expected
  end

  test "three node" do
    input = [5, 3, 6]
    expected = {{nil, 3, nil}, 5, {nil, 6, nil}}
    assert OrderedTree.buildTree(input) == expected
  end

  test "Four node" do
    input = [5, 3, 6, 8]
    expected = {{nil, 3, nil}, 5, {nil, 6, {nil, 8, nil}}}
    assert OrderedTree.buildTree(input) == expected
  end

  test "Five node" do
    input = [5, 3, 6, 8, 7]
    expected = {{nil, 3, nil}, 5, {nil, 6, {{nil, 7, nil}, 8, nil}}}
    assert OrderedTree.buildTree(input) == expected
  end
end
