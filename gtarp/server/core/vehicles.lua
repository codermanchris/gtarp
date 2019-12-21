-- Slash Commands
Commands:Register('trunk', 0, function(playerId, args)
    if (not Core.IsSourceValid(playerId)) then
        return
    end
    Vehicles.ToggleTrunk(playerId)
end)

-- Net Events
RegisterServerEvent('gtarp:VehicleRegisterStolen')
AddEventHandler('gtarp:VehicleRegisterStolen', function(playerId, licensePlate)
    if (not Core.IsPlayerIdValid(source, playerId)) then
        return
    end
    Vehicles.RegisterStolen(playerId, licensePlate)
end)

RegisterServerEvent('gtarp:VehicleStashItem')
AddEventHandler('gtarp:VehicleStashItem', function(playerId, licensePlate, itemName, quantity)
    if (not Core.IsPlayerIdValid(source, playerId)) then
        return
    end
    Vehicles.StashItem(playerId, licensePlate, itemName, quantity)  
end)

RegisterServerEvent('gtarp:VehicleGetStashedItem')
AddEventHandler('gtarp:VehicleGetStashedItem', function(playerId, licensePlate, itemName, quantity)
    if (not Core.IsPlayerIdValid(source, playerId)) then
        return
    end
    Vehicles.GetStashedItem(playerId, licensePlate, itemName, quantity)  
end)

-- Class Functions
function Vehicles.Enter(playerId, licensePlate)

end

function Vehicles.Register(playerId, licensePlate)
	if (Vehicles.Vehicles[licensePlate] ~= nil) then
		return
	end

	Vehicles.Vehicles[licensePlate] = {
		PlayerId = playerId,
        LicensePlate = licensePlate,
        Status = 0, -- todo: 0 stolen, 1 owned, 2 work
        Items = {}
	}
end

function Vehicles.Get(licensePlate)
    return Vehicles.Vehicles[licensePlate]
end

function Vehicles.StashItem(playerId, licensePlate, itemName, quantity)
    -- validate incoming data
    if (licensePlate == nil or licensePlate == '' or itemName == nil or itemName == '' or tonumber(quantity) == nil) then
        return
    end

    -- validate character
    local character = Characters.Get(playerId)
    if (character == nil) then
        return
    end

    -- get item data
    local itemData = Common.Items[itemName]
    if (itemData == nil) then
        return
    end

    -- validate stacking
    if (quantity > 1 and not itemData.CanStack) then
        Core.Respond(playerId, '^1You cannot stack that item.')
        return
    end

    -- get item from inventory 
    local item = character:GetItem(itemName)
    if (item == nil or item.Quantity < tonumber(quantity)) then
        Core.Respond(playerId, "^1You don't have that item.")
        return
    end

    -- validate vehicle
    local vehicle = Vehicles.Get(licensePlate)
    if (vehicle == nil) then
        Core.Respond(playerId, "^1There was a problem locating that vehicle.")
        return
    end

    local vehicleItem = vehicle.Items[itemName]
    if (vehicleItem == nil) then
        if (quantity <= itemData.MaxStack) then
            vehicleItem = {
                Quantity = quantity,
                PlayersInTrunk = {} 
            }
            vehicle.Items[itemName] = vehicleItem
        else
            Core.Respond(playerId, '^1You cannot stash that many of that item.')
            return
        end
    else
        vehicleItem.Quantity = vehicleItem.Quantity + quantity
    end    

    -- notify requestor about changes
    Core.Event(playerId, 'gtarp:VehicleSetTrunk', vehicle.Items, character.Items)

    -- notify any character accessing the trunk
    for k, v in pairs(vehicleItem.PlayersInTrunk) do
        if (k ~= playerId) then
            Core.Event(k, 'gtarp:VehicleSetTrunk', vehicle.Items, nil)
        end
    end
end

function Vehicles.GetStashedItem(playerId, licensePlate, itemName, quantity)
    -- validate incoming data
    if (licensePlate == nil or licensePlate == '' or itemName == nil or itemName == '' or tonumber(quantity) == nil) then
        return
    end

    -- validate character
    local character = Characters.Get(playerId)
    if (character == nil) then
        return
    end
    
    -- validate vehicle
    local vehicle = Vehicles.Get(licensePlate)
    if (vehicles == nil) then
        return
    end

    local vehicleItem = vehicle.Items[itemName]
    if (vehicleItem == nil) then
        return
    end
end