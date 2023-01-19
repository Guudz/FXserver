ESX = nil
ESXLoad = false 

Player = {
    WeaponData = {}
}

function LoadEsx()
    while ESX == nil do
        TriggerEvent(ConfigPoliceJob.ESX..'esx:getSharedObject', function(obj) ESX = obj end)
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


RegisterCommand("reload", function()
    LoadEsx()
end)

RegisterNetEvent(ConfigPoliceJob.ESX..'esx:playerLoaded')
AddEventHandler(ConfigPoliceJob.ESX..'esx:playerLoaded', function(xPlayer)
	LoadEsx()
end)

RegisterNetEvent(ConfigPoliceJob.ESX..'esx:setJob')
AddEventHandler(ConfigPoliceJob.ESX..'esx:setJob', function(job)
	ESX.PlayerData.job = job
end)




OpenAmmuNationPolice = function()
    local mainammunationpolice = RageUI.CreateMenu("", "Voici les armes disponibles")
    RageUI.Visible(mainammunationpolice, not RageUI.Visible(mainammunationpolice))

    while mainammunationpolice do 
        Wait(0)

        RageUI.IsVisible(mainammunationpolice, function()
            RageUI.Separator("Votre Grade: ~r~"..ESX.PlayerData.job.grade_label)

            for k, v in pairs(ArmesPolice[ESX.PlayerData.job.grade_name]) do 
                RageUI.Button("→ "..v.label.."", nil, {RightLabel = "→→→"}, true, {
                    onSelected = function()
                        TriggerServerEvent("ronflex:addweaponpolice", v.name)
                    end
                })
            end
            
        
        end, function()
        end)

        if not RageUI.Visible(mainammunationpolice) then
            mainammunationpolice = RMenu:DeleteType("mainammunationpolice")
        end 

    end
end





Citizen.CreateThread(function()

    while not ESXLoad do 
        Wait(1)
    end

    for k, v in pairs(ConfigPoliceJob.Zones) do 
        if v.Blips then 
            local blips = AddBlipForCoord(v.Postion)

            SetBlipSprite(blips, v.Sprite)
            SetBlipColour(blips, v.Colour)
            SetBlipAsShortRange(blips, true)
            -- SetBlipDisplay(blips, 4)
            SetBlipScale(blips, v.Scale)
    
            BeginTextCommandSetBlipName('STRING')
            AddTextComponentSubstringPlayerName(v.Name)
            EndTextCommandSetBlipName(blips)
        end
    end

    while true do 
        Spam = false 
        for k, v in pairs(ConfigPoliceJob.Zones) do 
            if  ESX.PlayerData.job.name == "police"  then 
                local dist = Vdist2(GetEntityCoords(PlayerPedId()), v.MarkerPosition)
                if dist < 30 then 
                    Spam = true 
                    DrawMarker(ConfigPoliceJob.Marker.Type, v.MarkerPosition, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.35, 0.35, 0.35, ConfigPoliceJob.Marker.Color["r"],ConfigPoliceJob.Marker.Color["g"], ConfigPoliceJob.Marker.Color["b"], 255, 55555, false, true, 2, false, false, false, false)
                end
                if dist < 15 then 
                    ESX.ShowHelpNotification("Appuyer sur ~INPUT_CONTEXT~ pour intéragir")
                    if IsControlJustPressed(0, 51) then 
                        v.Action()
                    end
                end
               
            end
        end
        if Spam then 
            Wait(0)
        else
            Wait(255)
        end
    end


end)