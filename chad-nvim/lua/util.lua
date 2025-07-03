M = {}

local function hasKey(array, key)
	for _, obj in ipairs(array) do
		-- Check if the current object has the key (even if the value is nil)
		if obj[key] ~= nil then
			return true
		end
	end
	return false
end

M.hasKey = hasKey





return M
