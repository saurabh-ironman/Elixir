defmodule QuicksortTest do
  use ExUnit.Case
  doctest Quicksort

  test "quick sort test 1" do
    nums = 1..10 |> Enum.shuffle
    assert nums |> Quicksort.sort == [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
  end

  test "quick sort test 2" do
    nums = 1..20 |> Enum.shuffle
    assert nums |> Quicksort.sort == [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]
  end
end
