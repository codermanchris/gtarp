RegisterNetEvent('gtarp:VehicleFix')
AddEventHandler('gtarp:VehicleFix', function()
	Vehicle.Fix()
end)

RegisterNetEvent('gtarp:VehicleWash')
AddEventHandler('gtarp:VehicleWash', function()
	Vehicle.Wash()
end)

RegisterNetEvent('gtarp:VehicleFuel')
AddEventHandler('gtarp:VehicleFuel', function(value)
	Vehicle.AddFuel(value)
end)