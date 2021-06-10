defmodule BinaryTree do
  def rangeSumBST(nil, _low, _high) do
    0
  end
  def rangeSumBST({left, value, right}, low, high) do
    sum = 0
    if low <= value and value <= high do
      sum + value
    else
      sum = sum + rangeSumBST(left, low, high)
      sum + rangeSumBST(right, low, high)
    end
  end

  def rangeSumBST_iter([], _low, _high, sum) do
    sum
  end
  def rangeSumBST_iter(nodes, low, high, sum) do
    subnodes = nodes |> Enum.flat_map(fn {left, _, right} -> [left, right] end) |> Enum.filter(&(&1 != nil))
    new_sum = sum + (nodes |> Enum.map(fn {_, val, _} -> val end) |> Enum.filter(&(low <= &1 and &1 <= high))  |> Enum.sum)

    rangeSumBST_iter(subnodes, low, high, new_sum)
  end


  def rangeSumBST_iter2([], _low, _high, sum) do
    sum
  end
  def rangeSumBST_iter2(nodes, low, high, sum) do
    node_to_list = fn {left, _, right} -> [left, right] end
    not_nil = &(&1 != nil)
    node_value = fn {_, val, _} -> val end
    in_range = &(low <= &1 and &1 <= high)

    subnodes = nodes |> Enum.flat_map(node_to_list) |> Enum.filter(not_nil)
    new_sum = sum + (nodes |> Enum.map(node_value) |> Enum.filter(in_range) |> Enum.sum)

    rangeSumBST_iter2(subnodes, low, high, new_sum)
  end
end


t1 = {nil, 3, nil}

[t1]
|> BinaryTree.rangeSumBST_iter2(1, 5, 0)
|> IO.puts

t2 = {{nil, 9, nil}, 3, {nil, 15, nil}}

[t2]
|> BinaryTree.rangeSumBST_iter2(7, 15, 0)
|> IO.puts

t3 = {{nil, 9, {nil, 7, nil}}, 3, {nil, 15, nil}}

[t3]
|> BinaryTree.rangeSumBST_iter2(7, 15, 0)
|> IO.puts
