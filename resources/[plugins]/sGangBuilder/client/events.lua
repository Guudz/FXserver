--[[
  This file is part of Ronflex Shop.

  Copyright (c) Ronflex Shop - All Rights Reserved

  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]


GangLoad = false 

ESX = nil
ESXLoad = false 

Player = {
    WeaponData = {}
}



function LoadEsx()
    while ESX == nil do
        TriggerEvent(ConfigGangBuilder.ESX, function(obj) ESX = obj end)
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
    print("ESX Load avec succès")
end

RegisterNetEvent(ConfigGangBuilder.PrefixESX..'esx:playerLoaded')
AddEventHandler(ConfigGangBuilder.PrefixESX..'esx:playerLoaded', function(xPlayer)
	LoadEsx()
end)

RegisterNetEvent(ConfigGangBuilder.PrefixESX..'esx:setJob')
AddEventHandler(ConfigGangBuilder.PrefixESX..'esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

RegisterNetEvent(ConfigGangBuilder.PrefixESX..'esx:setJob2')
AddEventHandler(ConfigGangBuilder.PrefixESX..'esx:setJob2', function(job2)
	ESX.PlayerData.job2 = job2
end)

RegisterNetEvent("ronflex:recievenewgangclientsidee")
AddEventHandler("ronflex:recievenewgangclientsidee", function(gang)
    GangInfos = gang
    GangLoad = true
    print("Gang Recu")
end)


RegisterNetEvent("ronflex:recievecoffreclientside")
AddEventHandler("ronflex:recievecoffreclientside", function(infosgang)
    CoffreGang = infosgang
    CoffreLoad = true
end)

CreateThread(function()
    Wait(500)
    LoadEsx()
    TriggerServerEvent("ronflex:recievegang")
end)