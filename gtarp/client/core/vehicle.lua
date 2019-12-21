-- Start Vehicle thread
Threads.Start(Vehicle)

-- Vehicle Class Functions
function Vehicle.Initialize()
    DecorRegister('fuel', 1)		 -- float
	DecorRegister('owner', 3)  		 -- int
	DecorRegister('hotwired', 3)  	 -- int
	DecorRegister('silentsirens', 3) -- int
    DecorRegister('neonlayout', 3)   -- int
end

function Vehicle.Tick()
    if (LocalPlayer.IsDead) then
        return
    end

    if (not LocalPlayer.InVehicle) then
        Vehicle.HandleOutside()
    else
        Vehicle.HandleInside()
    end

    Vehicle.HandleKeys()
end

function Vehicle.HandleOutside()
    local enteringVehicle = GetVehiclePedIsTryingToEnter(LocalPlayer.Ped)
    local vehicleExists = DoesEntityExist(enteringVehicle)
    
    if (vehicleExists and not LocalPlayer.IsEnteringVehicle) then
        LocalPlayer.IsEnteringVehicle = true
        
        -- do not let the player steal this vehicle
        if (GetVehicleDoorLockStatus(enteringVehicle) == 7) then
            SetVehicleDoorsLocked(enteringVehicle, 2)
        end
        
        local driverPed = GetPedInVehicleSeat(enteringVehicle, -1)
        if (driverPed) then
            SetPedCanBeDraggedOut(driverPed, false)
        end
    elseif (not vehicleExists and not IsPedInAnyVehicle(LocalPlayer.Ped, true) and LocalPlayer.IsEnteringVehicle) then
        LocalPlayer.IsEnteringVehicle = false
    elseif (IsPedInAnyVehicle(LocalPlayer.Ped, false)) then
        Vehicle.Enter()
    end

    -- todo - add stealing vehicles at gunpoint
end

function Vehicle.HandleInside()
    if (LocalPlayer.InVehicle and not IsPedInAnyVehicle(LocalPlayer.Ped, false)) then
        Vehicle.Exit()
    end

    if (not DoesEntityExist(Vehicle.Entity)) then
        return
    end

    Vehicle.Coords = GetEntityCoords(Vehicle.Entity, true)

    Vehicle.ProcessModifiers()
    Vehicle.ProcessSpeedControl()

    Vehicle.HandleFuel()
    Vehicle.HandleDamage()
    Vehicle.HandleShuffle()
    Vehicle.HandleCrash()

    Vehicle.DrawHUD()  
end

function Vehicle.HandleKeys()
    if (LocalPlayer.InVehicle and LocalPlayer.CanDrive) then	
		if (LocalPlayer.IsDriving) then
			if ((Vehicle.HasKeys or Vehicle.IsHotwired == 1) and IsControlJustPressed(0, 246) and GetLastInputMethod(2)) then -- Y: toggle engine				
				if (DoesEntityExist(Vehicle.Entity) and not Vehicle.IsDamaged) then
					
					local isEngineRunning = IsVehicleEngineOn(Vehicle.Entity)
					if (not isEngineRunning) then
						if (Vehicle.Fuel > 1) then
							SetVehicleUndriveable(Vehicle.Entity, false)
							SetVehicleEngineOn(Vehicle.Entity, true, false)
							Vehicle.IsEngineRunning = true
                            Chat.Log('^5You started the engine.')
                            Core.Event('gtarp:VehicleStartEngine', true)
						else
							Core.Event('gtarp:VehicleOutOfFuel')
                            Chat.Log('^5Your vehicle is out of fuel.')
						end		
					else
						SetVehicleUndriveable(Vehicle.Entity, true)
						SetVehicleEngineOn(Vehicle.Entity, false, true)
						Vehicle.IsEngineRunning = false
                        Chat.Log('^5Your vehicles engine has shut off.')
						Core.Event('gtarp:VehicleStartEngine', false)
					end
				end	
		
			end		
		end
	end
	
	-- TOGGLE VEHICLE LOCKS INSIDE OR OUTSIDE OF CAR
	if (IsControlJustPressed(1, 303) and GetLastInputMethod(2)) then -- U: lock/unlock vehicle			
		local vehicle = nil
		
		if (not IsPedInAnyVehicle(LocalPlayer.Ped)) then
			-- get the vehicle we are looking at
			local endCoords = GetOffsetFromEntityInWorldCoords(LocalPlayer.Ped, 0.0, 10.0, -4.0)
			vehicle = Core.Raycast(LocalPlayer.Coords, endCoords, 10)			
		else
			-- get the vehicle we are in
			vehicle = Vehicle.Entity
		end

		-- handle locking/unlocking

		if (vehicle ~= nil and DoesEntityExist(vehicle)) then
			local plateText = GetVehicleNumberPlateText(vehicle)
			
			if (plateText ~= nil and plateText ~= "" and (LocalPlayer.OwnsVehicle(plateText) or LocalPlayer.HasKeys(plateText))) then
				local isLocked = not GetVehicleDoorsLockedForPlayer(vehicle, LocalPlayer.Ped)

				SetVehicleDoorsLockedForAllPlayers(vehicle, isLocked)
				
				-- an annoying horn for when you lock and unlock your car :)
				-- doesnt behave well with police cars.
				if (not Vehicle.IsPoliceVehicle) then
					Citizen.CreateThread(function()
						StartVehicleHorn(vehicle, 25, GetHashKey("HELDDOWN"), 0)

						SetVehicleIndicatorLights(vehicle, 0, true)
						SetVehicleIndicatorLights(vehicle, 1, true)
						Wait(100)
						SetVehicleIndicatorLights(vehicle, 0, false)
						SetVehicleIndicatorLights(vehicle, 1, false)
						if (isLocked) then
							Wait(50)
							StartVehicleHorn(vehicle, 25, GetHashKey("HELDDOWN"), 0)

							SetVehicleIndicatorLights(vehicle, 0, true)
							SetVehicleIndicatorLights(vehicle, 1, true)
							Wait(100)
							SetVehicleIndicatorLights(vehicle, 0, false)
							SetVehicleIndicatorLights(vehicle, 1, false)
						end
					end)
				end

                if (isLocked) then
                    Chat.Log('^5You locked this vehicle.')
                else
                    Chat.Log('^5You unlocked this vehicle.')
				end
            else
                Chat.Log('^5You cannot lock/unlock that vehicle.')
			end
		end
	end
end

function Vehicle.Enter()
    if (LocalPlayer.InVehicle or Vehicle.Entity ~= nil) then
        return
    end

	-- get vehicle and set player info
	Vehicle.Entity = GetVehiclePedIsIn(LocalPlayer.Ped, false)
	Vehicle.Name = GetDisplayNameFromVehicleModel(GetEntityModel(Vehicle.Entity))
	Vehicle.IsMedicalVehicle = false
    Vehicle.IsPoliceVehicle = false

    LocalPlayer.CanDrive = false
    LocalPlayer.InVehicle = true
    LocalPlayer.IsEnteringVehicle = false

	-- figure out if this player has the keys to this vehicle
	local plateText = Core.StringTrim(GetVehicleNumberPlateText(Vehicle.Entity))	
    local isOwner = LocalPlayer.OwnsVehicle(plateText)
    
    -- check if this vehicle is hotwired
    Vehicle.IsHotwired = DecorGetInt(Vehicle.Entity, 'hotwired')

    -- figure out medical/police vehicles
	if (not isOwner) then
        Vehicle.IsMedicalVehicle = Vehicle.Name == 'AMBULAN'
		Vehicle.IsPoliceVehicle = IsPedInAnyPoliceVehicle(LocalPlayer.Ped)
	end

    -- get the seat the ped is in    
    local seat = -1
    for i = -1, 6 do
        if (GetPedInVehicleSeat(Vehicle.Entity, i) == LocalPlayer.Ped) then
            seat = i
            break
        end
    end

	SetVehicleNeedsToBeHotwired(Vehicle.Entity, false)

	-- handle taxi
	--if (not isOwner and Vehicle.Name == 'TAXI' and not TaxiDriver.IsPlayerOnDuty and seat ~= -1) then
	--  TriggerServerEvent('gtarp:TaxiGetIn', playerId, plateText, seat)
	-- end
	
	if (seat == -1) then
        -- if the player doesn't have the keys, nothing else matters, fail!
        Vehicle.HasKeys = LocalPlayer.HasKeys(plateText) or isOwner

		if (Vehicle.IsHotwired == 1) then
            Vehicle.HasKeys = true
            Chat.Log("^5*** You notice a bunch of weird wires.")
		end

		if (not isOwner and not Vehicle.HasKeys) then
            if (not IsVehicleEngineOn(Vehicle.Entity)) then
                Chat.Log("^1You don't have the keys for this vehicle.")
				SetVehicleUndriveable(Vehicle.Entity, true)
			end
		end

		-- if it's the owner or the player has the keys, go ahead
		if (isOwner or Vehicle.HasKeys or Vehicle.IsHotwired) then			
			Vehicle.LastDamageCheck = GetGameTimer()
			Vehicle.LastEngineHealth = GetVehicleEngineHealth(Vehicle.Entity)
			Vehicle.LastBodyHealth = GetVehicleBodyHealth(Vehicle.Entity)

            LocalPlayer.CanDrive = true
			
			-- prepare for fuel
			Vehicle.LastFuelCheck = GetGameTimer()
		
			if (DecorGetFloat(Vehicle.Entity, 'fuel') == 0) then
				DecorSetFloat(Vehicle.Entity, 'fuel', 16.0)
			end
			
			Vehicle.Fuel = DecorGetFloat(Vehicle.Entity, 'fuel')

			SetVehicleHasBeenOwnedByPlayer(Vehicle.Entity, true)

            -- ensure damage flag is set
            Vehicle.IsDamaged = GetVehicleBodyHealth(Vehicle.Entity) <= 100 or GetVehicleEngineHealth(Vehicle.Entity)						
			Vehicle.IsEngineRunning = IsVehicleEngineOn(Vehicle.Entity)
			Vehicle.SteeringAngle = GetVehicleSteeringAngle(Vehicle.Entity)
			Vehicle.MaxSpeed = GetVehicleHandlingFloat(Vehicle.Entity, "CHandlingData", "fInitialDriveMaxFlatVel")

			if (not LocalPlayer.IsHudHidden) then
				DisplayRadar(true)
            end
            
			LocalPlayer.ShowHud = true
		else
			local lockStatus = GetVehicleDoorLockStatus(Vehicle.Entity)
			if (lockStatus == 4) then -- stop window breaking
				ClearPedTasks(LocalPlayer.Ped)
			elseif (lockStatus == 7) then -- local is driving
				SetVehicleDoorsLocked(Vehicle.Entity, 2)

				local drivingPed = GetPedInVehicleSeat(drivingPed, -1)
				if (drivingPed) then
					SetPedCanBeDraggedOut(drivingPed, false)
				end
			end		
		end
		SetVehicleLightMultiplier(Vehicle.Entity, 1.0)	
	else
		if (not LocalPlayer.IsHudHidden) then
			DisplayRadar(true)
		end
		LocalPlayer.ShowHud = true
	end    
end

function Vehicle.Exit()
    if (not LocalPlayer.InVehicle or Vehicle.Entity == nil) then
		return
	end
	
	if (LocalPlayer.IsDriving) then
		if (Vehicle.IsEngineRunning and not Vehicle.IsDamaged) then
			SetVehicleEngineOn(Vehicle.Entity, true, true)
			SetVehicleRadioEnabled(Vehicle.Entity, 1)	
			SetVehicleLightMultiplier(Vehicle.Entity, 25.0) -- todo ????
			--Citizen.InvokeNative(0xBC3CCA5844452B06, Vehicles.Vehicle.Entity, 1.0) -- todo ????
		end
	end

	--SetVehicleSteeringAngle(Vehicles.Vehicle.Entity, Vehicles.Vehicle.SteeringAngle)

	Vehicle.Name = GetDisplayNameFromVehicleModel(GetEntityModel(Vehicle.Entity))
	if (Vehicle.Name == 'TAXI' and not TaxiDriver.IsPlayerOnDuty and GetPedInVehicleSeat(Vehicle.Entity, -1) ~= LocalPlayer.Ped) then
		TriggerServerEvent('gtarp:TaxiGetOut', GetPlayerServerId(PlayerId()), GetVehicleNumberPlateText(Vehicle.Entity))
	end

	Vehicle.Entity = nil
	Vehicle.LastFuelCheck = nil
    Vehicle.IsMedicalVehicle = false	
	Vehicle.Speed = 0
	Vehicle.LeftGroundAt = nil
    Vehicle.MaxHeight = nil
    
    LocalPlayer.InVehicle = false
    LocalPlayer.IsDriving = false
    LocalPlayer.CanDrive = false

	if (Vehicle.IsPoliceVehicle) then
		Vehicle.IsPoliceVehicle = false
        LocalPlayer.ResetWeapons()
        
		if (Police.HeliCam.Enabled) then
			Police.ExitHeliCam()
		end
	end
	
	Vehicle.LastDamageCheck = nil

	if (not LocalPlayer.IsHudHidden) then
		DisplayRadar(false)
	end
	LocalPlayer.ShowHud = false    
end

function Vehicle.HandleSpikes()

end

function Vehicle.HandleShuffle()
	CanShuffleSeat(Vehicle.Entity, false)
	
	if (not Vehicle.AllowShuffling) then
        if (GetPedInVehicleSeat(Vehicle.Entity, 0) == LocalPlayer.Ped 
            and GetIsTaskActive(LocalPlayer.Ped, 165) 
            and not GetIsTaskActive(LocalPlayer.Ped, 2) 
            and IsVehicleSeatFree(Vehicle.Entity, -1)) then
			    SetPedIntoVehicle(LocalPlayer.Ped, Vehicle.Entity, 0)	
		end	
	else
        if (GetPedInVehicleSeat(Vehicle.Entity, 0) == LocalPlayer.Ped 
            and not GetIsTaskActive(LocalPlayer.Ped, 165)
            and not GetIsTaskActive(LocalPlayer.Ped, 2)
            and IsVehicleSeatFree(Vehicle.Entity, -1)) then
			    -- shuffle wasnt working... had the force the task once on allow shuffle
			    TaskShuffleToNextVehicleSeat(LocalPlayer.Ped, Vehicle.Entity)
		end	
	end	
end

function Vehicle.ProcessModifiers()    
    if (not LocalPlayer.IsDriving or not DoesEntityExist(LocalPlayer.Ped) and not IsPlayerControlOn(LocalPlayer.Ped)) then
		return
	end
    
    if (LocalPlayer.IsDead or IsPlayerBeingArrested(PlayerId(), true)) then
        return
    end
	
	if (Vehicle.Handling.Base < 0.0) then
		Vehicle.Handling.Base = 35.0
	end
	
	Vehicle.Handling.RelVector = GetEntitySpeedVector(Vehicle.Entity, true)
	
	Vehicle.Handling.Angle = math.acos(Vehicle.Handling.RelVector.y / Vehicle.Speed) * 180.0 / 3.14159265
	
	if (tonumber(Vehicle.Handling.Angle) == nil) then
		Vehicle.Handling.Angle = 0.0
	end
	
	if (Vehicle.Speed < Vehicle.Handling.Base) then
		Vehicle.Handling.SpeedMultiplier = (Vehicle.Handling.Base - Vehicle.Speed) / Vehicle.Handling.Base
	end
	
	Vehicle.Handling.PowerMultiplier = 1.0 + Vehicle.Handling.PowerAdjust * (((Vehicle.Handling.Angle / 90) * Vehicle.Handling.AngleImpact) + ((Vehicle.Handling.Angle / 90) * Vehicle.Handling.SpeedMultiplier * Vehicle.Handling.SpeedImpact))
	Vehicle.Handling.TorqueMultiplier = 1.0 + Vehicle.Handling.TorqueAdjust * (((Vehicle.Handling.Angle / 90) * Vehicle.Handling.AngleImpact) + ((Vehicle.Handling.Angle / 90) * Vehicle.Handling.SpeedMultiplier * Vehicle.Handling.SpeedImpact))
	
	Vehicle.Handling.AccelValue = GetControlValue(0, 71)
	Vehicle.Handling.BrakeValue = GetControlValue(0, 72)
		
	if (Vehicle.Handling.Angle <= 135 and Vehicle.Handling.Angle > Vehicle.Handling.Deadzone) then
		SetVehicleEngineTorqueMultiplier(Vehicle.Entity, Vehicle.Handling.TorqueMultiplier)
		SetVehicleEnginePowerMultiplier(Vehicle.Entity, Vehicle.Handling.PowerMultiplier)
	else
		Vehicle.Handling.PowerMultiplier = 1.0
		Vehicle.Handling.TorqueMultiplier = 1.0
	end
end

function Vehicle.HandleOffGround()

end

function Vehicle.HandleCrash()

end

function Vehicle.RequestInventory()

end

function Vehicle.DrawHud()
    if (not LocalPlayer.ShowHud or LocalPlayer.IsHudHidden) then
		return
	end
	
	if (not LocalPlayer.InVehicle or not DoesEntityExist(Vehicle.Entity)) then
		return
	end
	
	-- calculate speeds for display
	Vehicle.Speed = GetEntitySpeed(Vehicle.Entity)
	Vehicle.SpeedKnots = math.floor(Vehicle.Speed * 1.94384 + 0.5)
	Vehicle.SpeedMph = math.floor(Vehicle.Speed * 2.23694 + 0.5)
	Vehicle.SpeedKph = math.floor(Vehicle.Speed * 3.6 + 0.5)
	
	-- speed text
	Vehicle.SpeedText = string.format('%d mph | %d kmh', Vehicle.SpeedMph, Vehicle.SpeedKph)
	Core.DrawText({x = 0.52, y = 1.25}, {width=1, height=1, scale=0.5}, {r=255,g=255,b=255,a=255}, Vehicle.SpeedText)
	
	-- if driving, display fuel text
	if (LocalPlayer.IsDriving) then
		Vehicle.FuelText = string.format('%0.1f%s', Vehicle.Fuel - 1, 'g')
		Core.DrawText({x = 0.62, y = 1.25}, {width=1, height=1, scale=0.5}, {r=255,g=255,b=0,a=255}, Vehicle.FuelText)
    end
    
    -- todo
    -- move gps hud draw here
end

function Vehicle.HandleFuel()

end

function Vehicle.HandleDamage()

end

function Vehicle.ProcessSpeedControl()

end

function Vehicle.ShuffleSeat()
end

function Vehicle.Fix()
end

function Vehicle.UseRepairKit()
end

function Vehicle.Fuel(value)
end

function Vehicle.Wash()
end

function Vehicle.CanFuel()
end

function Vehicle.GetFuel()
    if (not Vehicle.GetTarget()) then
        return false
    end

    return DecorGetFloat(Vehicles.GetTarget(), 'fuel')
end

function Vehicle.GetTarget()
	return nil
end