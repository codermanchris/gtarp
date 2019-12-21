-- when network is ready, we need to request account info from the server
Citizen.CreateThread(function()	
	while true do
        Citizen.Wait(0)

		-- break this loop asap
		if (NetworkIsSessionStarted()) then
            Core.CanGetAccountData = true
            
            -- Start Core thread when ready
            Threads.Start(Core)
			return
		end	
	end
end)

-- Start Core thread
Threads.Start(Core)

-- Core Class Functions
function Core.Initialize()
    Core.PlayerId = GetPlayerServerId(PlayerId())    
end

function Core.Tick()    
    -- handle core stuffs
    Core.ClearGtaGameEntities()

    -- if our ped exists handle some bidness
    if (DoesEntityExist(LocalPlayer.Ped) and LocalPlayer.HasCharacter) then
        Core.SendCoordsToServer(LocalPlayer.Coords, LocalPlayer.Heading)
        WorldItem.Render()
    end
end

function Core.Event(event, ...)
    TriggerServerEvent(event, Core.PlayerId, ...)
end

-- todo - move this to local player probably
function Core.SendCoordsToServer(coords, heading)
    if (coords == nil or heading == nil or LocalPlayer.IsNoClipping or Core.NextCoordsUpdateAt == nil) then
		return
    end
    
    if (Core.NextCoordsUpdateAt < GetGameTimer()) then
        Core.NextCoordsUpdateAt = GetGameTimer() + 1000

        if (coords ~= Core.LastCoordsSent) then
            Core.Event('gtarp:CharacterSetCoords', coords.x, coords.y, coords.z)                
            LocalPlayer.Coords = coords
            Core.LastCoordsSent = coords
        end
	end
end

function Core.ClearGtaGameEntities()
	if (GetPlayerWantedLevel(PlayerId()) ~= 0) then
		SetPlayerWantedLevel(PlayerId(), 0, false)
		SetPlayerWantedLevelNow(PlayerId(), false)
		SetDispatchCopsForPlayer(PlayerId(), false)
	end
	
    DisablePlayerVehicleRewards(PlayerId())
    
	if (LocalPlayer.Coords ~= nil) then
		ClearAreaOfCops(LocalPlayer.Coords.x, LocalPlayer.Coords.y, LocalPlayer.Coords.z, 1000.0)
	end

    if (not Core.HasPurgeStarted) then
        --SetBlackout(false)
        SetVehicleDensityMultiplierThisFrame(0.2)
        SetPedDensityMultiplierThisFrame(0.5)
        SetRandomVehicleDensityMultiplierThisFrame(0.2)
        SetParkedVehicleDensityMultiplierThisFrame(0.1)
    else
        --SetBlackout(true)
        SetVehicleDensityMultiplierThisFrame(0.1)
        SetPedDensityMultiplierThisFrame(0.1)
        SetRandomVehicleDensityMultiplierThisFrame(0.05)
        SetParkedVehicleDensityMultiplierThisFrame(0.05)
    end

    --[[
        DT_PoliceAutomobile = 1,
        DT_PoliceHelicopter = 2,
        DT_FireDepartment = 3,
        DT_SwatAutomobile = 4,
        DT_AmbulanceDepartment = 5,
        DT_PoliceRiders = 6,
        DT_PoliceVehicleRequest = 7,
        DT_PoliceRoadBlock = 8,
        DT_PoliceAutomobileWaitPulledOver = 9,
        DT_PoliceAutomobileWaitCruising = 10,
        DT_Gangs = 11,
        DT_SwatHelicopter = 12,
        DT_PoliceBoat = 13,
        DT_ArmyVehicle = 14,
        DT_BikerBackup = 15
    ]]

    EnableDispatchService(1, false)
    EnableDispatchService(2, false)
    EnableDispatchService(3, false)
    EnableDispatchService(4, false)
    EnableDispatchService(5, false)
    EnableDispatchService(6, false)
    EnableDispatchService(7, false)
    EnableDispatchService(8, false)
    EnableDispatchService(9, false)
    EnableDispatchService(10, false)
    EnableDispatchService(12, false)
    EnableDispatchService(13, false)
    EnableDispatchService(15, false) 
end

function Core.GetDirection(degrees)
	degrees = degrees % 360.0
	
	if ((degrees >= 0.0 and degrees < 22.5) or degrees >= 337.5) then
		return " N"
	elseif (degrees >= 22.5 and degrees < 67.5) then
		return "NW"
	elseif (degrees >= 67.5 and degrees < 112.5) then
		return " W"
	elseif (degrees >= 112.5 and degrees < 157.5) then
		return "SW"
	elseif (degrees >= 157.5 and degrees < 202.5) then
		return " S"
	elseif (degrees >= 202.5 and degrees < 247.5) then
		return "SE"
	elseif (degrees >= 247.5 and degrees < 292.5) then
		return " E"
	elseif (degrees >= 292.5 and degrees < 337.5) then
		return "NE"
	end
end

function Core.DrawText(coords, dimensions, color, text)
    SetTextFont(4)
    SetTextProportional(0)
    SetTextScale(dimensions.scale, dimensions.scale)
    SetTextColour(color.r, color.g, color.b, color.a)
    SetTextDropShadow(0, 0, 0, 0, 255)
    SetTextEdge(2, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(coords.x - dimensions.width / 2, coords.y - dimensions.height / 2 + 0.005)
end

function Core.Draw3dText(text, coords, color)
	local x,y,z = World3dToScreen2d(coords.x, coords.y, coords.z)					
				
	SetTextFont(9)
	SetTextScale(0.0, 0.30)
	SetTextColour(color.r, color.g, color.b, color.a)
	SetTextDropShadow(5, 0, 78, 255, 255)
	SetTextEdge(0, 0, 0, 0, 0)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(y, z)
end

function Core.GetDistance(coords1, coords2)
	return Vdist(coords1.x, coords1.y, coords1.z, coords2.x, coords2.y, coords2.z)
end

function Core.Raycast(startCoords, endCoords, distance)
	local handle = CastRayPointToPoint(startCoords.x, startCoords.y, startCoords.z, endCoords.x, endCoords.y, endCoords.z, distance, LocalPlayer.Ped, 0)
	local a, b, c, d, entity = GetRaycastResult(handle)
	return entity
end

function Core.PedRaycast(startCoords, endCoords, distance)
	local handle = CastRayPointToPoint(startCoords.x, startCoords.y, startCoords.z, endCoords.x, endCoords.y, endCoords.z, distance, LocalPlayer.Ped, 4)
	local a, b, c, d, entity = GetRaycastResult(handle)
	return entity
end

function Core.RotationToVector(rotation)
    local x = math.rad(rotation.x)
	local z = math.rad(rotation.z)
	local num = math.abs(math.cos(x))
	return vector3(-math.sin(z)*num, math.cos(z)*num, math.sin(x))
end