function Threads.Start(object)
    print('started game thread for ' .. tostring(object))
    
    Citizen.CreateThread(function()
        object.Initialize()
        while true do
            Citizen.Wait(0)
            object.Tick()
        end
    end)
end