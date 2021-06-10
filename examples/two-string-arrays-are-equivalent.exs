defmodule Example do
    def arrayStringsAreEqual(word1, word2) do
			if Enum.join(word1) == Enum.join(word2) do
				True
			else
				False
			end
	end
end

[input1, input2] = System.argv
list1 = String.split(input1)
list2 = String.split(input2)
{list1, list2}
|> inspect
|> IO.puts
Example.arrayStringsAreEqual(list1, list2)
|> inspect
|> IO.puts
