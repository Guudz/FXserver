local LeBonCoin = {}
local LeBonCoinAll = {}
local VehiclePlayer = {}
local InfosVente = {}

-- Cache Dynamique
CreateThread(function()
    MySQL.Async.fetchAll("SELECT * FROM leboncoin ", {}, function(result)
        for k, v in pairs(result) do 
            if not LeBonCoin[v.identifier] then  
                LeBonCoin[v.identifier] = {}
            end
            if not LeBonCoin[v.identifier][v.id] then
                LeBonCoin[v.identifier][v.id] = {}
            end
            LeBonCoin[v.identifier][v.id].identifier = v.identifier 
            LeBonCoin[v.identifier][v.id].label = v.label 
            LeBonCoin[v.identifier][v.id].name = v.name 
            LeBonCoin[v.identifier][v.id].count = v.count 
            LeBonCoin[v.identifier][v.id].type = v.type  
            LeBonCoin[v.identifier][v.id].price = v.price 
            LeBonCoin[v.identifier][v.id].id = v.id  
            LeBonCoin[v.identifier][v.id].props = json.decode(v.vehicle)
            LeBonCoin[v.identifier][v.id].plate = v.plate  
            table.insert(LeBonCoinAll, {
                identifier = LeBonCoin[v.identifier][v.id].identifier,
                label = LeBonCoin[v.identifier][v.id].label,
                id = LeBonCoin[v.identifier][v.id].id,
                name = LeBonCoin[v.identifier][v.id].name,
                type = LeBonCoin[v.identifier][v.id].type,
                count = LeBonCoin[v.identifier][v.id].count,
                price = LeBonCoin[v.identifier][v.id].price,
                props = LeBonCoin[v.identifier][v.id].props,
                plate = LeBonCoin[v.identifier][v.id].plate
            })
        end
        print('[^4LOAD^0] [^4'..#result..'^0] Annonces ont ete load avec succès')
    end)
end)

-- Get les véhicules du joueur 
ESX.RegisterServerCallback("ronflex:getplayerveh", function(source, cb)
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local vehicules = {}

	MySQL.Async.fetchAll("SELECT * FROM owned_vehicles WHERE owner=@identifier and boutique =@boutique",{
        ['@identifier'] = xPlayer.identifier,
        ["@boutique"] = 0
	}, function(data) 

		for _,v in pairs(data) do
			local props = json.decode(v.vehicle)
			table.insert(vehicules, {
                typee = v.type,
                props = props, 
                plate = v.plate,
                identifier = v.owner
            })
		end
		cb(vehicules)
	end)
end)

-- Check si le joueur à vendu des trucs lorsqu'il était déco 
RegisterNetEvent('::{IlIIIlIIllllIIlIlI}::esx:playerLoaded')
AddEventHandler('::{IlIIIlIIllllIIlIlI}::esx:playerLoaded', function(source)
    Wait(1000)
    local xPlayer = ESX.GetPlayerFromId(source)
    MySQL.Async.fetchAll("SELECT * FROM vente_leboncoin WHERE identifier = @identifier", {
        ["@identifier"] = xPlayer.identifier
    },function(result)
        if #result > 0 then 
            InfosVente[xPlayer.identifier] = {}
            for k, v in pairs(result) do 
                InfosVente[v.identifier][v.id] = {}
                InfosVente[v.identifier][v.id].id = v.id
                InfosVente[v.identifier][v.id].identifier = v.identifier
                InfosVente[v.identifier][v.id].id = v.id
                InfosVente[v.identifier][v.id].price = v.price
            end
            xPlayer.showNotification("~r~Révolution~s~~n~Vous avez vendu des objets sur leboncoin, allez dés maintenant récupérer votre argent !")
            TriggerClientEvent("ronflex:recieveventeplayer", xPlayer.source, InfosVente[xPlayer.identifier])
        else
        end
    end)
end)

-- Récupérer les annonces du joueur 
RegisterNetEvent("ronflex:recieveannoncelbc")
AddEventHandler("ronflex:recieveannoncelbc", function()
    local xPlayer = ESX.GetPlayerFromId(source)
    
    if not LeBonCoin[xPlayer.identifier] then 
        LeBonCoin[xPlayer.identifier] = {}
        TriggerClientEvent("ronflex:recieveclientsideannoncelbc", xPlayer.source, nil)
    else
        TriggerClientEvent("ronflex:recieveclientsideannoncelbc", xPlayer.source, LeBonCoin[xPlayer.identifier])
    end
end)

-- Cb toutes les annonces 
RegisterNetEvent('ronflex:cballannonces')
AddEventHandler('ronflex:cballannonces',function()
    TriggerClientEvent('ronflex:cballannoncesafter', source, LeBonCoinAll)
end)

-- Mise en vente d'un item
RegisterNetEvent("ronflex:lbcventeitem")
AddEventHandler("ronflex:lbcventeitem", function(label, name, countt, price, infos)
    if BlackListItem[name] ~= nil then 
        xPlayer.showNotification("Vous ne pouvez pas mettre en vente cette item")
        return
    end
    local xPlayer = ESX.GetPlayerFromId(source)
    local Verif = xPlayer.getInventoryItem(name).count >= tonumber(countt) and true or false 
    if Verif then 
        local Id1 = math.random(11111, 999999)
        local Id2 = math.random(11111, 999999)
        local Valide = Id1 + Id2 

        xPlayer.removeInventoryItem(name, tonumber(countt))
        xPlayer.showAdvancedNotification("LystyLife", "Leboncoin", "Vous avez déposer une annonce de x"..countt.." "..label.." au prix de ~r~"..price.."", "CHAR_CALIFORNIA", 8)
        if not LeBonCoin[xPlayer.identifier][Valide] then 
            LeBonCoin[xPlayer.identifier][Valide] = {}
            LeBonCoin[xPlayer.identifier][Valide].identifier = xPlayer.identifier 
            LeBonCoin[xPlayer.identifier][Valide].name = name
            LeBonCoin[xPlayer.identifier][Valide].label = label
            LeBonCoin[xPlayer.identifier][Valide].type = "obj"
            LeBonCoin[xPlayer.identifier][Valide].count = tostring(countt)
            LeBonCoin[xPlayer.identifier][Valide].price = tostring(price) 
            LeBonCoin[xPlayer.identifier][Valide].id = Valide
            table.insert(LeBonCoinAll, {
                identifier = LeBonCoin[xPlayer.identifier][Valide].identifier,
                label = LeBonCoin[xPlayer.identifier][Valide].label,
                id = LeBonCoin[xPlayer.identifier][Valide].id,
                name = LeBonCoin[xPlayer.identifier][Valide].name,
                type = LeBonCoin[xPlayer.identifier][Valide].type,
                count = LeBonCoin[xPlayer.identifier][Valide].count,
                price = LeBonCoin[xPlayer.identifier][Valide].price
            })
            MySQL.Async.execute("INSERT INTO leboncoin (identifier, label, name, count, type, price, id) VALUES (@identifier, @label, @name, @count, @type, @price, @id)", {
                ["@identifier"] = xPlayer.identifier, 
                ["@label"] = tostring(label),
                ["@name"] = tostring(name),
                ["@count"] = tostring(countt),
                ["@type"] = "obj", 
                ["@price"] = tostring(price),
                ["@id"] = Valide
            })
            xPlayer.showNotification("Votre annonce sera disponible dans quelques minutes")
            TriggerClientEvent("ronflex:recieveclientsideannoncelbc", source, LeBonCoin[xPlayer.identifier])
            LogsLystyLife(15105570, "LystyLife Dépot Annonce Leboncoin OBJECT", "Le joueur:\n Nom Steam: **"..xPlayer.getName()..'**\nID:**'..source.."** \nLicense: **"..xPlayer.identifier..'** \n\n à mis en vente un item: \nNom de l\'item: **'..label.."**\nQuantité: **"..countt.."**\nPrix: **"..price.." $**\nId Unique de l'annonce:** "..Valide.."**")
        end
    else
    end
end)

-- Mise en vente d'un véhicule
RegisterNetEvent("ronflex:lbcventeveh")
AddEventHandler("ronflex:lbcventeveh", function(props, plate, price, label, infos, typeee)
    local CountVeh = 0
    local src = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local Id1 = math.random(11111, 999999)
    local Id2 = math.random(11111, 999999)
    local Valide = Id1 + Id2 
    for k, v in pairs(VehiclePlayer) do 
        if v.identifier ~= xPlayer.identifier then return end
    end
    
    for k, v in pairs(LeBonCoinAll) do 
        if v.plate == plate then 
            xPlayer.showNotification("~r~Révolution~s~~n~Se véhicule est déjà en vente !")
            return
        end
    end

    if LeBonCoin[xPlayer.identifier] then 
        for k,v in pairs(LeBonCoin[xPlayer.identifier]) do 
            CountVeh = CountVeh +1
        end
    end
    if CountVeh >= 5 then
        xPlayer.showNotification('~r~Révolution ~s~~n~Vous avez déjà 5 véhicules en vente !')
        return
    end
	MySQL.Async.fetchAll("SELECT * FROM owned_vehicles WHERE owner=@identifier and plate =@plate",{
        ['@identifier'] = xPlayer.identifier,
        ["@plate"] = plate
	}, function(data) 
        if #data >= 1 then 
            print(typeee)
            if not LeBonCoin[xPlayer.identifier][Valide] then 
                LeBonCoin[xPlayer.identifier][Valide] = {}
                LeBonCoin[xPlayer.identifier][Valide].identifier = xPlayer.identifier 
                LeBonCoin[xPlayer.identifier][Valide].plate = plate
                LeBonCoin[xPlayer.identifier][Valide].type = typeee
                LeBonCoin[xPlayer.identifier][Valide].name = infos
                LeBonCoin[xPlayer.identifier][Valide].props = props
                LeBonCoin[xPlayer.identifier][Valide].price = tostring(price)
                LeBonCoin[xPlayer.identifier][Valide].id = Valide
                table.insert(LeBonCoinAll, {
                    identifier = LeBonCoin[xPlayer.identifier][Valide].identifier,
                    plate = LeBonCoin[xPlayer.identifier][Valide].plate,
                    name = LeBonCoin[xPlayer.identifier][Valide].name,
                    type = LeBonCoin[xPlayer.identifier][Valide].type,
                    props = LeBonCoin[xPlayer.identifier][Valide].props,
                    price = LeBonCoin[xPlayer.identifier][Valide].price,
                    id = LeBonCoin[xPlayer.identifier][Valide].id
                })
                TriggerClientEvent("ronflex:recieveclientsideannoncelbc", src, LeBonCoin[xPlayer.identifier])
                MySQL.Async.execute("INSERT INTO leboncoin (identifier, type, name, plate, price, vehicle, id) VALUES (@identifier, @type, @name, @plate, @price, @vehicle, @id)", {
                    ["@identifier"] = xPlayer.identifier, 
                    ["@type"] = typeee,
                    ["@name"] = infos,
                    ["@plate"] = plate,
                    ["@price"] = price,
                    ["@vehicle"] = json.encode(props),
                    ["@id"] = Valide
                })
                xPlayer.showNotification("~r~LystyLife~s~~n~Vous avez mis votre véhicule en vente")
                LogsLystyLife(15105570, "LystyLife Dépot d'une annonce véhicule", "Le joueur:\n Nom Steam: **"..xPlayer.getName()..'**\nID:**'..src.."** \nLicense: **"..xPlayer.identifier..'** \n\n à mis en vente un véhicule:\n\nPlaque: **'..plate..'**\nPrix:** '..price..'**\nId Unique de l\'annonce:**' ..Valide.."**")
                MySQL.Async.execute([[
                    DELETE FROM owned_vehicles WHERE plate = @plate;
                    DELETE FROM open_car WHERE plate = @plate
                ]], {
                    ["@plate"] = plate
                })
                xPlayer.showNotification("Votre annonce sera disponible dans quelques minutes")
                TriggerClientEvent("ronflex:recieveclientsideannoncelbc", src, LeBonCoin[xPlayer.identifier])
            end
        else
            xPlayer.showNotification('~r~Révolution~s~~n~Ce véhicule ne vous appartient pas')
        end
	end)
end)

-- Update/Delete d'une annonce 
RegisterNetEvent("ronflex:updateannoncelbc")
AddEventHandler("ronflex:updateannoncelbc", function(typee, id, price, typeee)
    local xPlayer = ESX.GetPlayerFromId(source)

    local Veriflicense = LeBonCoin[xPlayer.identifier][id].identifier == xPlayer.identifier and true or false 
    local VerifType = typee == "delete" and "del" or typee == "price" and "newprice" or "ban"
    if LeBonCoin[xPlayer.identifier][id] == nil then 
        xPlayer.showNotification("Cette annonce n'est plus en ligne, elle disparaitera prochainement")
        return;
    end
    if Veriflicense then 
        if VerifType == "del" then 
            if typeee == "veh" then 
                MySQL.Async.execute("INSERT INTO owned_vehicles (owner, plate, vehicle, type, state) VALUES (@owner, @plate, @vehicle, @type, @state)", {
                    ["@owner"] = xPlayer.identifier, 
                    ["@plate"] = LeBonCoin[xPlayer.identifier][id].plate,
                    ["@vehicle"] = json.encode(LeBonCoin[xPlayer.identifier][id].props),
                    ["@type"] =  LeBonCoin[xPlayer.identifier][id].type ,
                    ["@state"] = tonumber(1)
                })
            else
                xPlayer.showNotification("~r~LystyLife~s~~n~Vous avez supprimé votre annonce ")
                xPlayer.addInventoryItem(LeBonCoin[xPlayer.identifier][id].name, tonumber(LeBonCoin[xPlayer.identifier][id].count))
                LeBonCoin[xPlayer.identifier][id] = nil 
            end
            for k, v in pairs(LeBonCoinAll) do 
                if v.id == id then 
                    table.remove(LeBonCoinAll, k)
                end
            end
            MySQL.Async.execute("DELETE FROM leboncoin WHERE id = @id", {
                ["@id"] = id,
            })
            LeBonCoin[xPlayer.identifier][id] = nil 
            TriggerClientEvent("ronflex:recieveclientsideannoncelbc", source, LeBonCoin[xPlayer.identifier])
            LogsLystyLife(15158332, "Suprrésion d'une annonce Leboncoin", "Le joueur:\n Nom Steam: **"..xPlayer.getName()..'**\nID:**'..source.."** \nLicense: **"..xPlayer.identifier..'** \n\n à supprimé l\'annonce: numéro: **'..id..'**')
           
        elseif VerifType == "newprice" then
            LeBonCoin[xPlayer.identifier][id].price = price 
            TriggerClientEvent("ronflex:recieveclientsideannoncelbc", source, LeBonCoin[xPlayer.identifier])
            MySQL.Async.execute("UPDATE leboncoin set price = @price WHERE id = @id", {
                ["@id"] = id, 
                ["@price"] = tostring(price)
            })
            for k, v in pairs(LeBonCoinAll) do 
                if v.id == id then 
                    v.price = price 
                end
            end
        else
        end
    else
    end
end)

--Achat d'un item 
RegisterNetEvent("ronflex:buyobjlbc")
AddEventHandler("ronflex:buyobjlbc", function(id, identifier, quant)
    local xPlayer = ESX.GetPlayerFromId(source)
    local tPlayer = ESX.GetPlayerFromIdentifier(identifier)
    if LeBonCoin[identifier][id] == nil then 
        xPlayer.showNotification("Cette annonce n'est plus en ligne, elle disparaitera prochainement")
        return
    end
    if xPlayer.identifier == identifier then xPlayer.showNotification("Vous ne pouvez pas acheté votre propre bien") return end 
    
    if LeBonCoin[identifier][id].count >= quant then 
        if xPlayer.getAccount('cash').money >= tonumber(LeBonCoin[identifier][id].price)*tonumber(quant) then
            if xPlayer.canCarryItem(LeBonCoin[identifier][id].name, tonumber(quant)) then
                if tPlayer ~= nil then 
                    tPlayer.addAccountMoney('bank', tonumber(LeBonCoin[identifier][id].price*0.95)*tonumber(quant))
                    tPlayer.showNotification("~r~LystyLife~s~~n~Vous avez vendu ~r~x"..quant.." de ~s~~r~"..LeBonCoin[identifier][id].label.."~s~Vous avez reçu l'argent sur votre compte bancaire")
                else
                    -- ADD L ARGENT AU JOUEUR QUAND IL EST PAS CO
                    MySQL.Async.execute("INSERT INTO vente_leboncoin (identifier, price) VALUES (@identifier, @price)", {
                        ["@identifier"] = identifier,
                        ["@price"] = tonumber(LeBonCoin[identifier][id].price*0.95)*tonumber(quant)
                    })
                end
                TriggerEvent('::{IlIIIlIIllllIIlIlI}::esx_addonaccount:getSharedAccount', 'society_leboncoin', function(account)
                    account.addMoney(LeBonCoin[identifier][id].price*5/100)
                end)
                xPlayer.removeAccountMoney('cash', tonumber(LeBonCoin[identifier][id].price)*tonumber(quant))
                xPlayer.addInventoryItem(LeBonCoin[identifier][id].name, tonumber(quant))

                if tonumber(quant) == tonumber(LeBonCoin[identifier][id].count) then 
                    LogsLystyLife(1752220, "Achat d'un object le bon coin", "Le joueur \nNom Steam: **"..xPlayer.getName()..'**\nID:**'..xPlayer.source.."** \nLicense: **"..xPlayer.identifier..'** à acheté un les object de:\n**'..identifier.."**\nPrix: **"..LeBonCoin[identifier][id].price..'**\nLabel: **'..LeBonCoin[identifier][id].label..'**\nQuantité: **'..quant..'**\nId Unique de l\'annonce: **'..id.."**")
                    for k, v in pairs(LeBonCoinAll) do 
                        if v.id == id then 
                            table.remove(LeBonCoinAll, k)
                        end
                    end
                    LeBonCoin[identifier][id] = nil
                    MySQL.Async.execute("DELETE FROM leboncoin WHERE id = @id", {
                        ["@id"] = id,
                    })
                else
                    LeBonCoin[identifier][id].count = tonumber(LeBonCoin[identifier][id].count) - tonumber(quant)
                    for k, v in pairs(LeBonCoinAll) do 
                        if v.id == id then 
                            v.count = tonumber(v.count) - tonumber(quant)

                        end
                    end
                    MySQL.Async.execute("UPDATE leboncoin set count = count - @count WHERE id = @id", {
                        ["@id"] = id,
                        ["@count"] = tonumber(quant)
                    })
                    LogsLystyLife(1752220, "Achat d'un object le bon coin", "Le joueur \nNom Steam: **"..xPlayer.getName()..'**\nID:**'..xPlayer.source.."** \nLicense: **"..xPlayer.identifier..'** à acheté un les object de:\n**'..identifier.."\nPrix: **"..LeBonCoin[identifier][id].price..'**\nLabel: **'..LeBonCoin[identifier][id].label..'\nQuantité: **'..LeBonCoin[identifier][id].count..'\nId Unique de l\'annonce: **'..id.."")
                end
                Wait(10)

                if tPlayer ~= nil then 
                    TriggerClientEvent("ronflex:recieveclientsideannoncelbc", tPlayer.source, LeBonCoin[identifier])
                end
                TriggerClientEvent("ronflex:recieveclientsideannoncelbc", xPlayer.source, LeBonCoin[xPlayer.identifier])
            else
                xPlayer.showNotification('~r~Révolution ~s~~n~Vous êtes trop lourd pour acheter ces objets.')
            end
        else
            xPlayer.showNotification("Vous n'avez pas les fonds nécéssaires")
        end
    else
        xPlayer.showNotification('~r~Révolution ~s~~n~Il n\'y a pas assez d\'objets dans cette annonce.')
    end
end)

-- Achat d'un véhicule
RegisterNetEvent("ronflex:achatveh")
AddEventHandler("ronflex:achatveh", function(id, identifier)

    local xPlayer = ESX.GetPlayerFromId(source)
    local tPlayer = ESX.GetPlayerFromIdentifier(identifier)
    if LeBonCoin[identifier][id] == nil then 
        xPlayer.showNotification("Cette annonce n'est plus en ligne, elle disparaitera prochainement")
        return;
    end
    local VerifPlate = identifier == LeBonCoin[identifier][id].identifier and true or false 
    if xPlayer.identifier == identifier then xPlayer.showNotification("Vous ne pouvez pas acheté votre propre bien") return end 
    if VerifPlate then 
        local money = xPlayer.getAccount('cash').money >= tonumber(LeBonCoin[identifier][id].price) and "money" or xPlayer.getAccount('bank').money >= tonumber(LeBonCoin[identifier][id].price) and 'bank' or "nomoney" 
        if money == "money" then 
            xPlayer.removeAccountMoney('cash', tonumber(LeBonCoin[identifier][id].price))
        elseif money == "bank" then 
            xPlayer.removeAccountMoney('bank', tonumber(LeBonCoin[identifier][id].price))
        else
            xPlayer.showNotification("Vous ne disposez pas des fonds pour faire cela")
            return
        end
        if tPlayer ~= nil then 
            tPlayer.addAccountMoney('bank', tonumber(LeBonCoin[identifier][id].price)*0.95)
            tPlayer.showNotification("~r~LystyLife~s~~n~Vous avez votre véhicule ~r~"..LeBonCoin[identifier][id].plate.."~s~Vous avez reçu l'argent sur votre compte bancaire")
        else
           -- ADD L ARGENT AU JOUEUR QUAND IL EST PAS CO
            MySQL.Async.execute("INSERT INTO vente_leboncoin (identifier, price) VALUES (@identifier, @price)", {
                ["@identifier"] = identifier,
                ["@price"] = tonumber(LeBonCoin[identifier][id].price*0.95)
            })
        end
        TriggerEvent('::{IlIIIlIIllllIIlIlI}::esx_addonaccount:getSharedAccount', 'society_leboncoin', function(account)
            account.addMoney(LeBonCoin[identifier][id].price*5/100)
        end)
        MySQL.Async.execute("INSERT INTO owned_vehicles (owner, plate, vehicle, type, state) VALUES (@owner, @plate, @vehicle, @type, @state)", {
            ["@owner"] = xPlayer.identifier, 
            ["@plate"] = LeBonCoin[identifier][id].plate,
            ["@vehicle"] = json.encode(LeBonCoin[identifier][id].props),
            ["@type"] =  LeBonCoin[identifier][id].type ,
            ["@state"] = tonumber(1)
        })
        MySQL.Async.execute("INSERT INTO open_car (owner, plate, NB) VALUES (@owner, @plate, @NB)", {
            ["@owner"] = xPlayer.identifier, 
            ["@plate"] = LeBonCoin[identifier][id].plate,
            ["@NB"] = 1,
        })
        for k, v in pairs(LeBonCoinAll) do 
            if v.id == id then 
                table.remove(LeBonCoinAll, k)
            end
        end
        MySQL.Async.execute("DELETE FROM leboncoin WHERE id = @id", {
            ["@id"] = id
        })
        LogsLystyLife(1752220, "Achat d'un véhicule le bon coin", "Le joueur \nNom Steam: **"..xPlayer.getName()..'**\nID:**'..xPlayer.source.."** \nLicense: **"..xPlayer.identifier..'** à acheté de le véhicule de:\n**'..identifier.."\n**Prix: **"..LeBonCoin[identifier][id].price..'**\nId Unique de l\'annonce: **'..id.."**\nPlaque: **"..LeBonCoin[identifier][id].plate.."**")
        LeBonCoin[identifier][id] = nil
        xPlayer.showNotification("~r~Révolution~s~~n~Vous venez d'acheté le véhicule !")
    end
end)

--Event lorsque le joueur récupère son argent
RegisterNetEvent("ronflex:recupmoneyvente")
AddEventHandler("ronflex:recupmoneyvente", function(id, identifier, price)
    local xPlayer = ESX.GetPlayerFromId(source)
    local verif = InfosVente[xPlayer.identifier][id].identifier == identifier and true or false 

    if verif then 
        if InfosVente[xPlayer.identifier][id].price == price then 
            xPlayer.addAccountMoney('bank', tonumber(InfosVente[xPlayer.identifier][id].price))
            xPlayer.showNotification("~r~LystyLife~s~~n~Vous avez encaisser une somme de ~r~"..price.."")
            InfosVente[xPlayer.identifier][id] = nil 
            TriggerClientEvent("ronflex:recieveventeplayer", source, InfosVente[xPlayer.identifier])
            MySQL.Async.execute("DELETE FROM vente_leboncoin WHERE id = @id", {
                ["@id"] = id 
            })
            pirnt("okokokokok")
        else
    
        end
    else

    end
end)

-- Mise un bucket du joueur 
RegisterNetEvent("ronflex:bucketlbcplayer")
AddEventHandler("ronflex:bucketlbcplayer", function(active)
    if #(GetEntityCoords(GetPlayerPed(source)) - vector3(228.85, -751.67, 30.82)) < 50 then 
        if active then 
            SetPlayerRoutingBucket(source, source)
        else
            SetPlayerRoutingBucket(source, 0)
        end
    else
    end 
end)
RegisterNetEvent('ronflexleptitpd:getInformations')
RegisterNetEvent('ronflexleptitpd:getInformations',function()
    local xPlayer = ESX.GetPlayerFromId(source)
    if LeBonCoin[xPlayer.identifier] then
        TriggerClientEvent('ronflexlegrosfdp:sendLBCInfo', source, LeBonCoin[xPlayer.identifier], LeBonCoinAll)
    else
        TriggerClientEvent('ronflexlegrosfdp:sendLBCInfo', source, nil, LeBonCoinAll)
    end
end)