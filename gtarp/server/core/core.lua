
function Core.Initialize()
    Core.WriteSystemLog('GTARP is starting up. Please wait.')
    --Gameplay.LoadDatas()
    --Jobs.LoadDatas()

    Core.SetReady()
end

function Core.SetReady()
    Core.IsBootingUp = false
    Core.IsAllowingConnections = true

    Core.WriteSystemLog('GTARP systems is ready for connections.')    
end

function Core.Event(to, event, ...)
    TriggerClientEvent(event, to, ...)
end

function Core.Respond(playerId, message)
    Core.Event(playerId, 'chatMessage', '', {0,0,0}, message)
end

function Core.RespondAll(message)
    Core.Event(-1, 'chatMessage', '', {0,0,0}, message)
end

function Core.GetAccount(playerId)
    return Core.Accounts[playerId]
end

function Core.AddAccount(playerId, account)
    local account = Core.GetAccount(playerId)
    if (account == nil) then
        return nil
    end

    Core.Accounts[playerId] = account
end

function Core.RemoveAccount(playerId)
    Core.Accounts[playerId] = nil
end

function Core.ProcessDiscordCommands()
    -- todo
    -- read incoming discord commands
end

function Core.IsPlayerValid(source, playerId)
	if (tonumber(source) == nil or source == 65535 or source == -1 or playerId ~= source) then
		return false
	end
	return true	
end

function Core.IsSourceValid(source)
	if (tonumber(source) == nil or source == 65535 or source == -1) then
		return false
	end
	return true	
end

function Core.WriteSystemLog(message)
    print('> SystemLog | ' .. message) 

    -- todo
    -- log to db
end

function Core.WriteLog(accountId, characterId, permissionLevel, message)
    print('> WriteLog # aid: ' .. tostring(accountId) .. ': ' .. tostring(characterId) .. ' p: ' .. permissionLevel .. '> ' .. message) 

    -- todo
    -- log to db    
end