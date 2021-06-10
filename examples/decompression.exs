#defmodule Example do
#    def decompressRLElist(nums) do
#        res1 = []

        #|> if 2 > length (nums) > 100:
        #    |> return res1
        #|> if len(nums) % 2 != 0:
        #    |> return res1
        #pairs = [nums[i:i+2] for i in range(0, length (nums), 2)]
        #for each_pair in pairs:
        #    res1 =  res1 + [each_pair[1] for i in range(each_pair[0])]
        #return res1
	#end
#end

defmodule Example do
    def decompressRLElist(nums) do
		nums
		|> Enum.chunk_every(2)
		|> Enum.flat_map(fn [freq, ele | []] -> List.duplicate(ele, freq) end)
	end
end

System.argv
|> Enum.map(&String.to_integer/1)
|> Example.decompressRLElist
|> inspect
|> IO.puts
