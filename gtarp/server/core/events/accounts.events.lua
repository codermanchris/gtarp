
-- When the player is finished loading the map, this will be called
RegisterServerEvent('gtarp:PlayerLoadedMap')
AddEventHandler('gtarp:PlayerLoadedMap', function(playerId)
	-- validate player id
	if (not Core.IsPlayerValid(source, playerId)) then
		return
	end

	-- send events to client to make this happen
	Core.Event(playerId, 'gtarp:SpawnPlayer', Core.SpawnPoints[1], Common.Skins.Male[1])
	--Core.Event(playerId, 'gtarp:LoadInteriors')

	-- debug
	print('debug: received player loaded map. ' .. tostring(playerId))
end)

-- After the UI has finished initializing and is ready for data, this will be called
RegisterServerEvent('gtarp:RequestAccount')
AddEventHandler('gtarp:RequestAccount', function(playerId)
	-- validate the playerId and source
	if (not Core.IsPlayerValid(source, playerId)) then
		return
	end
	Accounts.Request(playerId)
end)
