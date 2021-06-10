defmodule BinaryTree do
  def _symmetric_iter(nil) do
    true
  end
  def _symmetric_iter({nil, _value, nil}) do
    true
  end
  def _symmetric_iter({_left, _value, nil}) do
    false
  end
  def _symmetric_iter({nil, _value, _right}) do
    false
  end
  def _symmetric_iter({left, _value, right}) do
      _symmetric_iter(left)
      _symmetric_iter(right)
  end
  def symmetric_via_iteration(tree) do
    if tree == nil do
      true
    else
      _symmetric_iter(tree)
    end
  end
end

t1 = {nil, 3, nil}

t1
|> BinaryTree.symmetric_via_iteration
|> IO.puts

t1_1 = {nil, 3, {nil, 4, nil}}

t1_1
|> BinaryTree.symmetric_via_iteration
|> IO.puts

# t2 = {{nil, 9, nil}, 3, {{nil, 15, nil},20, {nil, 7, nil}}}
#
# t2
# |> BinaryTree.symmetric_via_iteration
# |> IO.puts
#
# t3 = {{nil, 2, nil}, 3, {nil, 2, nil}}
#
# t3
# |> BinaryTree.symmetric_via_iteration
# |> IO.puts
