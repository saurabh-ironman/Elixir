defmodule PowerofthreeTest do
  use ExUnit.Case
  doctest Powerofthree

  test "power of three test 1" do
    assert Powerofthree.powerofthree(0) == false
  end

  test "power of three test 2" do
    assert Powerofthree.powerofthree(27) == true
  end

  test "power of three test 3" do
    assert Powerofthree.powerofthree(45) == false
  end
end
