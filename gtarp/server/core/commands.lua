-- Register a slash command
function Commands:Register(command, permissionLevel, cityAccess, callback)
    -- if this command already exists, bow out
    if (self[command] ~= nil) then
        return false
    end

    -- add this command
    self[command] = {
        Execute = callback,
        PermissionLevel = permissionLevel,
        CityAccess = cityAccess
    }

    return true
end

-- Execute a registered slash command
function Commands:Execute(playerId, command, args)
    command = string.lower(command)

    -- validate command
    if (self[command] == nil) then
        return false, "Invalid command."
    end

    -- validate account permissions
    local account = Core.GetAccount(playerId)
    if (account == nil or account:GetCharacter() == nil or account.PermissionLevel < self[command].PermissionLevel) then
        return false, "You do not have permission."
    end

    -- write the log
    Logs.Write(account.Id, account:GetCharacter().Id, account.PermissionLevel, command .. ': ' .. table.concat(args, ' '))

    -- execute and return status
    return self[command].Execute(playerId, args), nil
end

-- Chat message handler
AddEventHandler("chatMessage", function(playerId, name, message)
	if (not Core.IsPlayerValid(source, playerId)) then
		return
	end
	
	if (string.len(message) == 0) then
		CancelEvent()
		return
	end
	
	if (string.len(message) > 1 and Helpers.StringStartsWith(message, "/")) then
		local args = {}
		
		for str in string.gmatch(message, "%S+") do
			table.insert(args, str)
		end
		
		local command = string.sub(table.remove(args, 1), 2)
		
		local success, error = Commands:Execute(playerId, command, args)
		if (success) then
			print(string.format("Command %s executed by %s.", command, name))
        else
            if (error ~= nil) then
                Core.Respond(playerId, error)
            end
        end

        CancelEvent()
	end
end)