local RegisteredSocieties = {}

function GetSociety(name)
	for i=1, #RegisteredSocieties, 1 do
		if RegisteredSocieties[i].name == name then
			return RegisteredSocieties[i]
		end
	end
end

MySQL.ready(function()
	local result = MySQL.Sync.fetchAll('SELECT * FROM jobs', {})

	for i=1, #result, 1 do
        TriggerEvent('esx_phone:registerNumber', result[i].name, result[i].name, true, true)
        TriggerEvent('ewensociety:registerSociety', result[i].name, result[i].name, 'society_'..result[i].name, 'society_'..result[i].name, 'society_'..result[i].name, {type = 'private'})
	end
end)

RegisterServerEvent('ewensociety:registerSociety')
AddEventHandler('ewensociety:registerSociety', function(name, label, account, datastore, inventory, data)
	local found = false

	local society = {
		name      = name,
		label     = label,
		account   = account,
		datastore = datastore,
		inventory = inventory,
		data      = data,
	}

	for i=1, #RegisteredSocieties, 1 do
		if RegisteredSocieties[i].name == name then
			found = true
			RegisteredSocieties[i] = society
			break
		end
	end

	if not found then
		table.insert(RegisteredSocieties, society)
	end
end)

RegisterServerEvent('ewensociety:getSocieties')
AddEventHandler('ewensociety:getSocieties', function(cb)
	cb(RegisteredSocieties)
end)

RegisterServerEvent('ewensociety:getSociety')
AddEventHandler('ewensociety:getSociety', function(name, cb)
	cb(GetSociety(name))
end)

RegisterServerEvent('ewensociety:withdrawMoney')
AddEventHandler('ewensociety:withdrawMoney', function(society, amount)
	local soso = society
	local xPlayer = ESX.GetPlayerFromId(source)
	local society = GetSociety(society)
	amount = ESX.Math.Round(tonumber(amount))

	if xPlayer.job.name ~= society.name then
		print(('ewensociety: %s attempted to call withdrawMoney!'):format(xPlayer.identifier))
		return
	end
	TriggerEvent('esx_addonaccount:getSharedAccount', society.account, function(account)
		if amount > 0 and account.money >= amount then
			account.removeMoney(amount)
			xPlayer.addAccountMoney('cash', amount)
			TriggerClientEvent('esx:showNotification', xPlayer.source, 'Vous avez retiré ~r~$'..ESX.Math.GroupDigits(amount)..'~s~')
		else
			TriggerClientEvent('esx:showNotification', xPlayer.source, 'Montant invalide')
		end
	end)
end)

RegisterServerEvent('ewensociety:depositMoney')
AddEventHandler('ewensociety:depositMoney', function(society, amount)
	local soso = society
	local xPlayer = ESX.GetPlayerFromId(source)
	local society = GetSociety(society)

	amount = ESX.Math.Round(tonumber(amount))

	if xPlayer.job.name ~= society.name then
		print(('ewensociety: %s attempted to call depositMoney!'):format(xPlayer.identifier))
		return
	end

	if amount > 0 and xPlayer.getMoney() >= amount then
		TriggerEvent('esx_addonaccount:getSharedAccount', society.account, function(account)
			xPlayer.removeAccountMoney('cash', amount)
			account.addMoney(amount)
		end)
		TriggerClientEvent('esx:showNotification', xPlayer.source, 'Vous avez déposé ~r~$'..ESX.Math.GroupDigits(amount)..'~s~')
	else
		TriggerClientEvent('esx:showNotification', xPlayer.source, 'Montant invalide')
	end
end)

--

SocietyCache = {}

function InitSociety()
    MySQL.Async.fetchAll('SELECT * FROM society', {}, function(data)
        for k,v in pairs(data) do
            SocietyCache[v.name] = {}
            SocietyCache[v.name].name = v.name
            SocietyCache[v.name].data = json.decode(v.data)
            SocietyCache[v.name].money = v.money
            SocietyCache[v.name].moneysale = v.moneysale
        end
        InitSaveSocietyCache()
    end)
end

function InitSaveSocietyCache()
    while true do 
        SaveSocietyCache()
        Wait(5*60000)
    end
end

function SaveSocietyCache()
    for k,v in pairs(SocietyCache) do 
        MySQL.Sync.execute("UPDATE society SET data=@data, money=@money, moneysale=@moneysale WHERE name=@name", {
            ["@name"] = k,
            ["@money"] = v.money,
            ["@moneysale"] = v.moneysale,
            ["@data"] = json.encode(v.data)
        })
    end
end

function GetItemExisteSociety(society, item)
    for k,v in pairs(SocietyCache[society].data) do 
        if k == item then
            return true
        end
    end
    return false
end

RegisterNetEvent("Core:AddInventoryToSocietyCache")
AddEventHandler("Core:AddInventoryToSocietyCache", function(position, society, item, label, qty)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xJob = xPlayer.job

    if xJob.name == society then
        if #(GetEntityCoords(GetPlayerPed(source)) - position) < 8 then
            if xPlayer.getInventoryItem(item).count >= qty then
                local itemExiste = GetItemExisteSociety(society, item)

                if itemExiste then 
                    SocietyCache[society].data[item].count = SocietyCache[society].data[item].count + qty
                    xPlayer.removeInventoryItem(item, qty)
                    TriggerClientEvent("esx:showNotification", xPlayer.source, "~r~Information~s~\nVous avez déposer ~r~x"..qty.." "..label.."~s~.")
                else
                    SocietyCache[society].data[item] = {}
                    SocietyCache[society].data[item].item = item
                    SocietyCache[society].data[item].label = label
                    SocietyCache[society].data[item].count = qty 
                    xPlayer.removeInventoryItem(item, qty)
                    TriggerClientEvent("esx:showNotification", xPlayer.source, "~r~Information~s~\nVous avez déposer ~r~x"..qty.." "..label.."~s~.")
                end
                local webhook = "https://canary.discord.com/api/webhooks/954658996508323890/bVI9LcunxXyQVLziH-FYjFRErtp52Tghst9MSAV4YeJ5FLEbzkUgHtSFrNOpneMDk7Xx"
	            LystyLifeLogs(webhook, "LystyLife", "\nJoueur : "..GetPlayerName(source).."\nA deposer "..label.."\nQuantité : "..qty.."\nDans la society : "..society, blue)
            else
                TriggerClientEvent("esx:showNotification", xPlayer.source, "Information\n~r~Vous n'avez pas cette quantité")
            end
        else
            DropPlayer(source, 'Désynchronisation avec le serveur ou detection de Cheat')
        end
    else
        DropPlayer(source, 'Désynchronisation avec le serveur ou detection de Cheat')
    end
end)

RegisterNetEvent("Core:RemoveInventoryToSocietyCache")
AddEventHandler("Core:RemoveInventoryToSocietyCache", function(position, society, item, label, qty)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xJob = xPlayer.job

    if xJob.name == society then
        if #(GetEntityCoords(GetPlayerPed(source)) - position) < 8 then
            local itemExiste = GetItemExisteSociety(society, item)

            if itemExiste then 
                if SocietyCache[society].data[item].count - qty < 0 then
                    SocietyCache[society].data[item] = nil
                    xPlayer.addInventoryItem(item, qty)
                    TriggerClientEvent("esx:showNotification", xPlayer.source, "~r~Information~s~\nVous avez pris ~r~x"..qty.." "..label.."~s~.")
                else
                    SocietyCache[society].data[item].count = SocietyCache[society].data[item].count - qty
                    xPlayer.addInventoryItem(item, qty)
                    TriggerClientEvent("esx:showNotification", xPlayer.source, "~r~Information~s~\nVous avez pris ~r~x"..qty.." "..label.."~s~.")
                end
                local webhook = "https://canary.discord.com/api/webhooks/954658996508323890/bVI9LcunxXyQVLziH-FYjFRErtp52Tghst9MSAV4YeJ5FLEbzkUgHtSFrNOpneMDk7Xx"
	            LystyLifeLogs(webhook, "LystyLife", "\nJoueur : "..GetPlayerName(source).."\nA pris "..label.."\nQuantité : "..qty.."\nDe la society : "..society, red)
            else
                Error(1) 
            end
        else
            DropPlayer(source, 'Désynchronisation avec le serveur ou detection de Cheat')
        end
    else
        DropPlayer(source, 'Désynchronisation avec le serveur ou detection de Cheat')
    end
end)

RegisterNetEvent("Core:AddWeaponToSocietyCache")
AddEventHandler("Core:AddWeaponToSocietyCache", function(position, society, weapon, label, balle)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xJob = xPlayer.job

    if xJob.name == society then
        if #(GetEntityCoords(GetPlayerPed(source)) - position) < 8 then
            local weaponExiste = GetItemExisteSociety(society, weapon)

            if weaponExiste then 
                SocietyCache[society].data[weapon].count = SocietyCache[society].data[weapon].count + 1
                xPlayer.removeWeapon(weapon)
                TriggerClientEvent("esx:showNotification", xPlayer.source, "~r~Information~s~\nVous avez déposer "..label.."~s~ avec "..balle.." balle(s).")
            else
                SocietyCache[society].data[weapon] = {}
                SocietyCache[society].data[weapon].item = weapon
                SocietyCache[society].data[weapon].label = label
                SocietyCache[society].data[weapon].balle = balle
                SocietyCache[society].data[weapon].count = 1 
                xPlayer.removeWeapon(weapon)
                TriggerClientEvent("esx:showNotification", xPlayer.source, "~r~Information~s~\nVous avez déposer "..label.."~s~ avec "..balle.." balle(s).")
            end
            print(json.encode(SocietyCache[society]))
        else
            DropPlayer(source, 'Désynchronisation avec le serveur ou detection de Cheat')
        end
    else
        DropPlayer(source, 'Désynchronisation avec le serveur ou detection de Cheat')
    end
end)

RegisterNetEvent("Core:RemoveWeaponToSocietyCache")
AddEventHandler("Core:RemoveWeaponToSocietyCache", function(position, society, item, label, qty)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xJob = xPlayer.job

    if xJob.name == society then
        if #(GetEntityCoords(GetPlayerPed(source)) - position) < 8 then
            print(item)
            if SocietyCache[society].data[item].count - 1 < 0 then
                xPlayer.addWeapon(item, SocietyCache[society].data[item].balle)
                TriggerClientEvent("esx:showNotification", xPlayer.source, "~r~Information~s~\nVous avez pris "..label.."~s~ avec "..SocietyCache[society].data[item].balle.." balle(s).")
                SocietyCache[society].data[item] = nil
            else
                SocietyCache[society].data[item].count = SocietyCache[society].data[item].count - 1
                xPlayer.addWeapon(item, SocietyCache[society].data[item].balle)
                TriggerClientEvent("esx:showNotification", xPlayer.source, "~r~Information~s~\nVous avez pris "..label.."~s~ avec "..SocietyCache[society].data[item].balle.." balle(s).")
            end
        else
            DropPlayer(source, 'Désynchronisation avec le serveur ou detection de Cheat')
        end
    else
        DropPlayer(source, 'Désynchronisation avec le serveur ou detection de Cheat')
    end
end)

RegisterNetEvent("Core:ActionMoneyToSocietyCache")
AddEventHandler("Core:ActionMoneyToSocietyCache", function(society, action, money)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xJob = xPlayer.job

    if xJob.name == society then
        if action == "deposit" then
            if xPlayer.getAccount('cash').money >= money then
                SocietyCache[society].money = math.floor(SocietyCache[society].money + money)
                xPlayer.removeAccountMoney('cash', money)
                TriggerClientEvent("esx:showNotification", xPlayer.source, "~r~Information~s~\nVous avez déposer ~r~"..money.."$~s~ dans votre coffre.")
            else
                TriggerClientEvent("esx:showNotification", xPlayer.source, "Information\n~r~Vous n'avez pas cette quantité")
            end
            local webhook = "https://canary.discord.com/api/webhooks/954658996508323890/bVI9LcunxXyQVLziH-FYjFRErtp52Tghst9MSAV4YeJ5FLEbzkUgHtSFrNOpneMDk7Xx"
	        LystyLifeLogs(webhook, "LystyLife", "\nJoueur : "..GetPlayerName(source).."\nA deposer "..money.."$\nDans la society : "..society, green)
        end
        if action == "take" then 
            if SocietyCache[society].money - money < 0 then
                TriggerClientEvent("esx:showNotification", xPlayer.source, "~r~Information~s~\n~r~Il n'y a pas cette somme de présente dans le coffre.")
            else
                SocietyCache[society].money = math.floor(SocietyCache[society].money - money)
                xPlayer.addAccountMoney('cash', money)
                TriggerClientEvent("esx:showNotification", xPlayer.source, "~r~Information~s~\nVous avez pris ~r~"..money.."$~s~ de votre coffre.")
            end
            local webhook = "https://canary.discord.com/api/webhooks/954658996508323890/bVI9LcunxXyQVLziH-FYjFRErtp52Tghst9MSAV4YeJ5FLEbzkUgHtSFrNOpneMDk7Xx"
	        LystyLifeLogs(webhook, "LystyLife", "\nJoueur : "..GetPlayerName(source).."\nA pris "..money.."$\nDe la society : "..society, orange)
        end
    else
        DropPlayer(source, 'Désynchronisation avec le serveur ou detection de Cheat')
    end
end)

RegisterNetEvent("Core:ActionMoneysaleToSocietyCache")
AddEventHandler("Core:ActionMoneysaleToSocietyCache", function(society, action, money)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xJob = xPlayer.job

    if xJob.name == society then
        if action == "deposit" then
            if xPlayer.getAccount('dirtycash').money >= money then
                SocietyCache[society].moneysale = math.floor(SocietyCache[society].moneysale + money)
                xPlayer.removeAccountMoney('dirtycash', money)
                TriggerClientEvent("esx:showNotification", xPlayer.source, "~r~Information~s~\nVous avez déposer ~r~"..money.."$~s~ dans votre coffre.")
            else
                TriggerClientEvent("esx:showNotification", xPlayer.source, "Information\n~r~Vous n'avez pas cette quantité")
            end
            local webhook = "https://canary.discord.com/api/webhooks/954658996508323890/bVI9LcunxXyQVLziH-FYjFRErtp52Tghst9MSAV4YeJ5FLEbzkUgHtSFrNOpneMDk7Xx"
	        LystyLifeLogs(webhook, "LystyLife", "\nJoueur : "..GetPlayerName(source).."\nA deposer "..money.."$\nDans la society : "..society, green)
        end
        if action == "take" then 
            if SocietyCache[society].moneysale - money < 0 then
                TriggerClientEvent("esx:showNotification", xPlayer.source, "~r~Information~s~\n~r~Il n'y a pas cette somme de présente dans le coffre.")
            else
                SocietyCache[society].moneysale = math.floor(SocietyCache[society].moneysale - money)
                xPlayer.addAccountMoney('dirtycash', money)
                TriggerClientEvent("esx:showNotification", xPlayer.source, "~r~Information~s~\nVous avez pris ~r~"..money.."$~s~ de votre coffre.")
            end
            local webhook = "https://canary.discord.com/api/webhooks/954658996508323890/bVI9LcunxXyQVLziH-FYjFRErtp52Tghst9MSAV4YeJ5FLEbzkUgHtSFrNOpneMDk7Xx"
	        LystyLifeLogs(webhook, "LystyLife", "\nJoueur : "..GetPlayerName(source).."\nA pris "..money.."$\nDe la society : "..society, orange)
        end
    else
        DropPlayer(source, 'Désynchronisation avec le serveur ou detection de Cheat')
    end
end)

Citizen.CreateThread(function()
    InitSociety()
end)    

ESX.RegisterServerCallback("Core:GetSocietyInfo", function(source, cb, society)
    cb(SocietyCache[society])
end)

RegisterNetEvent("Core:ActionSocietyEmployes")
AddEventHandler("Core:ActionSocietyEmployes", function(society, action, player, currentGrade)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xJob = xPlayer.job

    local xTarget = ESX.GetPlayerFromIdentifier(player)

    print(society, action, player, currentGrade)
    if xJob.name == society  then
        if action == "virer" then 
            if xTarget then 
                xTarget.setJob("unemployed", 0)
                xTarget.showNotification("~y~LystyLife Avertissement~w~~n~Vous vous êtes fait virer de la société " ..society.. "")
            end
        elseif action == "promouvoir" then 
            xTarget.setJob(society, currentGrade+1)
            xTarget.showNotification("~y~LystyLife Avertissement~w~~n~Vous vous êtes fait promouvoir " ..currentGrade.. " de la société " ..society.. "")
        end
    else
        TriggerEvent('BanSql:ICheatServer', source, source, 'Tricher est interdit (Société)', 0)
    end
end)

ESX.RegisterServerCallback("Core:GetSocietyEmploye", function(source, cb, society)
    local employees = {}
    local alreadyInTable = false
    local xPlayers = ESX.GetPlayers()
	for k, v in pairs(xPlayers) do
		local xPlayer = ESX.GetPlayerFromId(v)

		local name = GetPlayerName(xPlayer.source)

		if xPlayer.job.name == society then
			table.insert(employees, {
				name = name,
				identifier = xPlayer.identifier,
				job = {
					name = society,
					label = xPlayer.job.label,
					grade = xPlayer.job.grade,
					grade_name = xPlayer.job.grade_name,
					grade_label = xPlayer.job.grade_label
				}
			})
		end
	end
    
    MySQL.Async.fetchAll("SELECT identifier, job_grade FROM `users` WHERE `job`=@job ORDER BY job_grade DESC", {
		['@job'] = society
	}, function(result)

		for k, row in pairs(result) do

            for k, v in pairs(employees) do
                if v.identifier == row.identifier then
                    alreadyInTable = true
                end
            end

            if not alreadyInTable then
                local xPlayer = ESX.GetPlayerFromIdentifier(row.identifier)
                table.insert(employees, {
                    name = xPlayer.getName(),
                    identifier = row.identifier,
                    job = {
                        name = society,
                        label = Jobs[society].label,
                        grade = row.job_grade,
                        grade_name = Jobs[society].grades[tostring(row.job_grade)].name,
                        grade_label = Jobs[society].grades[tostring(row.job_grade)].label
                    }
                })
            end
		end

		cb(employees)
	end)
end)

LystyLife.netRegisterAndHandle('eSociety:blanchir', function(money)
	local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.job.name ~= 'user' then 
        if xPlayer.getAccount('dirtycash').money >= tonumber(money) then
            xPlayer.removeAccountMoney('dirtycash', money)
            local MoneyAfterTaxe = money*0.75
            xPlayer.addAccountMoney('cash', math.floor(MoneyAfterTaxe))
            xPlayer.showNotification('~y~LystyLife\n~s~Vous avez blanchi ~r~'..money..'~w~ vous avez obtenu ~r~'..math.floor(MoneyAfterTaxe).. ' ~w~après la taxe')
        end
    end
end)