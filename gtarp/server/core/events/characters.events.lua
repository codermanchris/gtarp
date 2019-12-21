RegisterServerEvent('gtarp:CharacterCreate')
AddEventHandler('gtarp:CharacterCreate', function(playerId, characterData)
	if (not Core.IsValidPlayer(source, playerId)) then
		return
    end
    Characters.RequestCreate(playerId, characterData)
end)

RegisterServerEvent('gtarp:CharacterSetCoords')
AddEventHandler('gtarp:CharacterSetCoords', function(playerId, x, y, z)
	if (not Core.IsValidPlayer(source, playerId)) then
		return
	end
    Characters.SetCoords(playerId, { x = x, y = y, z = z })
end)

RegisterServerEvent('gtarp:CharacterCreator')
AddEventHandler('gtarp:CharacterCreator', function(playerId)
	if (not Core.IsValidPlayer(source, playerId)) then
		return
	end
	Characters.Creator(playerId)
end)

RegisterServerEvent('gtarp:CharacterSelect')
AddEventHandler('gtarp:CharacterSelect', function(playerId, characterId, spawnId)
	if (not Core.IsValidPlayer(source, playerId)) then
		return
	end
	Characters.Select(playerId, characterId, spawnId)
end)

RegisterServerEvent('gtarp:CharacterWeaponsCheck')
AddEventHandler('gtarp:CharacterWeaponsCheck', function(playerId, officerId)
	if (not GTARP.IsPlayerIdValid(source, playerId)) then
		return
	end
	Characters.WeaponCheck(playerId, officerId)
end)