defmodule InsertionsortTest do
  use ExUnit.Case
  doctest Insertionsort

  test "insertion sort test 1" do
    assert Insertionsort.sort([]) == []
  end

  test "insertion sort test 2" do
    assert Insertionsort.sort([3, 2, 1, 4, 8]) == [1, 2, 3, 4, 8]
  end

  test "insertion sort test 3" do
    assert Insertionsort.sort([-3, 2, 1, 4, -8]) == [-8, -3, 1, 2, 4]
  end
end
