RegisterNetEvent("ronflex:settimerprison")
AddEventHandler("ronflex:settimerprison", function(timer, code)
    ESX.ShowNotification("Vous êtes en prison pendant ~r~"..timer.." minutes~s~ vous serez remis dehors automatiquement si vous ne vous déconnectez pas")
    while true do
        if tonumber(timer) >= 1 then
            Wait(600)
            timer = timer - 1
            TriggerServerEvent("ronflex:updatetimerprison", timer, code)
        end
        Wait(2500)
    end
end)
