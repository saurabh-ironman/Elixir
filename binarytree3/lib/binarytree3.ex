defmodule Binarytree3 do
  @moduledoc """
  Documentation for `Binarytree3`.
  """

  def make_node(value) do
    {nil, value, nil}
  end

  def insert(new_value, nil) do
    make_node(new_value)
  end

  def insert(new_value, {left, value, right})
  when new_value < value
  do
    {insert(new_value, left), value, right}
  end

  def insert(new_value, {left, value, right})
  when new_value > value
  do
    {left, value, insert(new_value, right)}
  end

  def in?(nil, _new_val) do
    false
  end

  def in?({left, value, right}, new_val) do
    cond do
      new_val < value -> in?(left, new_val)
      new_val > value -> in?(right, new_val)
      new_val == value -> true
    end
  end

  def buildTree([root | values]) do
    values
    |> Enum.reduce(make_node(root), &insert/2)
  end
end
