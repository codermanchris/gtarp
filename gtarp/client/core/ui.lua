RegisterNUICallback('RequestAccountInfo', function(data, cb)
	if (Core.CanGetAccountData) then
		TriggerServerEvent('gtarp:RequestAccount', Core.PlayerId)
	end
end)


function UI.Message(data)
	SendNUIMessage(data)
end
--UI.Message({ screen = nil, 'onSetAccountData', permissionLevel = permissionLevel, cityAccess = cityAccess, characters = characters })    