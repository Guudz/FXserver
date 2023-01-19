TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent("jobs_civil:pay")
AddEventHandler("jobs_civil:pay", function(i, money)
    local _source = source
    if i ~= 361 then
        print("[ID: ".._source.."] a tanté de se give "..money.." ("..i..")")
    else
        if money < 1000 then
            local xPlayer = ESX.GetPlayerFromId(_source)
            xPlayer.addAccountMoney('cash', money)
        end
    end
end)