
print("(^5Unicorn Job^0) Crée par Seeker")


TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

TriggerEvent('esx_phone:registerNumber', 'unicorn', 'alerte unicorn', true, true)

TriggerEvent('esx_society:registerSociety', 'unicorn', 'unicorn', 'society_unicorn', 'society_unicorn', 'society_unicorn', {type = 'public'})

RegisterServerEvent('Ouvre:unicorn')
AddEventHandler('Ouvre:unicorn', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Vanilla Unicorn', '~r~Annonce', 'L\'Unicorn est désormais ~g~Ouvert~s~ !', 'CHAR_UNICORN', 8)
	end
end)

RegisterServerEvent('Ferme:unicorn')
AddEventHandler('Ferme:unicorn', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Vanilla Unicorn', '~r~Annonce', 'L\'Unicorn est désormais ~r~Fermer~s~ !', 'CHAR_UNICORN', 8)
	end
end)

RegisterServerEvent('Recrutement:unicorn')
AddEventHandler('Recrutement:unicorn', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Vanilla Unicorn', '~g~Annonce', 'Les ~y~Recrutement~r~ en cours, rendez-vous au Vanilla Unicorn !', 'CHAR_UNICORN', 8)
	end
end)


RegisterServerEvent('esx_unicornjob:prendreitems')
AddEventHandler('esx_unicornjob:prendreitems', function(itemName, count)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local sourceItem = xPlayer.getInventoryItem(itemName)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_unicorn', function(inventory)
		local inventoryItem = inventory.getItem(itemName)

		-- is there enough in the society?
		if count > 0 and inventoryItem.count >= count then

			-- can the player carry the said amount of x item?
			if sourceItem.limit ~= -1 and (sourceItem.count + count) > sourceItem.limit then
				TriggerClientEvent('esx:showNotification', _source, "quantité invalide")
			else
				inventory.removeItem(itemName, count)
				xPlayer.addInventoryItem(itemName, count)
				TriggerClientEvent('esx:showNotification', _source, 'Objet retiré', count, inventoryItem.label)
			end
		else
			TriggerClientEvent('esx:showNotification', _source, "quantité invalide")
		end
	end)
end)


RegisterNetEvent('esx_unicornjob:stockitem')
AddEventHandler('esx_unicornjob:stockitem', function(itemName, count)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local sourceItem = xPlayer.getInventoryItem(itemName)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_unicorn', function(inventory)
		local inventoryItem = inventory.getItem(itemName)

		-- does the player have enough of the item?
		if sourceItem.count >= count and count > 0 then
			xPlayer.removeInventoryItem(itemName, count)
			inventory.addItem(itemName, count)
			TriggerClientEvent('esx:showNotification', _source, "Objet déposé "..count..""..inventoryItem.label.."")
		else
			TriggerClientEvent('esx:showNotification', _source, "quantité invalide")
		end
	end)
end)

ESX.RegisterServerCallback('esx_unicornjob:inventairejoueur', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local items   = xPlayer.inventory

	cb({items = items})
end)

ESX.RegisterServerCallback('esx_unicornjob:prendreitem', function(source, cb)
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_unicorn', function(inventory)
		cb(inventory.items)
	end)
end)

--Shop Unicorn 
RegisterNetEvent('slayx:BuyEau')
AddEventHandler('slayx:BuyEau', function()

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)  
    local price = 7
    local xMoney = xPlayer.getAccount('cash')

     if xPlayer.getAccount('cash').money >= price then

        xPlayer.removeAccountMoney('cash', price)
        xPlayer.addInventoryItem('water', 1)
        TriggerClientEvent('esx:showNotification', source, "~g~Achats~w~ effectué !")
    else
         TriggerClientEvent('esx:showNotification', source, "Vous n'avez assez ~r~d\'argent")
    end
end)

RegisterNetEvent('slayx:BuyLimonade')
AddEventHandler('slayx:BuyLimonade', function()

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)  
    local price = 7
    local xMoney = xPlayer.getAccount('cash')

     if xPlayer.getAccount('cash').money >= price then

        xPlayer.removeAccountMoney('cash', price)
        xPlayer.addInventoryItem('limonade', 1)
        TriggerClientEvent('esx:showNotification', source, "~g~Achats~w~ effectué !")
    else
         TriggerClientEvent('esx:showNotification', source, "Vous n'avez assez ~r~d\'argent")
    end
end)

RegisterNetEvent('slayx:BuyVine')
AddEventHandler('slayx:BuyVine', function()

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)  
    local price = 20
    local xMoney = xPlayer.getAccount('cash')

     if xPlayer.getAccount('cash').money >= price then

        xPlayer.removeAccountMoney('cash', price)
        xPlayer.addInventoryItem('vine', 1)
        TriggerClientEvent('esx:showNotification', source, "~g~Achats~w~ effectué !")
    else
         TriggerClientEvent('esx:showNotification', source, "Vous n'avez assez ~r~d\'argent")
    end
end)

RegisterNetEvent('slayx:BuyWhiskycoca')
AddEventHandler('slayx:BuyWhiskycoca', function()

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)  
    local price = 12
    local xMoney = xPlayer.getAccount('cash')

     if xPlayer.getAccount('cash').money >= price then

        xPlayer.removeAccountMoney('cash', price)
        xPlayer.addInventoryItem('whiskycoca', 1)
        TriggerClientEvent('esx:showNotification', source, "~g~Achats~w~ effectué !")
    else
         TriggerClientEvent('esx:showNotification', source, "Vous n'avez assez ~r~d\'argent")
    end
end)

RegisterNetEvent('slayx:BuyMojito')
AddEventHandler('slayx:BuyMojito', function()

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)  
    local price = 10
    local xMoney = xPlayer.getAccount('cash')

     if xPlayer.getAccount('cash').money >= price then

        xPlayer.removeAccountMoney('cash', price)
        xPlayer.addInventoryItem('mojito', 1)
        TriggerClientEvent('esx:showNotification', source, "~g~Achats~w~ effectué !")
    else
         TriggerClientEvent('esx:showNotification', source, "Vous n'avez assez ~r~d\'argent")
    end
end)

RegisterNetEvent('slayx:BuyCoca')
AddEventHandler('slayx:BuyCoca', function()

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)  
    local price = 7
    local xMoney = xPlayer.getAccount('cash')

     if xPlayer.getAccount('cash').money >= price then

        xPlayer.removeAccountMoney('cash', price)
        xPlayer.addInventoryItem('coca', 1)
        TriggerClientEvent('esx:showNotification', source, "~g~Achats~w~ effectué !")
    else
         TriggerClientEvent('esx:showNotification', source, "Vous n'avez assez ~r~d\'argent")
    end
end)
