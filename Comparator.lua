--[[
	Simple comparator function used for object comparison,
		a more specialized function is necessary for more complex objects
	-John Nguyen
	3.1.19
	
	returns 1 if self larger, -1 if self smaller, 0 if equal
]]--

return function(self, b)
	return (self.data == b and 0) or (self.data > b and 1) or (self.data < b and -1)
end