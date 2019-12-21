AddEventHandler('onMySqlReady', function()
    Core.IsBootingUp = true
    Core.IsAllowingConnections = true
end)