RegisterNetEvent('gtarp:SetAccountData')
AddEventHandler('gtarp:SetAccountData', function(permissionLevel, cityAccess, characters)

    LocalPlayer.SetAccountData(permissionLevel, cityAccess, characters)
end)

RegisterNetEvent('gtarp:CharacterDamage')
AddEventHandler('gtarp:CharacterDamage', function(damage)
    LocalPlayer.CauseDamage(damage)
end)

RegisterNetEvent('gtarp:CharacterInitialize')
AddEventHandler('gtarp:CharacterInitialize', function(characterInfo, skinProfile, inventory, weapons, food, thirst)    
    LocalPlayer.SelectCharacter(characterInfo, skinProfile, inventory, weapons, food, thirst)
end)

RegisterNetEvent('gtarp:CharacterSetSkin')
AddEventHandler('gtarp:CharacterSetSkin', function(modelName, skinProfile)
	LocalPlayer.SetSkin(modelName, skinProfile)
end)

RegisterNetEvent('gtarp:CharacterSetVehicles')
AddEventHandler('gtarp:CharacterSetVehicles', function(vehicles)
    LocalPlayer.Vehicles = vehicles
end)

RegisterNetEvent('gtarp:CharacterTeleport')
AddEventHandler('gtarp:CharacterTeleport', function(x, y, z)
    LocalPlayer.Teleport(x, y, z)
end)

RegisterNetEvent('gtarp:CharacterRevive')
AddEventHandler('gtarp:CharacterRevive', function()
    LocalPlayer.Revive()
end)

RegisterNetEvent('gtarp:Bandage')
AddEventHandler('gtarp:Bandage', function()
    LocalPlayer.Bandage()
end)

RegisterNetEvent('gtarp:CharacterCuff')
AddEventHandler('gtarp:CharacterCuff', function(playerId, isCuffed)
    LocalPlayer.Cuff(playerId, isCuffed)
end)

RegisterNetEvent('gtarp:CharacterUncuff')
AddEventHandler('gtarp:CharacterUncuff', function(playerId)
	LocalPlayer.Uncuff(playerId)
end)

RegisterNetEvent('gtarp:CharacterFreeze')
AddEventHandler('gtarp:CharacterFreeze', function(value, forceInvis)
	LocalPlayer.Freeze(PlayerId(), value, forceInvis)
end)

RegisterNetEvent('gtarp:CharacterGiveWeapon')
AddEventHandler('gtarp:CharacterGiveWeapon', function(weaponName)
	LocalPlayer.GiveWeapon(weaponName)
end)

RegisterNetEvent('gtarp:CharacterGiveWeapons')
AddEventHandler('gtarp:CharacterGiveWeapons', function(weapons)
	LocalPlayer.GiveWeapons(weapons)
end)

RegisterNetEvent('gtarp:CharacterDragStart')
AddEventHandler('gtarp:CharacterDragStart', function(playerId)
	LocalPlayer.DragStart(playerId)
end)

RegisterNetEvent('gtarp:CharacterDragStop')
AddEventHandler('gtarp:CharacterDragStop', function()
	LocalPlayer.DragStop()
end)

RegisterNetEvent('gtarp:CharacterDied')
AddEventHandler('gtarp:CharacterDied', function(playerId)
	LocalPlayer.Died(playerId)
end)

RegisterNetEvent('gtarp:CharacterEmote')
AddEventHandler('gtarp:CharacterEmote', function(emote)
	LocalPlayer.Emote(emote)
end)

RegisterNetEvent('gtarp:CharacterUseItem')
AddEventHandler('gtarp:CharacterUseItem', function(itemName, shouldReset)
	LocalPlayer.UseItem(itemName, 1)
end)

RegisterNetEvent('gtarp:CharacterPutInVehicle')
AddEventHandler('gtarp:CharacterPutInVehicle', function (playerId, isDead, seat)
	LocalPlayer.ForcePlayerInVehicle(playerId, isDead, seat)
end)

RegisterNetEvent('gtarp:CharacterTakeOutVehicle')
AddEventHandler('gtarp:CharacterTakeOutVehicle', function()
	LocalPlayer.ForcePlayerOutVehicle()
end)

RegisterNetEvent('gtarp:CharacterSlay')
AddEventHandler('gtarp:CharacterSlay', function()
    LocalPlayer.Slay()
end)