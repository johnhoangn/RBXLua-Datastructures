local list = require(script.Parent.DLList).new()

-- insertion tests
if false then
	for i = 1, 10 do
		list:Append(i)
	end
	for i = 1, 10 do
		list:Prepend(i)
	end
	list:InsertBefore(99, 11)
	list:Print()
end

-- removal tests
if false then
	-- integers
	for i = 1, 5 do
		list:Append(i)
	end
	list:Remove(3)
	print(list:PopFront())
	print(list:PopBack())
	list:Print()
	
	list:Clear()
	
	-- integer wrapper objects
	for i = 6, 10 do
		list:Append({CompareTo = require(script.Parent.Comparator:Clone()), data = i, ToString = function(self) return tostring(self.data) end})
	end
	list:Remove(7)
	list:Print()
	
	list:Clear()
	
	-- underflow check
	local s, e = pcall(list.Remove, list, 0)
	assert(not s)
	print(e)
end