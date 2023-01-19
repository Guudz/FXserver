TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

TriggerEvent('esx_phone:registerNumber', 'vigne', 'alerte vigne', true, true)

TriggerEvent('esx_society:registerSociety', 'vigne', 'vigne', 'society_vigne', 'society_vigne', 'society_vigne', {type = 'public'})

RegisterServerEvent('Ouvre:vigne')
AddEventHandler('Ouvre:vigne', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Vigne', '~g~Annonce', 'Les vigne sont ouvert ! Venez achetez votre vin et jus de raisin !',  8)
	end
end)

RegisterServerEvent('Ferme:vigne')
AddEventHandler('Ferme:vigne', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Vigne', '~g~Annonce', 'Les vignes ferme pour le moment !',  8)
	end
end)

RegisterServerEvent('Recru:vigne')
AddEventHandler('Recru:vigne', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Vigne', '~g~Annonce', 'Recrutement en cours, rendez-vous au vigne !',  8)
	end
end)


RegisterServerEvent('esx_vignejob:prendreitems')
AddEventHandler('esx_vignejob:prendreitems', function(itemName, count)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local sourceItem = xPlayer.getInventoryItem(itemName)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_vigne', function(inventory)
		local inventoryItem = inventory.getItem(itemName)

		if count > 0 and inventoryItem.count >= count then

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


RegisterNetEvent('esx_vignejob:stockitem')
AddEventHandler('esx_vignejob:stockitem', function(itemName, count)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local sourceItem = xPlayer.getInventoryItem(itemName)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_vigne', function(inventory)
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


ESX.RegisterServerCallback('esx_vignejob:inventairejoueur', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local items   = xPlayer.inventory

	cb({items = items})
end)

ESX.RegisterServerCallback('esx_vignejob:prendreitem', function(source, cb)
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_vigne', function(inventory)
		cb(inventory.items)
	end)
end)


-- Farm

RegisterNetEvent('recolteraisin')
AddEventHandler('recolteraisin', function()
    local item = "raisin"
    local limiteitem = 50
    local xPlayer = ESX.GetPlayerFromId(source)
    local nbitemdansinventaire = xPlayer.getInventoryItem(item).count
    

    if nbitemdansinventaire >= limiteitem then
        TriggerClientEvent('esx:showNotification', source, "Ta pas assez de place dans ton inventaire!")
        recoltepossible = false
    else
        xPlayer.addInventoryItem(item, 1)
        TriggerClientEvent('esx:showNotification', source, "Récolte en cours...")
		return
    end
end)

RegisterNetEvent('traitementjusraisin')
AddEventHandler('traitementjusraisin', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    local raisin = xPlayer.getInventoryItem('raisin').count
    local jus_raisin = xPlayer.getInventoryItem('jus_raisin').count
	local grand_cru = xPlayer.getInventoryItem('grand_cru').count

    if jus_raisin > 250 then
        TriggerClientEvent('esx:showNotification', source, '~r~Il semble que tu ne puisses plus porter de jus de raisin...')
    elseif raisin < 5 then
        TriggerClientEvent('esx:showNotification', source, '~r~Pas assez de jus de raisin pour traiter...')
    else
        xPlayer.removeInventoryItem('raisin', 5)
        xPlayer.addInventoryItem('jus_raisin', 5)
		xPlayer.addInventoryItem('grand_cru', 1)
    end
end)


RegisterServerEvent('selljusraisin')
AddEventHandler('selljusraisin', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local jus_raisin = 0

	for i=1, #xPlayer.inventory, 1 do
		local item = xPlayer.inventory[i]

		if item.name == "jus_raisin" then
			jus_raisin = item.count
		end
	end
    
    TriggerEvent('esx_addonaccount:getSharedAccount', 'society_vigne', function(account)
        societyAccount = account
    end)
    
    if jus_raisin > 0 then
        xPlayer.removeInventoryItem('jus_raisin', 1)
        xPlayer.addAccountMoney('cash', 40)
        societyAccount.addMoney(40)
        TriggerClientEvent('esx:showNotification', xPlayer.source, "~g~Vous avez gagner ~b~40$~g~ pour chaque vente d'un jus de raisin")
        TriggerClientEvent('esx:showNotification', xPlayer.source, "~g~La société gagne ~b~40$~g~ pour chaque vente d'un jus de raisin")
    else 
        TriggerClientEvent('esx:showNotification', xPlayer.source, "Vous n'avez plus rien à vendre")
    end
end)

RegisterServerEvent('sellgrandcru')
AddEventHandler('sellgrandcru', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local grand_cru = 0

	for i=1, #xPlayer.inventory, 1 do
		local item = xPlayer.inventory[i]

		if item.name == "grand_cru" then
			grand_cru = item.count
		end
	end
    
    TriggerEvent('esx_addonaccount:getSharedAccount', 'society_vigne', function(account)
        societyAccount = account
    end)
    
    if grand_cru > 0 then
        xPlayer.removeInventoryItem('grand_cru', 1)
        xPlayer.addAccountMoney('cash', 70)
        societyAccount.addMoney(70)
        TriggerClientEvent('esx:showNotification', xPlayer.source, "~g~Vous avez gagner ~b~70$~g~ pour chaque vente d'un grand cru")
        TriggerClientEvent('esx:showNotification', xPlayer.source, "~g~La société gagne ~b~70$~g~ pour chaque vente d'un grand cru")
    else 
        TriggerClientEvent('esx:showNotification', xPlayer.source, "Vous n'avez plus rien à vendre")
    end
end)

