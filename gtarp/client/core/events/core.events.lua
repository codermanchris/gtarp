-- 5m Events
AddEventHandler('onClientMapStart', function()	
    exports.spawnmanager:setAutoSpawn(false)
    Core.Event('gtarp:PlayerLoadedMap')

    -- toko is preferred so this will be set to 0
	NetworkSetTalkerProximity(0.0)
end)

AddEventHandler('playerSpawned', function()
    LocalPlayer.OnPlayerSpawned()
end)

-- Net Events
RegisterNetEvent('gtarp:SpawnPlayer')
AddEventHandler('gtarp:SpawnPlayer', function(coords, modelName)
	exports.spawnmanager:spawnPlayer({ x = coords.x, y = coords.y, z = coords.z, model = modelName })
end)

RegisterNetEvent('gtarp:CharacterSetList')
AddEventHandler('gtarp:CharacterSetList', function(characters)
    UI.SetCharacterList(characters)
end)