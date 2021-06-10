defmodule Binarytree3Test do
  use ExUnit.Case
  doctest Binarytree3

  test "one node" do
      input = 1..1 |> Enum.to_list
      expected = {nil, 1, nil}
      assert Binarytree3.buildTree(input) == expected
    end

    test "two node" do
      input = 1..2 |> Enum.to_list
      expected = {nil, 1, {nil, 2, nil}}
      assert Binarytree3.buildTree(input) == expected
    end

    test "three node" do
      input = 1..3 |> Enum.to_list
      expected = {nil, 1, {nil, 2, {nil, 3, nil}}}
      assert Binarytree3.buildTree(input) == expected
    end

    test "Four node" do
      input = 1..4 |> Enum.to_list
      expected = {nil, 1, {nil, 2, {nil, 3, {nil, 4, nil}}}}
      assert Binarytree3.buildTree(input) == expected
    end

    test "Five node" do
      input = 1..5 |> Enum.to_list
      expected = {nil, 1, {nil, 2, {nil, 3, {nil, 4, {nil, 5, nil}}}}}
      assert Binarytree3.buildTree(input) == expected
    end
    test "Is one in Five node" do
      input = {nil, 1, {nil, 2, {nil, 3, {nil, 4, {nil, 5, nil}}}}}
      val_to_search = 1
      assert Binarytree3.in?(input, val_to_search) == true
    end
    test "Is ten in Five node" do
      input = {nil, 1, {nil, 2, {nil, 3, {nil, 4, {nil, 5, nil}}}}}
      val_to_search = 10
      assert Binarytree3.in?(input, val_to_search) == false
    end
    test "Five node [2, 1, 4, 5, 3]" do
      input = [2, 1, 4, 5, 3]
      expected = {{nil, 1, nil}, 2, {{nil, 3, nil}, 4, {nil, 5, nil}}}
      assert Binarytree3.buildTree(input) == expected
    end
    test "Is 4 in Five node [2, 1, 4, 5, 3]" do
      input = [2, 1, 4, 5, 3]
      assert Binarytree3.in?(Binarytree3.buildTree(input), 4) == true
    end
    test "Is 10 in Five node [2, 1, 4, 5, 3]" do
      input = [2, 1, 4, 5, 3]
      assert Binarytree3.in?(Binarytree3.buildTree(input), 10) == false
    end
end
