InService = 0 
PlayerPolice = {}
Cellule = {}

RegisterNetEvent("ronflex:servicepolice")
AddEventHandler("ronflex:servicepolice", function(value)
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.job.name == "police" then 
        if value then 
            PlayerPolice[source] = source
            InService = InService+1
            for k, v in pairs(PlayerPolice) do 
                TriggerClientEvent(ConfigPoliceJob.ESX.."esx:showNotification", k, "~r~Central Police~s~~n~L'agent ~r~"..xPlayer.getName().." ~s~viens de prendre son service")
                TriggerClientEvent("ronflex:recieveagentpolice", k, InService)
            end
        else
            PlayerPolice[source] = nil
            InService = InService-1
            for k, v in pairs(PlayerPolice) do 
                TriggerClientEvent(ConfigPoliceJob.ESX.."esx:showNotification", k, "~r~Central Police~s~~n~L'agent ~r~"..xPlayer.getName().." ~s~viens de finir son service")
                TriggerClientEvent("ronflex:recieveagentpolice", k, InService)
            end
        end
    else
        print("ban")
    end
end)

RegisterNetEvent("ronflex:confiscateitem")
AddEventHandler("ronflex:confiscateitem", function(count, item, player, action, label)
    local xPlayer = ESX.GetPlayerFromId(source)
    local tPlayer = ESX.GetPlayerFromId(player)
    if xPlayer.job.name == 'police' then 
        if PlayerPolice[source] then 
            if tPlayer then 
                if action == "item" then 
                    InfoItem = tPlayer.getInventoryItem(item)
                    if InfoItem.count >= tonumber(count) then 
                        tPlayer.removeInventoryItem(item, count)
                        xPlayer.addInventoryItem(item, count)
                    end
                    tPlayer.showNotification("Vous venez de vous faire confisquer ~r~"..count.."~s~ de "..InfoItem.label)
                    xPlayer.showNotification("Vous venez de confisquer ~r~"..count.."~s~ de "..InfoItem.label)
                elseif action == "weapon" then
                    InfoWeapon = tPlayer.getWeapon(item)
                    if InfoWeapon > 0 then 
                        tPlayer.removeWeapon(item)
                        xPlayer.addWeapon(item, 20)
                        tPlayer.showNotification("Vous venez de vous faire confisquer un/une "..label)
                        tPlayer.showNotification("Vous venez de confisquer un/une "..label)
                    else
                        print("Ban")
                    end
                else
                    print("Ban")
                end
            end
        else
            print("Ban")
        end
    else
        print("Ban")
    end
end)

RegisterNetEvent("ronflex:demandederenfort")
AddEventHandler("ronflex:demandederenfort", function(type)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.job.name == "police" then 
        if PlayerPolice[source] then 
            for k, v in pairs(PlayerPolice) do 
                if type == "pause" then 
                    TriggerClientEvent(ConfigPoliceJob.ESX.."esx:showNotification", k, "L'agent ~r~"..xPlayer.getName().."~s~ viens de se mettre en pause !")
                elseif type == 'control' then
                    TriggerClientEvent(ConfigPoliceJob.ESX.."esx:showNotification", k, "L'agent ~r~"..xPlayer.getName().."~s~ est actuellement en control !")
                elseif type == "retrourpdp" then 
                    TriggerClientEvent(ConfigPoliceJob.ESX.."esx:showNotification", k, "L'agent ~r~"..xPlayer.getName().."~s~ est en route vers le commisariat")
                else
                    TriggerClientEvent(ConfigPoliceJob.ESX.."esx:showNotification", k, "L'agent ~r~"..xPlayer.getName().."~s~ à besoin de renfort, je t'ai mis les coordonnées sur ton GPS !")
                    TriggerClientEvent("ronflex:demandederenfort", k, type, GetEntityCoords(GetPlayerPed(source)))
                end
            end
        else
            print("Ban")
        end
    end
end)

RegisterNetEvent("ronflex:newcasierpolice")
AddEventHandler("ronflex:newcasierpolice", function(casier)
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.job.name == "police" then 
        if PlayerPolice[source] then 
            LogsDiscord(3447003, "Nouveau Casier Judiciaire", "Information sur l'agent: \nNom: **"..xPlayer.getName().."**\nLicense: **"..xPlayer.identifier.."**\nMatricule: **"..casier.matricule.."**\nInformation sur l\'individu: Nom: **"..casier.nameprename.."**\nRaison de l'arrestation: **"..casier.reason.."**\nTemps mis en cellule: **"..casier.timecellule.."**", ConfigPoliceJob.Logs.MenuPolice)
        else
            print("Ban")
        end
    end
end)



RegisterNetEvent("ronflex:miseencelule")
AddEventHandler("ronflex:miseencelule", function(player, timer, cellule)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.job.name == "police" then 
        if #(GetEntityCoords(GetPlayerPed(source)) - vec3(464.716492, -995.723084, 24.915772)) < 30 then 
            if PlayerPolice[source] then
                local tPlayer = ESX.GetPlayerFromId(player)
                if tPlayer then 
                    if cellule == '1' then 
                        SetEntityCoords(GetPlayerPed(tPlayer.source), ConfigPoliceJob.Cellule[1])
                    elseif cellule == "2" then 
                        SetEntityCoords(GetPlayerPed(tPlayer.source), ConfigPoliceJob.Cellule[2])
                    elseif cellule == "3" then 
                        SetEntityCoords(GetPlayerPed(tPlayer.source), ConfigPoliceJob.Cellule[3])
                    end
    
                    if not Cellule[tPlayer.identifier] then 
                        Cellule[tPlayer.identifier] = {}
                        Cellule[tPlayer.identifier].identifier = tPlayer.identifier
                        Cellule[tPlayer.identifier].timecellule = tonumber(timer)
                        Cellule[tPlayer.identifier].code = math.random(00000, 99999)
                        TriggerClientEvent("ronflex:settimerprison", tPlayer.source, timer, Cellule[tPlayer.identifier].code)
                    end
                end
            else
                print("ban")
            end
        else
            xPlayer.showNotification("Vous devez être au commisariat pour faire cela")
        end
      
    end
end)

RegisterNetEvent("ronflex:updatetimerprison")
AddEventHandler("ronflex:updatetimerprison", function(timer, code)
    local xPlayer = ESX.GetPlayerFromId(source)
    Cellule[xPlayer.identifier].timecellule = timer
    if tonumber(Cellule[xPlayer.identifier].code) == tonumber(code) then 
        if tonumber(Cellule[xPlayer.identifier].timecellule) == 0 then 
            Cellule[xPlayer.identifier] = nil 
            SetEntityCoords(GetPlayerPed(xPlayer.source), vec3(432.263732, -982.021972, 30.695190))
            xPlayer.showNotification("Vous avez été libéré de prison")
        end
    else
        print("Ban")
    end
end)

ESX.RegisterServerCallback("ronfex:fouillepolicecb", function(source, cb, player)
    local tPlayer = ESX.GetPlayerFromId(player)
    if tPlayer then 
        infosplayer = {
            inventory = tPlayer.getInventory(),
            weapon = tPlayer.getLoadout()
        }
    end
    cb(infosplayer)
end)


RegisterServerEvent('police:putInVehicle')
AddEventHandler('police:putInVehicle', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.job.name == "police" then 
        if target ~= -1 then 
            local xPlayerTarget = ESX.GetPlayerFromId(target)
            TriggerClientEvent('police:putInVehicle', target)
        else
            print("Ban")
        end
    else
        print("Ban")
    end
end)


RegisterServerEvent('police:OutVehicle')
AddEventHandler('police:OutVehicle', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.job.name == 'police' then
		local xPlayerTarget = ESX.GetPlayerFromId(target)
		TriggerClientEvent('police:OutVehicle', target)
	else
		print(('esx_policejob: %s attempted to drag out from vehicle (not cop)!'):format(xPlayer.identifier))
	end
end)


RegisterServerEvent('esx_policejob:drag')
AddEventHandler('esx_policejob:drag', function(target)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.job.name == 'police' then
        local xPlayerTarget = ESX.GetPlayerFromId(target)
        TriggerClientEvent('esx_policejob:drag', target, xPlayer.source)
    else
        print(('esx_policejob: %s attempted to put in vehicle (not cop)!'):format(xPlayer.identifier))
    end
end)

