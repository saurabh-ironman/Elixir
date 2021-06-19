defmodule Powerofthree do
  @moduledoc """
  Documentation for `Powerofthree`.
  """
  def powerofthree(number)
  when number == 0
  do
    false
  end

  def powerofthree(number)
  when number == 1
  do
    true
  end
  def powerofthree(number)
  when rem(number, 3) != 0
  do
    false
  end
  def powerofthree(number) do
    number = div(number, 3)
    powerofthree(number)
  end
end
