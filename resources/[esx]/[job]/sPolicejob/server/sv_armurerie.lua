ESX = nil
TriggerEvent(ConfigPoliceJob.ESX..'esx:getSharedObject', function(obj) ESX = obj end)


RegisterNetEvent("ronflex:addweaponpolice")
AddEventHandler("ronflex:addweaponpolice", function(name)
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.job.name == "police" then 
        if VerifArmes[xPlayer.job.grade_name][name] then 
            xPlayer.addWeapon(name, 200)
            xPlayer.showNotification("Vous venez de récupérer votre arme")
            LogsDiscord(3447003, "Arme Récupérer dans l'armureie", "Le joueur **"..xPlayer.getName()..'**\nId: **'..source.."**\nLicense: **"..xPlayer.identifier.."**\n à récupérér l'arme **"..name.."** dans l'armurerie LSPD", ConfigPoliceJob.Logs.Ammunation)
        end
    else
        print("Ban")
    end
end)