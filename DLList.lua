--[[
	Doubly linked list structure
	-John Nguyen
	3.1.19
	
	THIS MODULE IS STANDALONE, HOWEVER IF THE DATATYPE IS NOT PRIMITIVE, 
		IT MUST IMPLEMENT A COMPARATOR INTERFACE ( function CompareTo(self, data) )
	
	See DLListTest for usage examples
]]--

local DLList = {}
local DLNode = require(script.DLNode)

-- constructor, optional tuple argument(s) for initial elements
function DLList.new(...)
	local initial = {...}
	local list = {}
	
	list.head = DLNode.new()
	list.tail = DLNode.new()
	list.head.next = list.tail
	list.tail.prev = list.head
	list.size = 0
	
	-- modifies size
	function list:ModSize(incr)
		self.size = self.size + incr
	end
	
	-- inserts an element between two nodes
	function list:InsertBetween(data, p, n)
		local new_node = DLNode.new(data)
		
		new_node.prev = p
		new_node.next = n
		
		p.next = new_node
		n.prev = new_node
		
		self:ModSize(1)
	end
	
	-- inserts before the specified index, must be > 0 and less than size
	function list:InsertBefore(data, index)
		assert(index <= self.size and index > 0, "Index out of bounds: " .. index)
		local p = self.head

		for i = 1, index do
			p = p.next
		end
		
		self:InsertBetween(data, p.prev, p)	
	end
	
	-- places new element at the beginning
	function list:Prepend(data)
		self:InsertBetween(data, self.head, self.head.next)
	end	
	
	-- places new element at the end
	function list:Append(data)
		self:InsertBetween(data, self.tail.prev, self.tail)
	end
	
	-- disconnects references to a specific node, returns removed data
	function list:DisconnectNode(node)
		assert(self.size > 0, "Underflow exception")
		node.prev.next = node.next
		node.next.prev = node.prev
		self:ModSize(-1)
		
		return node:GetData()
	end
	
	-- removes from front, returns removed data
	function list:PopFront()
		return self:DisconnectNode(self.head.next)
	end
	
	-- removes from back, returns removed data
	function list:PopBack()
		return self:DisconnectNode(self.tail.prev)
	end
	
	-- remotes from specified index, returns removed data
	function list:RemoveAt(index)
		assert(index <= self.size and index > 0, "Index out of bounds: " .. index)
		local p = self.head

		for i = 1, index do
			p = p.next
		end
		
		return self:DisconnectNode(p)
	end
	
	-- iterates through the list to find the element, returns removed data if any
	function list:Remove(data)
		assert(self.size > 0, "Underflow exception")
		local cur_node = self.head.next
		local comparator

		if typeof(cur_node:GetData()) == "table" then
			comparator = function(a, b) return a:CompareTo(b) == 0 end	
		else
			comparator = function(a, b) return a == b end	
		end
		
		while cur_node ~= self.tail and not comparator(cur_node:GetData(), data) do
			cur_node = cur_node.next
		end
		
		if comparator(cur_node:GetData(), data) then
			return self:DisconnectNode(cur_node)
		end
	end
	
	-- clears list by setting size to 0, reseting links and letting GC handle the rest
	function list:Clear()
		self.head.next = self.tail
		self.tail.prev = self.head
		self.size = 0
	end
	
	-- prints the list
	function list:Print()
		local cur_node = self.head.next

		print("List:")
		while cur_node ~= self.tail do
			local data = cur_node:GetData()
			if typeof(data) == "table" then
				print(" ", data:ToString())
			else
				print(" ", data)
			end
			
			cur_node = cur_node.next
		end
		print(self.size, "nodes")
	end
	
	-- if given initial values, places them in the list
	for _, data in pairs(initial) do
		list:Prepend(data)
	end
	
	return list
end

return DLList