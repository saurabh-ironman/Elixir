defmodule MergesortTest do
  use ExUnit.Case
  doctest Mergesort

  test "merge sort test 1" do
    input = [30, 10, 21, 3, 2, 1]
    expected = [1, 2, 3, 10, 21, 30]
    assert Mergesort.sort(input) == expected
  end

  test "merge sort test 2" do
    input = [1, 2, 3, 4, 5]
    expected = [1, 2, 3, 4, 5]
    assert Mergesort.sort(input) == expected
  end

  test "merge sort test 3" do
    input = [11, 2, 5, 9, 12, 1]
    expected = [1, 2, 5, 9, 11, 12]
    assert Mergesort.sort(input) == expected
  end

  test "merge sort test 4" do
    input = [-30, -10, -21, -3, 2, 1]
    expected = [-30, -21, -10, -3, 1, 2]
    assert Mergesort.sort(input) == expected
  end

  test "merge sort test 5" do
    input = [-30, -3, 2, 1, -10, -21]
    expected = [-30, -21, -10, -3, 1, 2]
    assert Mergesort.sort(input) == expected
  end
end
