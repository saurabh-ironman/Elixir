defmodule SumoddlengthsubarraysTest do
  use ExUnit.Case
  doctest Sumoddlengthsubarrays

  test "Sumoddlengthsubarrays 1" do
    input = []
    expected = 0
    assert Sumoddlengthsubarrays.sum_sub_array(input) == expected
  end

  test "Sumoddlengthsubarrays 2" do
    input = [1]
    expected = 1
    assert Sumoddlengthsubarrays.sum_sub_array(input) == expected
  end

  test "Sumoddlengthsubarrays 3" do
    input = [5]
    expected = 5
    assert Sumoddlengthsubarrays.sum_sub_array(input) == expected
  end

  test "Sumoddlengthsubarrays 4" do
    input = [1, 2]
    expected = 3
    assert Sumoddlengthsubarrays.sum_sub_array(input) == expected
  end

  test "Sumoddlengthsubarrays 5" do
    input = [10, 11, 12]
    expected = 66
    assert Sumoddlengthsubarrays.sum_sub_array(input) == expected
  end

  test "Sumoddlengthsubarrays 6" do
    input = [1, 4, 2, 5, 3]
    expected = 58
    assert Sumoddlengthsubarrays.sum_sub_array(input) == expected
  end

  test "Sumoddlengthsubarrays 7" do
    input = [6, 9, 14, 5, 3, 8, 7, 12, 13, 1]
    expected = 878
    assert Sumoddlengthsubarrays.sum_sub_array(input) == expected
  end
end
