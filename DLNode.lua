--[[
	Linked Node for a Doubly linked list
	-Dynamese
	2.24.19
	
]]--

local DLNode = {}

function DLNode.new(data)
	local node = {
		['prev'] = nil;
		['next'] = nil;
		['data'] = data;
	}
	
	-- probably unnecessary since there are no access modifiers in rbxlua
	function node:GetData()
		return self.data
	end
	
	return node
end

return DLNode