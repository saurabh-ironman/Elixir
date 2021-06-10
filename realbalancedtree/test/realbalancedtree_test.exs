defmodule RealbalancedtreeTest do
  use ExUnit.Case
  doctest Realbalancedtree

  test "three node combination 1" do
    input = [1, 2, 3]
    expected = {{nil, 1, nil}, 2, {nil, 3, nil}}
    assert Realbalancedtree.realbalancedtree(input) == expected
  end
  test "three node combination 2" do
    input = [1, 3, 2]
    expected = {{nil, 1, nil}, 2, {nil, 3, nil}}
    assert Realbalancedtree.realbalancedtree(input) == expected
  end
  test "three node combination 3" do
    input = [2, 1, 3]
    expected = {{nil, 1, nil}, 2, {nil, 3, nil}}
    assert Realbalancedtree.realbalancedtree(input) == expected
  end
  test "three node combination 4" do
    input = [2, 3, 1]
    expected = {{nil, 1, nil}, 2, {nil, 3, nil}}
    assert Realbalancedtree.realbalancedtree(input) == expected
  end
  test "three node combination 5" do
    input = [3, 2, 1]
    expected = {{nil, 1, nil}, 2, {nil, 3, nil}}
    assert Realbalancedtree.realbalancedtree(input) == expected
  end
  test "three node combination 6" do
    input = [3, 1, 2]
    expected = {{nil, 1, nil}, 2, {nil, 3, nil}}
    assert Realbalancedtree.realbalancedtree(input) == expected
  end
  test "three node combination 7" do
    input = [1, 5, 10]
    expected = {{nil, 1, nil}, 5, {nil, 10, nil}}
    assert Realbalancedtree.realbalancedtree(input) == expected
  end
  test "three node combination 8" do
    input = [20, 5, 10]
    expected = {{nil, 5, nil}, 10, {nil, 20, nil}}
    assert Realbalancedtree.realbalancedtree(input) == expected
  end
end
