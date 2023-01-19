ESXLoad = false 
ESX = nil

Player = {
    WeaponData = {}
}

function LoadEsx()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
    
    ESX.PlayerData = ESX.GetPlayerData()
    Player.WeaponData = ESX.GetWeaponList()

    for k, v in pairs(Player.WeaponData) do 
        if v.name == "WEAPON_UNARMED" then 
            v = nil 
        else
            v.hash = GetHashKey(v.name)
        end
    end
    ESXLoad = true 
    print("INIT ESX")
end

RegisterCommand("reload", function()
    LoadEsx()
end)


RegisterNetEvent("esx:setjob")
AddEventHandler("esx:setjob", function(job)
    ESX.PlayerData.job = job 
end)

RegisterNetEvent("esx:setjob2")
AddEventHandler("esx:setjob2", function(job2)
    ESX.PlayerData.job2 = job2
end)

RegisterNetEvent("esx:setGroup")
AddEventHandler("esx:setGroup", function(group, lastgroup)
    ESX.PlayerData.group = group
end)

RegisterNetEvent("esx:playerLoaded")
AddEventHandler("esx:playerLoaded", function(player)
    LoadEsx()
end)