ESX.RegisterServerCallback('esx_shops:canRob', function(source, cb, store)
	local xPlayers = ESX.GetPlayers()
	local cops = 0

	for i = 1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])

		if xPlayer and xPlayer.job.name == 'police' then
			cops = cops + 1
		end
	end

	if cops >= BraquageSuperette.Zones[store].cops then
		if not BraquageSuperette.Zones[store].robbed then
			cb(true, true)
		else
			cb(true, false)
		end
	else
		cb(false)
	end
end)

RegisterServerEvent('esx_shops:pickUp')
AddEventHandler('esx_shops:pickUp', function(store, token)
    VerifyToken(source, token, 'esx_shops:pickUp', function()
		local xPlayer = ESX.GetPlayerFromId(source)
		local sCoords = BraquageSuperette.Zones[store].coords
		local pCoords = xPlayer.getCoords(true)
		local pDst = #(sCoords - pCoords)
	
		if BraquageSuperette.Zones[store].robbed then
			if not BraquageSuperette.Zones[store].takedPickUp then
				local reward = math.random(BraquageSuperette.Zones[store].reward[1], BraquageSuperette.Zones[store].reward[2]) --BraquageSuperette.Zones[store].reward
	
				if pDst < 10.0 then
					xPlayer.addAccountMoney('dirtycash', reward)
					TriggerClientEvent('esx:showNotification', source, 'Braquage terminé, Vous avez reçu.. ~r~' .. reward .. '$')
					TriggerClientEvent('esx_shops:removePickup', -1, store)
					BraquageSuperette.Zones[store].takedPickUp = true
				else
					DropPlayer(source, 'Problème de synchronisation avec les braquages de superettes')
				end
			else
				DropPlayer(source, 'Problème de synchronisation avec les braquages de superettes')
			end
		end
    end, function()

    end)
end)

local rob = {}

RegisterServerEvent('esx_shops:rob')
AddEventHandler('esx_shops:rob', function(store)
	local _source = source

	if not BraquageSuperette.Zones[store].robbed then
		BraquageSuperette.Zones[store].robbed = true

		local xPlayers = ESX.GetPlayers()
		for i = 1, #xPlayers do
			local xPlayer = ESX.GetPlayerFromId(xPlayers[i])

			if xPlayer.job.name == 'police' then
				TriggerClientEvent('esx_shops:msgPolice', xPlayer.source, store, _source)
			end
		end

		TriggerClientEvent('esx_shops:rob', -1, store)
		Citizen.Wait(12000)
		TriggerClientEvent('esx_shops:robberyOver', _source)

		Citizen.SetTimeout(BraquageSuperette.Zones[store].cooldown * 1000, function()
			BraquageSuperette.Zones[store].robbed = false
			BraquageSuperette.Zones[store].takedPickUp = false
			TriggerClientEvent('esx_shops:resetStore', -1, store)
			TriggerClientEvent('esx_shops:removePickup', -1, store)
		end)

		robWhileRobbering(store)
	else
		TriggerClientEvent('esx:showNotification', source, "VOUS NE POUVEZ ...")
	end
end)

robWhileRobbering = function(store)
	local n = 0
	Citizen.CreateThread(function()
		while n < 900 do
			n = n + 1
			Citizen.Wait(1000)
		end
		BraquageSuperette.Zones[store].robbed = false
		BraquageSuperette.Zones[store].takedPickUp = false
	end)
end
