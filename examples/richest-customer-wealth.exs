defmodule Example do
    def maximumWealth(nums) do
		nums
		|> Enum.map(fn x -> Enum.sum(x) end)
    |> Enum.max
	end
end

to_integer = &String.to_integer/1
System.argv
|> Enum.map(&String.split/1)
|> Enum.map(&Enum.map(&1, to_integer))
|> Example.maximumWealth
|> inspect
|> IO.puts
