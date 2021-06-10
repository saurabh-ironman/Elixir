defmodule BinaryTree do
  def maxDepth(nil) do
    0
  end
  def maxDepth({left, _value, right}) do
    depth_left = maxDepth(left)
    depth_right = maxDepth(right)
    max(depth_left, depth_right) + 1
  end
  defp _depth_iter(nodes, count \\ 0)
    defp _depth_iter([], count) do
      count
    end
    defp _depth_iter(nodes, count) do
      subtrees = nodes
      |> Enum.flat_map(
        fn tree ->
          case tree do
            {nil, _, nil}    -> []
            {nil, _, right}  -> [right]
            {left, _, nil}   -> [left]
            {left, _, right} -> [left, right]
          end
        end
      )
      _depth_iter(subtrees, count+1)
    end
    def depth_via_iteration(tree) do
      if tree == nil do
        _depth_iter([])
      else
        _depth_iter([tree])
      end
    end
end


t1 = {nil, 3, nil}

t1
|> BinaryTree.maxDepth
|> IO.puts

t1
|> BinaryTree.depth_via_iteration
|> IO.puts

t2 = {{nil, 9, nil}, 3, {{nil, 15, nil},20, {nil, 7, nil}}}

t2
|> BinaryTree.maxDepth
|> IO.puts

t2
|> BinaryTree.depth_via_iteration
|> IO.puts
