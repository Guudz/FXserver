entreprise2 = {}
entreprise2Load = false 



function LogsDiscord(Couleur, Titre, Value, Webhook)

    local Content = {
        {
            ["author"] = {
                ["name"] = "Logs Police" ,
            },
            ["title"] = Titre,
            ["description"] = Value,
            ["color"] = Couleur,
            ["footer"] = {
                ["text"] = "Logs Police ",
            }
        }
    }    
    PerformHttpRequest(Webhook, function() end, 'POST', json.encode({username = nil, embeds = Content}), {['Content-Type'] = 'application/json'})

end

CreateThread(function()
    MySQL.Async.fetchAll("SELECT * FROM entreprise2", {}, function(result)

        for k, v in pairs(result) do 
            if not entreprise2[v.name] then 
                entreprise2[v.name] = {}
                entreprise2[v.name].name = v.name
                entreprise2[v.name].label = v.label
                v.data = json.decode(v.data)
                if v.data ~= nil then 
                    if v.data["items"] ~= nil then 
                        entreprise2[v.name].data = v.data
                    else
                        entreprise2[v.name].data = v.data
                        entreprise2[v.name].data["weapons"] = {}
                    end
                else
                    entreprise2[v.name].data = {
                        ["items"] = {},
                        ["weapons"] = {},
                        ["accounts"] = {
                            cash = 0,
                            dirtycash = 0
                        }
                    }
                end

            end
        end

    end)
    entreprise2Load = true 
end)



RegisterNetEvent("ronflex:saisiespoliceitem")
AddEventHandler("ronflex:saisiespoliceitem", function(action, name, count)
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.job.name == "police" then 
        if action == "deposit" then 
            local InfosItem = xPlayer.getInventoryItem(name)
            if tonumber(InfosItem.count) >= tonumber(count) then 
                if not entreprise2["police"].data["items"][InfosItem.name] then 
                    entreprise2["police"].data["items"][InfosItem.name] = {}
                    entreprise2["police"].data["items"][InfosItem.name].name = InfosItem.name 
                    entreprise2["police"].data["items"][InfosItem.name].label = InfosItem.label 
                    entreprise2["police"].data["items"][InfosItem.name].count = tonumber(count)
                    TriggerClientEvent("ronflex:recievesaisieslspdclientside", source, entreprise2["police"])
                    xPlayer.removeInventoryItem(name, count)
                    TriggerClientEvent(ConfigPoliceJob.ESX.."esx:showNotification", source, "Vous venez de déposer ~r~"..count.."~s~ ~g~"..InfosItem.label.."~s~ dans les  saisies")
                else
                    entreprise2["police"].data["items"][InfosItem.name].count = entreprise2["police"].data["items"][InfosItem.name].count + tonumber(count)
                    TriggerClientEvent("ronflex:recievesaisieslspdclientside", source, entreprise2["police"])
                    xPlayer.removeInventoryItem(name, count)
                    TriggerClientEvent(ConfigPoliceJob.ESX.."esx:showNotification", source, "Vous venez de déposer ~r~"..count.."~s~ ~g~"..InfosItem.label.."~s~ dans les  saisies")
                end
            else
                xPlayer.showNotification("Vous ne disposez pas de la quantité nécéssaire")
            end
        elseif action == 'remove' then 
            if entreprise2["police"].data["items"][name] then 
                if entreprise2["police"].data["items"][name].count >= tonumber(count) then 
                    entreprise2["police"].data["items"][name].count = entreprise2["police"].data["items"][name].count-tonumber(count)
                    TriggerClientEvent(ConfigPoliceJob.ESX.."esx:showNotification", source, "Vous venez de récupérer ~r~"..count.."~s~ ~g~"..entreprise2["police"].data["items"][name].label.."~s~ dans les  saisies")

                    if entreprise2["police"].data["items"][name].count == 0 then 
                        entreprise2["police"].data["items"][name] = nil 
                    end
                    TriggerClientEvent("ronflex:recievesaisieslspdclientside", source, entreprise2["police"])
                    xPlayer.addInventoryItem(name, count)
                end
            else
                print('Ban')
            end
        end
    end
end)


RegisterNetEvent("ronflex:saisiespoliceweapon")
AddEventHandler("ronflex:saisiespoliceweapon", function(action, name, label)
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.job.name == "police" then 
        if action == "deposit" then 
            local InfosWeapon = xPlayer.getWeapon(name)
            if InfosWeapon > 0 then 
                if not entreprise2["police"].data["weapons"][name] then 
                    entreprise2["police"].data["weapons"][name] = {}
                    entreprise2["police"].data["weapons"][name].name = name 
                    entreprise2["police"].data["weapons"][name].label = label 
                    entreprise2["police"].data["weapons"][name].count = 1
                    TriggerClientEvent("ronflex:recievesaisieslspdclientside", source, entreprise2["police"])
                    xPlayer.removeWeapon(name)
                    TriggerClientEvent(ConfigPoliceJob.ESX.."esx:showNotification", source, "Vous venez de récupérer ~r~x1~s~ ~g~"..entreprise2["police"].data["weapons"][name].label.."~s~ dans les  saisies")
                else
                    entreprise2["police"].data["weapons"][name].count = entreprise2["police"].data["weapons"][name].count + 1
                    xPlayer.removeWeapon(name)
                    TriggerClientEvent("ronflex:recievesaisieslspdclientside", source, entreprise2["police"])
                    TriggerClientEvent(ConfigPoliceJob.ESX.."esx:showNotification", source, "Vous venez de récupérer ~r~x1~s~ ~g~"..entreprise2["police"].data["weapons"][name].label.."~s~ dans les  saisies")
                end
            else
                xPlayer.showNotification("Vous ne disposez pas de la quantité nécéssaire")
            end
        elseif action == 'remove' then 
            if entreprise2["police"].data["weapons"][name] then 
                entreprise2["police"].data["weapons"][name].count = entreprise2["police"].data["weapons"][name].count - 1
                xPlayer.addWeapon(name, 150)
                TriggerClientEvent(ConfigPoliceJob.ESX.."esx:showNotification", source, "Vous venez de retirer ~r~x1~s~ ~g~"..entreprise2["police"].data["weapons"][name].label.."~s~ dans les  saisies")
                if entreprise2["police"].data["weapons"][name].count == 0 then 
                    entreprise2["police"].data["weapons"][name] = nil 
                end

                TriggerClientEvent("ronflex:recievesaisieslspdclientside", source, entreprise2["police"])
            else
                print('Ban')
            end
        end
    end
end)


RegisterNetEvent("ronflex:saisiespoliceamount")
AddEventHandler("ronflex:saisiespoliceamount", function(action , amount)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.job.name == "police" then 
        if action == "deposit" then 
            if xPlayer.getAccount('dirtycash').money >= tonumber(amount) then 
                entreprise2["police"].data["accounts"].dirtycash = entreprise2["police"].data["accounts"].dirtycash + tonumber(amount)
                xPlayer.removeAccountMoney('dirtycash', amount)
                TriggerClientEvent("ronflex:recievesaisieslspdclientside", source, entreprise2["police"])
                TriggerClientEvent(ConfigPoliceJob.ESX.."esx:showNotification", source, "Vous venez de déposer ~r~"..amount.." dans les  saisies")
            else
                xPlayer.showNotification("Vous n'avez pas asser de fond pour faire cela")
            end
        elseif action == "remove" then 
            if ConfigPoliceJob.GradeAutorizeToRemoveMoney[xPlayer.job.grade_name] == true then 
                if entreprise2["police"].data["accounts"].dirtycash >= tonumber(amount) then 
                    entreprise2["police"].data["accounts"].dirtycash = entreprise2["police"].data["accounts"].dirtycash - tonumber(amount)
                    xPlayer.addAccountMoney('dirtycash', amount)
                    TriggerClientEvent("ronflex:recievesaisieslspdclientside", source, entreprise2["police"])
                    TriggerClientEvent(ConfigPoliceJob.ESX.."esx:showNotification", source, "Vous venez de retirer ~r~"..amount.." dans les  saisies")
    
                else
                    xPlayer.showNotification("Il n'y à pas asser de fonds pour retirer cette somme")
                end
            else
                print("ban")
            end
        end
    end
end)

RegisterNetEvent("ronflex:recievesaisieslspd")
AddEventHandler("ronflex:recievesaisieslspd", function()
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.job.name == "police" then 
        TriggerClientEvent("ronflex:recievesaisieslspdclientside", source, entreprise2["police"])
    else
        print("Ban")
    end

end)

CreateThread(function()
    while not entreprise2Load do 
        Wait(1)
    end

    while true do 
        Wait(100)
        for k, v in pairs(entreprise2) do 
            MySQL.Sync.execute("UPDATE entreprise2 set data = @data WHERE name=@name", {
                ["@data"] = json.encode(v.data),
                ["@name"] = v.name
            })
        end

    end
end)



CreateThread(function()
    Wait(500)   

    print([[
                                                                
        sPolicejob, Dev by ^4 >Seeker*#0009 ^0
        Job succefully started
        
    ]])

   
end)


