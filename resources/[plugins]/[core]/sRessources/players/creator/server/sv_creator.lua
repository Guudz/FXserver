
RegisterNetEvent('ronflex:bucket')
AddEventHandler('ronflex:bucket', function(active)
    local _source = source
    if active then 
        SetPlayerRoutingBucket(_source, _source)
        print(GetPlayerRoutingBucket(_source))
    elseif not active then 
        SetPlayerRoutingBucket(_source, 0)
    else
        DropPlayer(source, "Ronflex AntiCheat \nTentative de Cheat")
    end
end)


RegisterNetEvent("ronflex:identity")
AddEventHandler("ronflex:identity", function(ident)
    local xPlayer = ESX.GetPlayerFromId(source)
    local license = xPlayer.identifier 
    if GetPlayerRoutingBucket(source) ~= 0 then 
        MySQL.Async.execute("UPDATE users set firstname = @firstname, lastname = @lastname, height = @height, sex = @sex, dateofbirth = @dateofbirth WHERE identifier = @identifier", {
            ["@identifier"] = license,
            ['@firstname'] = ident.firstname,
            ['@lastname'] = ident.lastname,
            ['@height'] = ident.taille,
            ['@sex'] = ident.sex,
            ['@dateofbirth'] = ident.age
        })
    else
        DropPlayer(source, "Ronflex AntiCheat \nTentative de Cheat")
    end
end)
