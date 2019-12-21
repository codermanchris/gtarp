-- Player is connecting to the server
AddEventHandler('playerConnecting', function(steamName, callback)
	-- validate steam id and make sure server is allowed to let them connect
	local steamId = GetPlayerIdentifiers(source)[1]
	if (steamId == nil or not Core.IsAllowingConnections) then
		callback('The server is initializing. Please try again soon.')
		CancelEvent()
		return
	end
			
    -- if this account can't connect, let the player know
    local success, error = Accounts.CanConnect(source, steamName)
	if (not success) then
		print(string.format('> Connection rejected %s (%s) for %s', steamName, steamId, reason))
		callback(error)
		CancelEvent()
		return
	end
end)

-- Player has disconnected from the server
AddEventHandler('playerDropped', function()
	-- validate account
	local account = Core.GetAccount(source)
	if (account == nil) then
		return	
	end

	print(string.format('> Connection dropped %s (%s)', account.SteamName, account.SteamId))

    -- character manager will notify all scripts that this player has dropped
	Characters.OnDropped(source)

    -- clean up account
	Core.RemoveAccount(source)
end)

