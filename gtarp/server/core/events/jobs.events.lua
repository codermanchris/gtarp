RegisterNetEvent('gtarp:JobStart')
AddEventHandler('gtarp:JobStart', function(playerId, jobId)
    if (not Core.IsPlayerValid(source, playerId)) then
        return
    end
    Jobs.StartJob(playerId, jobId)
end)

RegisterNetEvent('gtarp:JobQuit')
AddEventHandler('gtarp:JobQuit', function(playerId)
    if (not Core.IsPlayerValid(source, playerId)) then
        return
    end
    Jobs.QuitJob(playerId)
end)

RegisterNetEvent('gtarp:JobRequestPay')
AddEventHandler('gtarp:JobRequestPay', function(playerId)
    if (not Core.IsPlayerValid(source, playerId)) then
        return
    end
    Jobs.RequestPay(playerId)
end)