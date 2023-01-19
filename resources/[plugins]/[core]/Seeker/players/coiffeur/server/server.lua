RegisterNetEvent('barber:pay')
AddEventHandler('barber:pay', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	xPlayer.removeAccountMoney('bank', 20)
	TriggerClientEvent('esx:showNotification', _source, '~r~LystyLifeRôleplay ~w~~n~Merci à vous, Bonne journée')
end)

ESX.RegisterServerCallback('barber:checkMoney', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	cb(xPlayer.getAccount('bank').money >= 20)
end)