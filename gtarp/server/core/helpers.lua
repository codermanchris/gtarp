function Helpers.StringStartsWith(value)
    return string.sub(value, 1, string.len(value)) == value
end

function string:split()
	local args = {}
	self:gsub(string.format('([^%s]+)', ' '), function(result) args[#args+1] = result end)
	return args
end