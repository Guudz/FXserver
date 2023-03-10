local playersInJail = {}

TriggerEvent('es:addGroupCommand', 'jail', 'moderator', function(source, args, user)
	if args[1] and GetPlayerName(args[1]) ~= nil and tonumber(args[2]) then
		TriggerEvent('esx_jailer:sendToJail', tonumber(args[1]), tonumber(args[2] * 60))
	else
		TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Invalid player ID or jail time!' } } )
	end
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = "Mettre un joueur en jail (STAFF)", params = {{name = "id", help = "target id"}, {name = "time", help = "jail time in minutes"}}})

TriggerEvent('es:addGroupCommand', 'unjail', 'moderator', function(source, args, user)
	if args[1] then
		if GetPlayerName(args[1]) ~= nil then
			TriggerEvent('esx_jailer:unjailQuest', tonumber(args[1]))
		else
			TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Invalid player ID!' } } )
		end
	else
		TriggerEvent('esx_jailer:unjailQuest', source)
	end
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = "Unjail un joueur (STAFF)", params = {{name = "id", help = "target id"}}})

AddEventHandler('esx:playerLoaded', function(playerId, xPlayer)
	MySQL.Async.fetchAll('SELECT jail_time FROM users WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier
	}, function(result)
		if result[1] and result[1].jail_time > 0 then
			TriggerEvent('esx_jail:sendToJail', xPlayer.source, result[1].jail_time, true)
		end
	end)
end)

AddEventHandler('esx:playerDropped', function(playerId, reason)
	playersInJail[playerId] = nil
end)

MySQL.ready(function()
	Citizen.Wait(2000)
	local xPlayers = ESX.GetPlayers()

	for i=1, #xPlayers do
		Citizen.Wait(100)
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])

		MySQL.Async.fetchAll('SELECT jail_time FROM users WHERE identifier = @identifier', {
			['@identifier'] = xPlayer.identifier
		}, function(result)
			if result[1] and result[1].jail_time > 0 then
				TriggerEvent('esx_jail:sendToJail', xPlayer.source, result[1].jail_time, true)
			end
		end)
	end
end)

RegisterNetEvent('esx_jail:unjail')
AddEventHandler('esx_jail:unjail', function(playerId)
	local xPlayerProtect = ESX.GetPlayerFromId(source)
	if xPlayerProtect ~= "user" then
		unjailPlayer(playerId)
	end
end)

RegisterNetEvent('esx_jail:sendToJail')
AddEventHandler('esx_jail:sendToJail', function(playerId, jailTime, quiet)
	local xPlayer = ESX.GetPlayerFromId(playerId)
	if source == "" then
		if xPlayer then
			if not playersInJail[playerId] then
				MySQL.Async.execute('UPDATE users SET jail_time = @jail_time WHERE identifier = @identifier', {
					['@identifier'] = xPlayer.identifier,
					['@jail_time'] = jailTime
				}, function(rowsChanged)
					xPlayer.triggerEvent('esx_policejob:unrestrain')
					xPlayer.triggerEvent('esx_jail:jailPlayer', jailTime)
					playersInJail[playerId] = {timeRemaining = jailTime, identifier = xPlayer.identifier }
					if not quiet then
						--TriggerClientEvent('chat:addMessage', -1, {args = {_U('judge'), _U('jailed_msg', xPlayer.getName(), ESX.Math.Round(jailTime / 60))}, color = {147, 196, 109}})
					end
				end)
			end
		end
	end
end)

function unjailPlayer(playerId)
	local xPlayer = ESX.GetPlayerFromId(playerId)

	if xPlayer then
		if playersInJail[playerId] then
			MySQL.Async.execute('UPDATE users SET jail_time = 0 WHERE identifier = @identifier', {
				['@identifier'] = xPlayer.identifier
			}, function(rowsChanged)
				--TriggerClientEvent('chat:addMessage', -1, {args = {_U('judge'), _U('unjailed', xPlayer.getName())}, color = {147, 196, 109}})
				playersInJail[playerId] = nil
				xPlayer.triggerEvent('esx_jail:unjailPlayer')
			end)
		end
	end
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		for playerId,data in pairs(playersInJail) do
			playersInJail[playerId].timeRemaining = data.timeRemaining - 1

			if data.timeRemaining < 1 then
				unjailPlayer(playerId, false)
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(Config.JailTimeSyncInterval)
		local tasks = {}

		for playerId,data in pairs(playersInJail) do
			local task = function(cb)
				MySQL.Async.execute('UPDATE users SET jail_time = @time_remaining WHERE identifier = @identifier', {
					['@identifier'] = data.identifier,
					['@time_remaining'] = data.timeRemaining
				}, function(rowsChanged)
					cb(rowsChanged)
				end)
			end

			table.insert(tasks, task)
		end

		Async.parallelLimit(tasks, 4, function(results) end)
	end
end)