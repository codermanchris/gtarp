function WorldItem.Add(worldItemId, x, y, z, itemName, quantity)
	WorldItem.Items[worldItemId] = {
		id = worldItemId,
		x = x,
		y = y, 
		z = z,
		textCoords = {x = x, y = y, z = z - 0.5 },
		itemName = itemName,
		quantity = quantity,
		displayText = tostring(quantity) .. 'x ' .. itemName
	}
end

function WorldItem.Remove(worldItemId)
	WorldItems.Items[worldItemId] = nil
end

function WorldItem.DrawItems()
	local playerPed = PlayerPedId()
	local playerCoords = GetEntityCoords(PlayerPedId(), false)

	for _, worldItem in pairs(WorldItem.Items)do
		local distance = GetDistanceBetweenCoords(playerCoords, worldItem)
		
        if (distance < 30.0) then
            Core.DrawMarker(28, worldItem, 0.15, Globals.Color.Yellow)
			--DrawMarker(28, worldItem.x, worldItem.y, worldItem.z-1.0, 0, 0, 0, 0, 0, 0, 0.15, 0.15, 0.15, 215, 214, 0, 50, 0, 0, 2, 0, 0, 0, 0)		
		end
	end
end