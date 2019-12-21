-- Start thread for this class
Threads.Start(LocalPlayer)

-- LocalPlayer Class Functions
function LocalPlayer.OnPlayerSpawned()
	FreezeEntityPosition(LocalPlayer.Ped, true)
	SetEntityVisible(LocalPlayer.Ped, false)
	
	SetCanAttackFriendly(LocalPlayer.Ped, true, false)
	NetworkSetFriendlyFireOption(true)
end

function LocalPlayer.Initialize()
    DisplayRadar(false)
end

function LocalPlayer.Tick()
    -- set important local player stuffs
    LocalPlayer.Ped = PlayerPedId()
    LocalPlayer.Coords = GetEntityCoords(LocalPlayer.Ped, false)    
    LocalPlayer.Heading = GetEntityHeading(LocalPlayer.Ped)
end

function LocalPlayer.HandleAdmin()
    if (LocalPlayer.IsNoClipping) then
        LocalPlayer.HandleNoClip()
        return true
    end

    if (LocalPlayer.IsSpectating) then
		LocalPlayer.HandleIds()
		LocalPlayer.HandleSpectate()
		return true
    end
    
    return false
end

function LocalPlayer.SetAccountData(permissionLevel, cityAccess, characters)
    LocalPlayer.PermissionLevel = permissionLevel
    LocalPlayer.CityAccess = cityAccess
    
    UI.Message({ screen = nil, method = 'onSetAccountData', permissionLevel = permissionLevel, cityAccess = cityAccess, characters = characters })
    UI.NextStatsCheckAt = GetGameTimer() + 1000
    
    SetNuiFocus(true, true)
end

function LocalPlayer.SelectCharacter(characterInfo, skinProfile, inventory, weapons, food, thirst)
	UI.CloseMenu()
	
	FreezeEntityPosition(LocalPlayer.Ped, false)
	SetEntityVisible(LocalPlayer.Ped, true)
end

function LocalPlayer.CauseDamage(damage)
	local healthCurrent = GetEntityHealth(LocalPlayer.Ped)
	local health = healthCurrent - damage

	SetEntityHealth(LocalPlayer.Ped, health)    
end

function LocalPlayer.Teleport(x, y, z)
	Citizen.CreateThread(function()		
		DoScreenFadeOut(0)		
		while IsScreenFadingOut() do
			Wait(0)
        end
        
		SetEntityCoords(LocalPlayer.Ped, x, y, z)
		
		Wait(3000)
		DoScreenFadeIn(500)
		while IsScreenFadingIn() do
			Wait(0)
		end
	end)    
end

function LocalPlayer.Slay()
	Citizen.CreateThread(function()
        Citizen.Wait(1000)
        CauseDamage(GetEntityMaxHealth(LocalPlayer.Ped))
	end)
end

function LocalPlayer.Revive()
	if (DoesEntityExist(LocalPlayer.Ped) and IsEntityDead(LocalPlayer.Ped)) then
		NetworkResurrectLocalPlayer(LocalPlayer.Coords.x, LocalPlayer.Coords.y, LocalPlayer.Coords.z, 0, true, true, false)
		
		LocalPlayer.Respawn()
		LocalPlayer.ResetSkin()
	end    
end

function LocalPlayer.Bandage()
    if (LocalPlayer.Heal(50)) then
        Chat.Log('^2Bandages have been applied to you.')
	end    
end

function LocalPlayer.Heal(value)
    if (value < 0 or value > 50) then
        return false
    end

    local maxHealth = GetEntityMaxHealth(LocalPlayer.Ped)
    local health = GetEntityHealth(LocalPlayer.Ped) + value
    if (health > maxHealth) then
        health = maxHealth
    end

    SetEntityHealth(LocalPlayer.Ped, health)
    return true
end