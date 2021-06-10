defmodule BalancedtreeTest do
  use ExUnit.Case
  doctest Balancedtree

  test "One node balanced tree" do
    input = 1..1 |> Enum.to_list
    expected = {nil, 1, nil}
    assert Balancedtree.balancedtree(input) == expected
  end
  test "two node balanced tree" do
    input = 1..2 |> Enum.to_list
    expected = {{nil, 1, nil}, 2, nil}
    assert Balancedtree.balancedtree(input) == expected
  end
  test "three node balanced tree" do
    input = [1, 2, 3]
    expected = {{nil, 1, nil}, 2, {nil, 3, nil}}
    assert Balancedtree.balancedtree(input) == expected
  end
  test "Four node balanced tree" do
    input = [1, 2, 3, 4]
    expected = {{{nil, 1, nil}, 2, nil}, 3, {nil, 4, nil}}
    assert Balancedtree.balancedtree(input) == expected
  end
  test "Five node balanced tree" do
    input = 1..5 |> Enum.to_list
    expected = {{{nil, 1, nil}, 2, nil}, 3, {{nil, 4, nil}, 5, nil}}
    assert Balancedtree.balancedtree(input) == expected
  end
  test "six node balanced tree" do
    input = 1..6 |> Enum.to_list
    expected = {{{nil, 1, nil}, 2, {nil, 3, nil}}, 4, {{nil, 5, nil}, 6, nil}}
    assert Balancedtree.balancedtree(input) == expected
  end
  test "Seven node balanced tree" do
    input = 1..7 |> Enum.to_list
    expected = {{{nil, 1, nil}, 2, {nil, 3, nil}}, 4, {{nil, 5, nil}, 6, {nil, 7, nil}}}
    assert Balancedtree.balancedtree(input) == expected
  end
  test "Eight node balanced tree" do
    input = 1..8 |> Enum.to_list
    expected = {{{{nil, 1, nil}, 2, nil}, 3, {nil, 4, nil}}, 5, {{nil, 6, nil}, 7, {nil, 8, nil}}}
    assert Balancedtree.balancedtree(input) == expected
  end
end
