defmodule Binarytree2Test do
  use ExUnit.Case
  doctest Binarytree2

  test "one node" do
    input = 1..1 |> Enum.to_list
    expected = {nil, 1, nil}
    assert Binarytree2.buildTree(input) == expected
  end

  test "two node" do
    input = 1..2 |> Enum.to_list
    expected = {{nil, 2, nil}, 1, nil}
    assert Binarytree2.buildTree(input) == expected
  end

  test "three node" do
    input = 1..3 |> Enum.to_list
    expected = {{nil, 2, nil}, 1, {nil, 3, nil}}
    assert Binarytree2.buildTree(input) == expected
  end

  test "Four node" do
    input = 1..4 |> Enum.to_list
    expected = {{{nil, 4, nil}, 2, nil}, 1, {nil, 3, nil}}
    assert Binarytree2.buildTree(input) == expected
  end

  test "Five node" do
    input = 1..5 |> Enum.to_list
    expected = {{{nil, 4, nil}, 2, {nil, 5, nil}}, 1, {nil, 3, nil}}
    assert Binarytree2.buildTree(input) == expected
  end

  test "Six node" do
    input = 1..6 |> Enum.to_list
    expected = {{{{nil, 6, nil}, 4, nil}, 2, {nil, 5, nil}}, 1, {nil, 3, nil}}
    assert Binarytree2.buildTree(input) == expected
  end

  test "Seven node" do
    input = 1..7 |> Enum.to_list
    expected = {{{{nil, 6, nil}, 4, {nil, 7, nil}}, 2, {nil, 5, nil}}, 1, {nil, 3, nil}}
    assert Binarytree2.buildTree(input) == expected
  end

  test "Eight node" do
    input = 1..8 |> Enum.to_list
    expected = {{{{{nil, 8, nil}, 6, nil}, 4, {nil, 7, nil}}, 2, {nil, 5, nil}}, 1, {nil, 3, nil}}
    assert Binarytree2.buildTree(input) == expected
  end
end
