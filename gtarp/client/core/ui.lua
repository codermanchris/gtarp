RegisterNUICallback('RequestAccountInfo', function(data, cb)
	if (Core.CanGetAccountData) then
		TriggerServerEvent('gtarp:RequestAccount', Core.PlayerId)
	end
end)
