--[[
  This file is part of Ronflex Shop.

  Copyright (c) Ronflex Shop - All Rights Reserved

  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]

ESX = nil
Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent(Config.ESX..'esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

local JailTime = 0

RegisterNetEvent("requestRequetteJailTime")
AddEventHandler("requestRequetteJailTime", function(result)
    JailTime = result
    if JailTime == 0 then
        RageUI.CloseAll()
    end 
end)


RegisterNetEvent("ronflex:menujail")
AddEventHandler("ronflex:menujail", function(time, raison, staffname)
    local mainjail = RageUI.CreateMenu("Prison", "Vous êtes emprisonnée")
    mainjail.Closable = false 
    
    RageUI.Visible(mainjail, not RageUI.Visible(mainjail))

    inJail = true 

    while mainjail do 
        Wait(0)

        RageUI.IsVisible(mainjail, function()


            if tostring(JailTime) == "1" then 
                
                RageUI.Separator("Temps restant :~g~ 1 minute")
            else
                RageUI.Separator("Temps restant :~g~ "..ESX.Math.Round(JailTime).." minutes")
            end


            if raison ~= nil then 
                RageUI.Button("Raison : ~g~"..raison.."", nil, {}, true, {})
            else
                RageUI.Button("Raison : ~g~ Indéfinie", nil, {}, true, {})
            end

            if staffname ~= nil then 
                RageUI.Button("Nom du staff : ~g~"..staffname, nil, {}, true, {})
            else
                RageUI.Button("> CONSOLE", nil, {}, true, {})
            end

        end, function()
        end)

        if not RageUI.Visible(mainjail) then 
            mainjail = RMenu:DeleteType('mainjail')
        end
    end
end)

Citizen.CreateThread(function()
    Wait(2500)
    TriggerServerEvent("requestjailtime")
    while true do
        if tonumber(JailTime) >= 1 then
            Wait(60000)
            JailTime = JailTime - 1
            TriggerServerEvent("UpdateJailTick", JailTime)
        end
        if tonumber(JailTime) == 0 then 
            RageUI.CloseAll()
        end
        Wait(2500)
    end
end)

Citizen.CreateThread(function()
    while true do
        if tonumber(JailTime) >= 1 then
            if #(GetEntityCoords(PlayerPedId()) - Config.PointEntrer) > 50 then
                SetEntityCoords(PlayerPedId(), Config.PointEntrer)
            end
            if tonumber(JailTime) == 1 then 
                DrawMissionText('~w~Vous avez été mis en prison par un membre du staff\nVous sortirez dans ~g~'..ESX.Math.Round(JailTime)..' ~w~minute', 100)
            else
                DrawMissionText('~w~Vous avez été mis en prison par un membre du staff\nVous sortirez dans ~g~'..ESX.Math.Round(JailTime)..' ~w~minutes', 100)
            end
        end
        if tonumber(JailTime) >= 1 then
            Wait(0)
        else
            Wait(2500)
        end
    end
end)

function DrawMissionText(msg, time)
    ClearPrints()
    BeginTextCommandPrint('STRING')
    AddTextComponentSubstringPlayerName(msg)
    EndTextCommandPrint(time, 1)
end

Citizen.CreateThread(function()
    TriggerEvent('chat:addSuggestion', '/jail', 'Id, temps, raison')
    TriggerEvent('chat:addSuggestion', '/jailoffline', 'license, temps, raison ')
    TriggerEvent('chat:addSuggestion', '/unjail', 'Id')
end)

AddEventHandler('esx:onPlayerDeath', function(aa)
    TriggerServerEvent("ronflex:updatejailplayerider", true)
end)

-- CHANGEMENT BY BirdSide - JAIL

Citizen.CreateThread(function()
    TriggerEvent('chat:addSuggestion', '/jail', 'Id, temps, raison')

end)

-- CHANGEMENT BY BirdSide - JAILOFFLINE

Citizen.CreateThread(function()
    TriggerEvent('chat:addSuggestion', '/jailoffline', 'license, temps, raison ')

end)

-- CHANGEMENT BY BirdSide - JAILOFFLINE

Citizen.CreateThread(function()
    TriggerEvent('chat:addSuggestion', '/unjail', 'Id')

end)

-- CHANGEMENT BY BirdSide - BLIP

Citizen.CreateThread(function()
    local blip = AddBlipForCoord(Config.JailBlip)

    SetBlipSprite(blip, 188)
    SetBlipScale (blip, 1.2)
    SetBlipColour(blip, 40)
    SetBlipAsShortRange(blip, true)

    BeginTextCommandSetBlipName('STRING')
    AddTextComponentSubstringPlayerName('~g~Prison de MercuryLife ~s~| Grand Senora Desert')
    EndTextCommandSetBlipName(blip)
end)