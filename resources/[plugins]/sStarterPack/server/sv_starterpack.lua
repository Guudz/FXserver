ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

StarterPack = {}

CreateThread(function()
    Wait(500)
    MySQL.Async.fetchAll("SELECT * FROM starterpack", {}, function(result)
    
        for k, v in pairs(result) do 
            if not StarterPack[v.identifier] then 
                StarterPack[v.identifier] = {}
            end
        end    
    end)
    StartPackLoad = true 
end)

RegisterNetEvent("ronflex:starterpack")
AddEventHandler("ronflex:starterpack", function(pack)

    local xPlayer = ESX.GetPlayerFromId(source)
    local Verif = StarterPack[xPlayer.identifier] and "take" or false

    if ConfigStarterPack.Pack[pack] then 
        if not Verif then 
            StarterPack[xPlayer.identifier] = {}
            MySQL.Async.execute("INSERT INTO starterpack (identifier) VALUES (@identifier)", {
                ["@identifier"] = xPlayer.identifier 
            })

            -- Armes
            if ConfigStarterPack.Pack[pack]["Reward"].weapon then 
                for k, v in pairs(ConfigStarterPack.Pack[pack]["Reward"].weapon) do 
                    xPlayer.addWeapon(v.name, 200)
                end
            end

            -- Items
            if ConfigStarterPack.Pack[pack]["Reward"].items then 
                for k, v in pairs(ConfigStarterPack.Pack[pack]["Reward"].items) do 
                    xPlayer.addInventoryItem(v.name, v.count)
                end    
            end
       
            if ConfigStarterPack.Pack[pack]["Reward"].cash then 
                xPlayer.addAccountMoney(ConfigStarterPack.Money.cash, ConfigStarterPack.Pack[pack]["Reward"].cash)
            end

            if ConfigStarterPack.Pack[pack]["Reward"].car then 
                Plate = GeneratePlate()
                MySQL.Async.execute("INSERT INTO owned_vehicles (owner, plate, vehicle, type, state) VALUES (@owner, @plate, @vehicle, @type, @state)", {
                    ["@owner"] = xPlayer.identifier,
                    ["@plate"] = Plate,
                    ["@vehicle"] = json.encode({model = GetHashKey(ConfigStarterPack.Pack[pack]["Reward"].car), plate = Plate}),
                    ["@type"] = "car",
                    ["@state"] = 1
                })
                if ConfigStarterPack.KeySystem then 
                    MySQL.Async.execute("INSERT INTO open_car (owner, plate) VALUES (@owner, @plate)", {
                        ["@owner"] = xPlayer.identifier,
                        ["@plate"] = Plate,
                    })
                end
            end
   
            TriggerClientEvent("esx:showNotification", source, ConfigStarterPack.Pack[pack].Notification)
    
            local Content = {
                {
                    ["author"] = {
                        ["name"] = "Ronflex StarterPack",
                        ["icon_url"] = ConfigStarterPack.Logs.Icon,
                    },
                    ["title"] = (ConfigStarterPack.Logs.Content["Title"]):format(pack),
                    ["description"] = (ConfigStarterPack.Logs.Content["Description"]):format(xPlayer.identifier, xPlayer.source),
                    
                    ["color"] = ConfigStarterPack.Logs.Content["Colour"],
                    ["footer"] = {
                        ["text"] = "Ronflex Logs Module",
                    }
                }
            }    
            PerformHttpRequest(ConfigStarterPack.Logs.WebHook, function() end, 'POST', json.encode({username = nil, embeds = Content}), {['Content-Type'] = 'application/json'})
        else

            TriggerClientEvent("esx:showNotification", source, "Vous avez déjà pris votre starterpack !")
        end
    
    else
        DropPlayer(source, ConfigStarterPack.MessageBan)
    end

end)


GeneratePlate = function()
    plate1 = ""
    for i = 1, 6 do 
        plate1 = plate1..''..math.random(0, 9)
    end
    return plate1
end



