ESX = nil
GangLoad = false
Gang = {}

TriggerEvent(ConfigGangBuilder.ESX, function(obj) ESX = obj end)

-- Cache dynamique
CreateThread(function()
    Wait(100)
    MySQL.Async.fetchAll("SELECT * FROM gang", {}, function(result)
    
        for k, v in pairs(result) do 
            infosgang = json.decode(v.infos)
            if not Gang[infosgang.name] then 
                Gang[infosgang.name] = {}
                Gang[infosgang.name].id = tonumber(v.id)
                Gang[infosgang.name].name = infosgang.name
                Gang[infosgang.name].label = infosgang.label
                Gang[infosgang.name].pospatron = json.decode(v.poscoffre)
                Gang[infosgang.name].posgarage = json.decode(v.posgarage)
                Gang[infosgang.name].posgaragedelete = json.decode(v.posgaragedelete)
                Gang[infosgang.name].posgaragespawn = json.decode(v.posgaragespawn)

                Gang[infosgang.name].posvestiaire = json.decode(v.posvestiaire)
                Gang[infosgang.name].blips = json.decode(v.blips)
                Gang[infosgang.name].garage = json.decode(v.garage)
                v.data = json.decode(v.data)
                if v.data ~= nil then 
                    Gang[infosgang.name].data = v.data 
                else
                    Gang[infosgang.name].data = {
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
    Wait(500)
    print("Gang Load avec succès")
    GangLoad = true 
end)

CreateThread(function()
    while not GangLoad do 
        Wait(1)
    end

    while true do 
        Wait(10*60000)

        for k, v in pairs(Gang) do 
            MySQL.Async.execute("UPDATE gang set data=@data, garage=@garage WHERE id=@id", {
                ["@id"] = v.id,
                ["@data"] = json.encode(v.data),
                ["@garage"] = json.encode(v.garage)
            })
        end
    end

end)


function LogsDiscord(Couleur, Titre, Value, Webhook)
    local Content = {
        {
            ["author"] = {
                ["name"] = "Gang Builder",
            },
            ["title"] = Titre,
            ["description"] = Value,
            ["color"] = Couleur,
            ["footer"] = {
                ["text"] = "LS Corps",
            }
        }
    }    
    PerformHttpRequest(Webhook, function() end, 'POST', json.encode({username = nil, embeds = Content}), {['Content-Type'] = 'application/json'})
end



RegisterCommand(ConfigGangBuilder.Command.OpenMenu, function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    if ConfigGangBuilder.GroupAutorize[xPlayer.getGroup()] == true then 
        TriggerClientEvent("ronflex:opengangbuilder", source, Gang)
    else
        print("^4"..xPlayer.identifier.."^0 tente d'ouvir gang builder")
    end
end)

RegisterNetEvent("ronflex:recievegang")
AddEventHandler("ronflex:recievegang", function()
    TriggerClientEvent("ronflex:recievenewgangclientsidee", source, Gang)
end)

RegisterNetEvent("ronflex:recievegangcoffre")
AddEventHandler("ronflex:recievegangcoffre", function(job)
    local xPlayer = ESX.GetPlayerFromId(source)
    if Gang[xPlayer.job2.name].name == job then 
        TriggerClientEvent("ronflex:recievecoffreclientside", source, Gang[xPlayer.job2.name])
    else
        print("Erreur")
    end
end)

RegisterNetEvent("ronflex:creategang")
AddEventHandler("ronflex:creategang", function(infos)
    local  xPlayer = ESX.GetPlayerFromId(source)

    if ConfigGangBuilder.GroupAutorize[xPlayer.getGroup()] == true then 
        if infos.amount then 
            amount =  tonumber(infos.amount)
        else
            amount = 0
        end
        if not Gang[infos.name] then 
            Gang[infos.name] = {}
            Gang[infos.name].id = math.random(000, 999)
            Gang[infos.name].name = infos.name
            Gang[infos.name].label = infos.label
            Gang[infos.name].pospatron = json.decode(infos.pospatron)
            Gang[infos.name].posgarage = json.decode(infos.posgarage)
            Gang[infos.name].posgaragedelete = json.decode(infos.posgaragedelete)
            Gang[infos.name].posgaragespawn = {spawn = infos.posgaragespawn, heading = infos.posgaragespawnheading}

            Gang[infos.name].posvestiaire = json.decode(infos.posvestiaire)
            Gang[infos.name].garage = {}

            Gang[infos.name].data = {
                ["items"] = {},
                ["weapons"] = {},
                ["accounts"] = {
                    cash = 0,
                    dirtycash = amount
                }
            }
            blips = infos.Blips
            Gang[infos.name].blips = blips
            MySQL.Async.execute("INSERT INTO gang (infos, poscoffre, posgarage, posgaragedelete, posvestiaire, posgaragespawn, data, blips, garage) VALUES (@infos, @poscoffre, @posgarage, @posgaragedelete, @posvestiaire, @posgaragespawn, @data, @blips, @garage)", {
                ["@infos"] = json.encode({name = infos.name, label = infos.label}),
                ["@poscoffre"] = infos.pospatron,
                ["@posgaragedelete"] = infos.posgaragedelete,
                ["@posgarage"] = infos.posgarage,
                ["@posvestiaire"] = infos.posvestiaire,
                ["posgaragespawn"] = json.encode({spawn = infos.posgaragespawn, heading = infos.posgaragespawnheading}),
                ["@data"] = json.encode(Gang[infos.name].data),
                ["@blips"] = json.encode({name = blips.name, id = blips.id, colour = blips.colour, scale = blips.scale}),
                ["@garage"] = json.encode(Gang[infos.name].garage)
            })
    
            MySQL.Async.execute("INSERT INTO jobs (name, label, whitelisted) VALUES (@name, @label, @whitelisted)", {
                ["@name"] = infos.name,
                ["@label"] = infos.label,
                ["@whitelisted"] = 1
            })
    
            MySQL.Async.execute("INSERT INTO job_grades (job_name, grade, name, label, salary, skin_male, skin_female) VALUES (@job_name, @grade, @name, @label, @salary, @skin_male, @skin_female)", {
                ["@job_name"] = infos.name,
                ["@grade"] = 0,
                ["@name"] = "recruit",
                ["@label"] = "Recrue",
                ["@salary"] = 0,
                ["@skin_male"] = "{}",
                ["@skin_female"] = "{}",
            })
    
            MySQL.Async.execute("INSERT INTO job_grades (job_name, grade, name, label, salary, skin_male, skin_female) VALUES (@job_name, @grade, @name, @label, @salary, @skin_male, @skin_female)", {
                ["@job_name"] = infos.name,
                ["@grade"] = 1,
                ["@name"] = "membre",
                ["@label"] = "Membre",
                ["@salary"] = 0,
                ["@skin_male"] = "{}",
                ["@skin_female"] = "{}",
            })       
            
            MySQL.Async.execute("INSERT INTO job_grades (job_name, grade, name, label, salary, skin_male, skin_female) VALUES (@job_name, @grade, @name, @label, @salary, @skin_male, @skin_female)", {
                ["@job_name"] = infos.name,
                ["@grade"] = 2,
                ["@name"] = "copatron",
                ["@label"] = "Co Patron",
                ["@salary"] = 0,
                ["@skin_male"] = "{}",
                ["@skin_female"] = "{}",
            })
    
            MySQL.Async.execute("INSERT INTO job_grades (job_name, grade, name, label, salary, skin_male, skin_female) VALUES (@job_name, @grade, @name, @label, @salary, @skin_male, @skin_female)", {
                ["@job_name"] = infos.name,
                ["@grade"] = 3,
                ["@name"] = "boss",
                ["@label"] = "Gérant",
                ["@salary"] = 0,
                ["@skin_male"] = "{}",
                ["@skin_female"] = "{}",
            })
            TriggerClientEvent("ronflex:recievenewgangclientside", -1, Gang)
            TriggerClientEvent(ConfigGangBuilder.PrefixESX.."esx:showNotification", source, "Gang créer avec succès, il sera disponible au reboot")
            if ConfigGangBuilder.Logs.Active then 
                LogsDiscord(3447003, "Nouveau Gang Créer", "Le Staff **"..xPlayer.getName()..'** ('..xPlayer.getGroup()..") à créer le gang **"..infos.label.."**", ConfigGangBuilder.Logs.CreateGang) 
            end
        else
            TriggerClientEvent(ConfigGangBuilder.PrefixESX.."esx:showNotification", source, "Il existe déjà un gang avec ce nom")
            return;
        end

    else
        print("^4"..xPlayer.identifier.."^0 tente de créer un gang via event")
    end
end)


RegisterNetEvent("ronflex:actionsmoneygang")
AddEventHandler("ronflex:actionsmoneygang", function(action, amount, typee, id)
    local xPlayer = ESX.GetPlayerFromId(source)
    local jobplayer = xPlayer.job2.name 
    if Gang[jobplayer].id == tonumber(id) then 
        if action == "remove" then 
            if ConfigGangBuilder.AutorizeRemoveMoney[xPlayer.job2.grade_name] == true then 
                if Gang[jobplayer].data["accounts"][typee] >= tonumber(amount) then 
                    Gang[jobplayer].data["accounts"][typee] = Gang[jobplayer].data["accounts"][typee] - tonumber(amount)
                    TriggerClientEvent("ronflex:recievecoffreclientside", source, Gang[jobplayer])
                    if ConfigGangBuilder.Logs.Active then 
                        LogsDiscord(15158332, "Argent Remove Gang", "Le joueur **"..xPlayer.getName()..'**\nId: **'..source.."**\nLicense: **"..xPlayer.identifier.."**\n à retiré **"..amount.."** ("..typee..") dans le gang **"..Gang[jobplayer].label.."**", ConfigGangBuilder.Logs.DepostiMoney) 
                    end
                    if typee == "cash" then 
                        xPlayer.addAccountMoney("cash", tonumber(amount))
                    else
                        xPlayer.addAccountMoney("dirtycash", tonumber(amount))
                    end
                else
                    TriggerClientEvent(ConfigGangBuilder.PrefixESX.."esx:showNotification", source, "Le gang ne dispose pas de fonds suffisant pour faire cela")
                end

            else
                TriggerClientEvent(ConfigGangBuilder.PrefixESX.."esx:showNotification", source, "Vous ne disposez pas des permissions")
            end
            
        elseif action == "deposit" then
          
            if typee == "cash" then 
                money = xPlayer.getAccount("cash").money
            else
                money = xPlayer.getAccount("dirtycash").money
            end

            if tonumber(money) >= tonumber(amount) then 
                Gang[jobplayer].data["accounts"][typee] = Gang[jobplayer].data["accounts"][typee] + tonumber(amount)
                TriggerClientEvent("ronflex:recievecoffreclientside", source, Gang[jobplayer])
                if typee == "cash" then 
                    xPlayer.removeAccountMoney("cash", tonumber(amount))
                else
                    xPlayer.removeAccountMoney("dirtycash", tonumber(amount))
                end
                if ConfigGangBuilder.Logs.Active then 
                    LogsDiscord(3066993, "Argent Déposer Gang", "Le joueur **"..xPlayer.getName()..'**\nId: **'..source.."**\nLicense: **"..xPlayer.identifier.."**\n à retiré **"..amount.."** ("..typee..") dans le gang **"..Gang[jobplayer].label.."**", ConfigGangBuilder.Logs.RemoveMoney) 
                end
            else
                TriggerClientEvent(ConfigGangBuilder.PrefixESX.."esx:showNotification", source, "Vous n'avez pas les fonds nécéssaire pour faire cela")
            end
        end
    else
        print("Ban")
    end
    
end)


RegisterNetEvent("ronflex:actionitemgang")
AddEventHandler("ronflex:actionitemgang", function(name, amount, action, id)

    local xPlayer = ESX.GetPlayerFromId(source)
    local jobplayer = xPlayer.job2.name 
    InfosItem = xPlayer.getInventoryItem(name)
    if Gang[jobplayer].id == tonumber(id) then 

        if action == "deposit" then 

            if InfosItem.count >= tonumber(amount) then 
                if not Gang[jobplayer].data["items"][InfosItem.name] then 
                    Gang[jobplayer].data["items"][InfosItem.name] = {}
                    Gang[jobplayer].data["items"][InfosItem.name].name = InfosItem.name
                    Gang[jobplayer].data["items"][InfosItem.name].label = InfosItem.label
                    Gang[jobplayer].data["items"][InfosItem.name].count = tonumber(amount)
                else
                    Gang[jobplayer].data["items"][InfosItem.name].count = Gang[jobplayer].data["items"][InfosItem.name].count + tonumber(amount)
                end
                xPlayer.removeInventoryItem(name, amount)
                if ConfigGangBuilder.Logs.Active then 
                    LogsDiscord(3066993, "Items Déposer Gang", "Le joueur **"..xPlayer.getName()..'**\nId: **'..source.."**\nLicense: **"..xPlayer.identifier.."**\n à déposer **"..InfosItem.label.."** (x"..amount..") dans le gang **"..Gang[jobplayer].label.."**", ConfigGangBuilder.Logs.DepositItem) 
                end
                TriggerClientEvent(ConfigGangBuilder.PrefixESX.."esx:showNotification", source, "Vous avez déposer ~b~x"..amount.." "..Gang[jobplayer].data["items"][InfosItem.name].label.."~s~ dans le coffre de votre gang")
                TriggerClientEvent("ronflex:recievecoffreclientside", source, Gang[jobplayer])
            else
                TriggerClientEvent(ConfigGangBuilder.PrefixESX.."esx:showNotification", source, "Vous ne disposez pas de suffisament de "..InfosItem.label.." pour faire cela")
            end
    
        elseif action == "remove" then 
    
            if Gang[jobplayer].data["items"][name] then 
                if Gang[jobplayer].data["items"][name].count >= tonumber(amount) then 
                    Gang[jobplayer].data["items"][name].count = Gang[jobplayer].data["items"][name].count - tonumber(amount)
                    TriggerClientEvent(ConfigGangBuilder.PrefixESX.."esx:showNotification", source, "Vous avez retirez ~b~x"..amount.." "..Gang[jobplayer].data["items"][name].label.."~s~ dans le coffre de votre gang")
                    if Gang[jobplayer].data["items"][name].count == 0 then 
                        Gang[jobplayer].data["items"][name] = nil 
                    end
                    if ConfigGangBuilder.Logs.Active then 
                        LogsDiscord(15158332, "Items Retiré Gang", "Le joueur **"..xPlayer.getName()..'**\nId: **'..source.."**\nLicense: **"..xPlayer.identifier.."**\n à retirer **"..InfosItem.label.."** (x"..amount..") dans le gang **"..Gang[jobplayer].label.."**", ConfigGangBuilder.Logs.RemoveItem) 
                    end
                    xPlayer.addInventoryItem(name, amount)
                    TriggerClientEvent("ronflex:recievecoffreclientside", source, Gang[jobplayer])
                else
                    TriggerClientEvent(ConfigGangBuilder.PrefixESX.."esx:showNotification", source, "Action impossible")
                end
    
            else
                TriggerClientEvent(ConfigGangBuilder.PrefixESX.."esx:showNotification", source, "Cet item n'existe plus")
            end
    
        end
    else
        print("Ban")
    end
end)


RegisterNetEvent("ronflex:actionweapongang")
AddEventHandler("ronflex:actionweapongang", function(name, action, label, ammo, id)

    local xPlayer = ESX.GetPlayerFromId(source)
    local jobplayer = xPlayer.job2.name 
    InfosWeapon = xPlayer.getWeapon(name)
    if Gang[jobplayer].id == tonumber(id) then 
        if action == "deposit" then 
            if InfosWeapon >= 1 then
                if not Gang[jobplayer].data["weapons"][name] then 
                    Gang[jobplayer].data["weapons"][name] = {}
                    Gang[jobplayer].data["weapons"][name].label = label
                    Gang[jobplayer].data["weapons"][name].name = name 
                    Gang[jobplayer].data["weapons"][name].ammo = ammo 
                    Gang[jobplayer].data["weapons"][name].count = 1                 
                else
                    Gang[jobplayer].data["weapons"][name].count = Gang[jobplayer].data["weapons"][name].count +1
                end
                if ConfigGangBuilder.Logs.Active then 
                    LogsDiscord(3066993, "Arme Déposer Gang", "Le joueur **"..xPlayer.getName()..'**\nId: **'..source.."**\nLicense: **"..xPlayer.identifier.."**\n à déposer **"..label.."** dans le gang **"..Gang[jobplayer].label.."**", ConfigGangBuilder.Logs.DepositArmes) 
                end
                xPlayer.removeWeapon(name)
                TriggerClientEvent("ronflex:recievecoffreclientside", source, Gang[jobplayer])
            else
                TriggerClientEvent(ConfigGangBuilder.PrefixESX.."esx:showNotification", source, "Action impossible")
            end
    
        elseif action == "remove" then 
    
            if Gang[jobplayer].data["weapons"][name] then 
                if Gang[jobplayer].data["weapons"][name].count >= tonumber(1) then 
                    Gang[jobplayer].data["weapons"][name].count = Gang[jobplayer].data["weapons"][name].count -1
                    xPlayer.addWeapon(Gang[jobplayer].data["weapons"][name].name, Gang[jobplayer].data["weapons"][name].ammo)
                    if ConfigGangBuilder.Logs.Active then 
                        LogsDiscord(15158332, "Arme Déposer Gang", "Le joueur **"..xPlayer.getName()..'**\nId: **'..source.."**\nLicense: **"..xPlayer.identifier.."**\n à retirer **"..Gang[jobplayer].data["weapons"][name].label.."** dans le gang **"..Gang[jobplayer].label.."**", ConfigGangBuilder.Logs.RemoveArmes) 
                    end
                    if  Gang[jobplayer].data["weapons"][name].count == 0 then 
                        Gang[jobplayer].data["weapons"][name] = nil
                    end
                  
                    TriggerClientEvent("ronflex:recievecoffreclientside", source, Gang[jobplayer])
                else
                    return
                end
    
            else
                TriggerClientEvent(ConfigGangBuilder.PrefixESX.."esx:showNotification", source, "Cet arme n'existe plus")
            end
        end


    else
        print("ban")
    end

end)


RegisterNetEvent("ronflex:addnewvehiculetogaragegangzebi")
AddEventHandler("ronflex:addnewvehiculetogaragegangzebi", function(props)

    local xPlayer = ESX.GetPlayerFromId(source)

    if not Gang[xPlayer.job2.name].garage[props.plate] then 
        Gang[xPlayer.job2.name].garage[props.plate] = {}
        Gang[xPlayer.job2.name].garage[props.plate].plate = props.plate
        Gang[xPlayer.job2.name].garage[props.plate].props = props
    end
end)


RegisterNetEvent("ronflex:deletevehiculegangfromgaragezebi")
AddEventHandler("ronflex:deletevehiculegangfromgaragezebi", function(plate)

    local xPlayer = ESX.GetPlayerFromId(source)
    if Gang[xPlayer.job2.name].garage[plate] then 
        Gang[xPlayer.job2.name].garage[plate] = nil
        TriggerClientEvent(ConfigGangBuilder.PrefixESX.."esx:showNotification", source, "Vous venez de sortir votre ")
    else
        print("Ban")
    end
end)


RegisterNetEvent("ronflex:actionsgangmodif")
AddEventHandler("ronflex:actionsgangmodif", function(action, gang, args)

    local xPlayer = ESX.GetPlayerFromId(source)
    
    if xPlayer.getGroup() ~= "user" then 

        if action == "tpvestiaire" then 
            SetEntityCoords(GetPlayerPed(xPlayer.source), Gang[gang].posvestiaire.x, Gang[gang].posvestiaire.y, Gang[gang].posvestiaire.z)
            TriggerClientEvent(ConfigGangBuilder.PrefixESX.."esx:showNotification", source, "Téléportation réussie ")
        elseif action == "tpcoffre" then 
            SetEntityCoords(GetPlayerPed(xPlayer.source), Gang[gang].pospatron.x, Gang[gang].pospatron.y, Gang[gang].pospatron.z)
            TriggerClientEvent(ConfigGangBuilder.PrefixESX.."esx:showNotification", source, "Téléportation réussie ")
        elseif action == "tpgarage" then 
            SetEntityCoords(GetPlayerPed(xPlayer.source), Gang[gang].posgarage.x, Gang[gang].posgarage.y, Gang[gang].posgarage.z)
            TriggerClientEvent(ConfigGangBuilder.PrefixESX.."esx:showNotification", source, "Téléportation réussie ")
        elseif action == "modifposcoffre" then 
            Gang[gang].pospatron = GetEntityCoords(GetPlayerPed(source))
            TriggerClientEvent("ronflex:recievenewgangclientside", source, Gang)
            TriggerClientEvent(ConfigGangBuilder.PrefixESX.."esx:showNotification", source, "La postion du coffre à été modifiée")
            SaveGang(gang)
        elseif action == 'modifposvestiaire' then 
            Gang[gang].posvestiaire = GetEntityCoords(GetPlayerPed(source))
            TriggerClientEvent("ronflex:recievenewgangclientside", source, Gang)
            SaveGang(gang)
            TriggerClientEvent(ConfigGangBuilder.PrefixESX.."esx:showNotification", source, "La postion des vestiaire ont été modifiée")

        elseif action == "modifposgarage" then 
            Gang[gang].posgarage = GetEntityCoords(GetPlayerPed(source))
            SaveGang(gang)
            TriggerClientEvent("ronflex:recievenewgangclientside", source, Gang)
        elseif action == "modifposgaragedelete" then 
            Gang[gang].posgaragedelete = GetEntityCoords(GetPlayerPed(source))
            SaveGang(gang)
            TriggerClientEvent("ronflex:recievenewgangclientside", source, Gang)
        elseif action == "modifspriteblips" then 
            Gang[gang].blips.id = args
            SaveGang(gang)
            TriggerClientEvent("ronflex:recievenewgangclientside", source, Gang)

        elseif action == "delete" then 
            MySQL.Async.execute("DELETE FROM gang WHERE id=@id", {
                ["@id"] = Gang[gang].id
            })
            Gang[gang] = nil 
            TriggerClientEvent(ConfigGangBuilder.PrefixESX.."esx:showNotification", source, "Votre gang sera supprimé au reboot")
            TriggerClientEvent("ronflex:recievenewgangclientside", source, Gang)
        end 
    end
end)


RegisterNetEvent("ronflex:paidvehiculecustom")
AddEventHandler("ronflex:paidvehiculecustom", function()

    local xPlayer = ESX.GetPlayerFromId(source)

    -- if xPlayer.getAccount("cash").money >= tonumber(Garage.Price) then 
        xPlayer.removeAccountMoney('cash', Garage.Price)
    -- end

end)

function SaveGang(gang)
    MySQL.Async.execute("UPDATE gang set poscoffre=@poscoffre, posgarage=@posgarage, posvestiaire=@posvestiaire, posgaragedelete=@posgaragedelete, blips=@blips", {
        ["@poscoffre"] = json.encode(Gang[gang].pospatron),
        ["@posgarage"] = json.encode(Gang[gang].posgarage),
        ["@posvestiaire"] = json.encode(Gang[gang].posvestiaire),
        ["@posgaragedelete"] = json.encode(Gang[gang].posgaragedelete),
        ["@blips"] = json.encode(Gang[gang].blips)
    })
    print("GANG SAVE")
end


ESX.RegisterServerCallback("ronflex:getvehiclegarage", function(source, cb, job)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.job2.name == job then 
        cb(Gang[xPlayer.job2.name].garage, Gang[xPlayer.job2.name].posgaragespawn)
    end
end)


ESX.RegisterServerCallback("ronflex:getplayeradata", function(source, cb, player)

    local xPlayer = ESX.GetPlayerFromId(source)
    local tPlayer = ESX.GetPlayerFromId(player)

    data = {
        weapon = tPlayer.getLoadout(),
        item = tPlayer.getInventory(true)
    }
    cb(data)
end)


RegisterNetEvent("ronflex:derobeitem")
AddEventHandler("ronflex:derobeitem", function(name, quantity, player)

    local xPlayer = ESX.GetPlayerFromId(source)
    local tPlayer = ESX.GetPlayerFromId(player)

    if #(GetEntityCoords(GetPlayerPed(source)) - GetEntityCoords(GetPlayerPed(player))) < 5 then 
        local item = tPlayer.getInventoryItem(name)
        if tonumber(item.count) >= tonumber(quantity) then 
            print(quantity)
            tPlayer.removeInventoryItem(item.name, tonumber(quantity))
            xPlayer.addInventoryItem(item.name, tonumber(quantity))
            TriggerClientEvent(ConfigGangBuilder.PrefixESX.."esx:showNotification", source, "Vous venez de confisquer x"..quantity.." de "..item.label)
            TriggerClientEvent(ConfigGangBuilder.PrefixESX.."esx:showNotification", tPlayer.source, "Vous venez de vous faire dérober x"..quantity.." de "..item.label)
        else
            print("ban")
        end
    else
        TriggerClientEvent(ConfigGangBuilder.PrefixESX.."esx:showNotification", source, "Vous être trop loin !")
    end

end)

RegisterNetEvent("ronflex:derobeweapon")
AddEventHandler("ronflex:derobeweapon", function(name, player, label)
    local xPlayer = ESX.GetPlayerFromId(source)
    local tPlayer = ESX.GetPlayerFromId(player)

    if #(GetEntityCoords(GetPlayerPed(source)) - GetEntityCoords(GetPlayerPed(player))) < 5 then 
        local weapon = tPlayer.hasWeapon(name)
        if weapon then 
            xPlayer.addWeapon(name, 200)
            tPlayer.removeWeapon(name)
            TriggerClientEvent(ConfigGangBuilder.PrefixESX.."esx:showNotification", source, "Vous venez de confisquer un "..label.."")
            TriggerClientEvent(ConfigGangBuilder.PrefixESX.."esx:showNotification", tPlayer.source, "Vous venez de vous faire dérober un "..label.." ")
        else
            print("ban")
        end
    else
        TriggerClientEvent(ConfigGangBuilder.PrefixESX.."esx:showNotification", source, "Vous être trop loin !")
    end

end)

RegisterNetEvent("ronflex:poutinvehicule", function(target)
	local xPlayerTarget = ESX.GetPlayerFromId(target)

	if xPlayerTarget ~= nil then
		TriggerClientEvent("ronflex:poutinvehicule", target)
	end
end)

RegisterNetEvent("ronflex:exitfromveh", function(target)
	local xPlayerTarget = ESX.GetPlayerFromId(target)

	if xPlayerTarget ~= nil then
		TriggerClientEvent("ronflex:exitfromveh", target)
	end
end)



RegisterNetEvent("ronflex:cagouleplayer")
AddEventHandler("ronflex:cagouleplayer", function(player)

    local xPlayer = ESX.GetPlayerFromId(source)

    if #(GetEntityCoords(GetPlayerPed(source)) - GetEntityCoords(GetPlayerPed(player))) < 20 then 
        TriggerClientEvent('ronflex:cagouleplayer', player)
        TriggerClientEvent(ConfigGangBuilder.PrefixESX.."esx:showNotification", player, "Vous avez été cagoulé")
    else
        print('ban')
    end

end)


RegisterServerEvent('ronflex:menoteplayer')
AddEventHandler('ronflex:menoteplayer', function(target, wannacuff, method)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xPlayerTarget = ESX.GetPlayerFromId(target)

	if wannacuff then
        TriggerClientEvent('krz_handcuff:arresting', xPlayer.source)
        TriggerClientEvent('ronflex:menoterclient', target, true, xPlayer.source)
	elseif not wannacuff then
        TriggerClientEvent('ronflex:menoterclient', target, false)
	end
end)