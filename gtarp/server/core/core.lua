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

function Core.GetCharacter(playerId)
    local account = Core.GetAccount(playerId)
    if (account == nil) then
        return nil
    end

    return account:GetCharacter()
end

function Core.AddAccount(playerId, account)

end

function Core.ProcessDiscordCommands()
    
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