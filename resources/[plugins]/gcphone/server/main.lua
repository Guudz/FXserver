math.randomseed(GetGameTimer())

function getPhoneRandomNumber()
	return ('%s-%s'):format(math.random(100, 999), math.random(1000, 9999))
end

TriggerEvent('esx:getSharedObject', function(obj)
	ESX = obj

	ESX.RegisterServerCallback('gcphone:getItemAmount', function(source, cb, item)
		local xPlayer = ESX.GetPlayerFromId(source)
		local items = xPlayer.getInventoryItem(item)

		if items == nil then
			cb(0)
		else
			cb(items.count)
		end
	end)
end)

function getNumberPhone(identifier)
	local queryDone, queryResult = false, nil

	MySQL.Async.fetchAll("SELECT users.phone_number FROM users WHERE users.identifier = @identifier", {
		['@identifier'] = identifier
	}, function(result)
		queryDone, queryResult = true, result
	end)

	while not queryDone do
		Citizen.Wait(10)
	end

	if queryResult[1] then
		return queryResult[1].phone_number
	end

	return nil
end

function getIdentifierByPhoneNumber(phone_number)
	local queryDone, queryResult = false, nil

	MySQL.Async.fetchAll("SELECT users.identifier FROM users WHERE users.phone_number = @phone_number", {
		['@phone_number'] = phone_number
	}, function(result)
		queryDone, queryResult = true, result
	end)

	while not queryDone do
		Citizen.Wait(10)
	end

	if queryResult[1] then
		return queryResult[1].identifier
	end

	return nil
end

function getOrGeneratePhoneNumber(sourcePlayer, identifier, cb)
	local myPhoneNumber = getNumberPhone(identifier)

	if myPhoneNumber == '0' or myPhoneNumber == nil then
		repeat
			myPhoneNumber = getPhoneRandomNumber()
			local id = getIdentifierByPhoneNumber(myPhoneNumber)
		until id == nil

		MySQL.Async.execute("UPDATE users SET phone_number = @myPhoneNumber WHERE identifier = @identifier", {
			['@myPhoneNumber'] = myPhoneNumber,
			['@identifier'] = identifier
		}, function()
			cb(myPhoneNumber)
		end)
	else
		cb(myPhoneNumber)
	end
end

function getContacts(identifier)
	local queryDone, queryResult = false, nil

	MySQL.Async.fetchAll("SELECT * FROM phone_users_contacts WHERE identifier = @identifier", {
		['@identifier'] = identifier
	}, function(result)
		queryDone, queryResult = true, result
	end)

	while not queryDone do
		Citizen.Wait(10)
	end

	return queryResult
end

function addContact(source, identifier, number, display)
	local sourcePlayer = tonumber(source)

	MySQL.Async.execute("INSERT INTO phone_users_contacts (`identifier`, `number`,`display`) VALUES (@identifier, @number, @display)", {
		['@identifier'] = identifier,
		['@number'] = number,
		['@display'] = display
	}, function()
		notifyContactChange(sourcePlayer, identifier)
	end)
end

function updateContact(source, identifier, id, number, display)
	local sourcePlayer = tonumber(source)

	MySQL.Async.execute("UPDATE phone_users_contacts SET number = @number, display = @display WHERE id = @id", {
		['@number'] = number,
		['@display'] = display,
		['@id'] = id
	}, function()
		notifyContactChange(sourcePlayer, identifier)
	end)
end

function deleteContact(source, identifier, id)
	local sourcePlayer = tonumber(source)

	MySQL.Async.execute("DELETE FROM phone_users_contacts WHERE `identifier` = @identifier AND `id` = @id", {
		['@identifier'] = identifier,
		['@id'] = id,
	}, function()
		notifyContactChange(sourcePlayer, identifier)
	end)
end

function deleteAllContact(identifier)
	MySQL.Async.execute("DELETE FROM phone_users_contacts WHERE `identifier` = @identifier", {
		['@identifier'] = identifier
	})
end

function notifyContactChange(source, identifier)
	local sourcePlayer = tonumber(source)

	if sourcePlayer ~= nil then
		TriggerClientEvent("gcPhone:contactList", sourcePlayer, getContacts(identifier))
	end
end

RegisterServerEvent('gcPhone:addContact')
AddEventHandler('gcPhone:addContact', function(display, phoneNumber)
	TriggerEvent("ratelimit", source, "gcPhone:addContact")

	local sourcePlayer = tonumber(source)
	local identifier = ESX.GetIdentifierFromId(sourcePlayer)
	addContact(sourcePlayer, identifier, phoneNumber, display)
end)

RegisterServerEvent('gcPhone:updateContact')
AddEventHandler('gcPhone:updateContact', function(id, display, phoneNumber)
	TriggerEvent("ratelimit", source, "gcPhone:updateContact")

	local sourcePlayer = tonumber(source)
	local identifier = ESX.GetIdentifierFromId(sourcePlayer)
	updateContact(sourcePlayer, identifier, id, phoneNumber, display)
end)

RegisterServerEvent('gcPhone:deleteContact')
AddEventHandler('gcPhone:deleteContact', function(id)
	TriggerEvent("ratelimit", source, "gcPhone:deleteContact")

	local sourcePlayer = tonumber(source)
	local identifier = ESX.GetIdentifierFromId(sourcePlayer)
	deleteContact(sourcePlayer, identifier, id)
end)

function getMessages(identifier)
	local queryDone, queryResult = false, nil

	MySQL.Async.fetchAll("SELECT * FROM phone_messages LEFT JOIN users ON users.identifier = @identifier WHERE phone_messages.receiver = users.phone_number", {
		['@identifier'] = identifier
	}, function(result)
		queryDone, queryResult = true, result
	end)

	while not queryDone do
		Citizen.Wait(10)
	end

	return queryResult
end

RegisterServerEvent('gcPhone:_internalAddMessage')
AddEventHandler('gcPhone:_internalAddMessage', function(transmitter, receiver, message, owner, cb)
	TriggerEvent("ratelimit", source, "gcPhone:_internalAddMessage")

	cb(_internalAddMessage(transmitter, receiver, message, owner))
end)

function _internalAddMessage(transmitter, receiver, message, owner)
	local Query = "INSERT INTO phone_messages (`transmitter`, `receiver`,`message`, `isRead`,`owner`) VALUES (@transmitter, @receiver, @message, @isRead, @owner)"
	local Query2 = 'SELECT * FROM phone_messages WHERE `id` = @id'
	local Parameters = {
		['@transmitter'] = transmitter,
		['@receiver'] = receiver,
		['@message'] = message,
		['@isRead'] = owner,
		['@owner'] = owner
	}

	local id = MySQL.Sync.insert(Query, Parameters)

	return MySQL.Sync.fetchAll(Query2, {['@id'] = id})[1]
end

function addMessage(source, identifier, phone_number, message)
	local sourcePlayer = tonumber(source)
	local otherIdentifier = getIdentifierByPhoneNumber(phone_number)
	local myPhone = getNumberPhone(identifier)

	if otherIdentifier ~= nil then
		local tomess = _internalAddMessage(myPhone, phone_number, message, 0)
		local xPlayer = ESX.GetPlayerFromIdentifier(otherIdentifier)

		if xPlayer and tonumber(xPlayer.source) ~= nil then
			TriggerClientEvent("gcPhone:receiveMessage", xPlayer.source, tomess)
		end
	end

	local memess = _internalAddMessage(phone_number, myPhone, message, 1)
	TriggerClientEvent("gcPhone:receiveMessage", sourcePlayer, memess)
end

function setReadMessageNumber(identifier, num)
	local mePhoneNumber = getNumberPhone(identifier)

	MySQL.Async.execute("UPDATE phone_messages SET phone_messages.isRead = 1 WHERE phone_messages.receiver = @receiver AND phone_messages.transmitter = @transmitter", {
		['@receiver'] = mePhoneNumber,
		['@transmitter'] = num
	})
end

function deleteMessage(msgId)
	MySQL.Async.execute("DELETE FROM phone_messages WHERE `id` = @id", {
		['@id'] = msgId
	})
end

function deleteAllMessageFromPhoneNumber(source, identifier, phone_number)
	local mePhoneNumber = getNumberPhone(identifier)

	MySQL.Async.execute("DELETE FROM phone_messages WHERE `receiver` = @mePhoneNumber AND `transmitter` = @phone_number", {
		['@mePhoneNumber'] = mePhoneNumber,
		['@phone_number'] = phone_number
	})
end

function deleteAllMessage(identifier)
	local mePhoneNumber = getNumberPhone(identifier)

	MySQL.Async.execute("DELETE FROM phone_messages WHERE `receiver` = @mePhoneNumber", {
		['@mePhoneNumber'] = mePhoneNumber
	})
end

RegisterServerEvent('gcPhone:sendMessage')
AddEventHandler('gcPhone:sendMessage', function(phoneNumber, message)
	TriggerEvent("ratelimit", source, "gcPhone:sendMessage")

	local sourcePlayer = tonumber(source)
	local identifier = ESX.GetIdentifierFromId(sourcePlayer)
	addMessage(sourcePlayer, identifier, phoneNumber, message)
end)

RegisterServerEvent('gcPhone:deleteMessage')
AddEventHandler('gcPhone:deleteMessage', function(msgId)
	TriggerEvent("ratelimit", source, "gcPhone:deleteMessage")

	deleteMessage(msgId)
end)

RegisterServerEvent('gcPhone:deleteMessageNumber')
AddEventHandler('gcPhone:deleteMessageNumber', function(number)
	TriggerEvent("ratelimit", source, "gcPhone:deleteMessageNumber")

	local sourcePlayer = tonumber(source)
	local identifier = ESX.GetIdentifierFromId(sourcePlayer)
	deleteAllMessageFromPhoneNumber(sourcePlayer, identifier, number)
end)

RegisterServerEvent('gcPhone:deleteAllMessage')
AddEventHandler('gcPhone:deleteAllMessage', function()
	TriggerEvent("ratelimit", source, "gcPhone:deleteAllMessage")

	local sourcePlayer = tonumber(source)
	local identifier = ESX.GetIdentifierFromId(sourcePlayer)
	deleteAllMessage(identifier)
end)

RegisterServerEvent('gcPhone:setReadMessageNumber')
AddEventHandler('gcPhone:setReadMessageNumber', function(num)
	TriggerEvent("ratelimit", source, "gcPhone:setReadMessageNumber")

	local sourcePlayer = tonumber(source)
	local identifier = ESX.GetIdentifierFromId(sourcePlayer)
	setReadMessageNumber(identifier, num)
end)

RegisterServerEvent('gcPhone:deleteALL')
AddEventHandler('gcPhone:deleteALL', function()
	TriggerEvent("ratelimit", source, "gcPhone:deleteALL")

	local sourcePlayer = tonumber(source)
	local identifier = ESX.GetIdentifierFromId(sourcePlayer)
	deleteAllMessage(identifier)
	deleteAllContact(identifier)
	appelsDeleteAllHistorique(identifier)
	TriggerClientEvent("gcPhone:contactList", sourcePlayer, {})
	TriggerClientEvent("gcPhone:allMessage", sourcePlayer, {})
	TriggerClientEvent("appelsDeleteAllHistorique", sourcePlayer, {})
end)

local AppelsEnCours = {}
local PhoneFixeInfo = {}
local lastIndexCall = 10

function getHistoriqueCall(num)
	local queryDone, queryResult = false, nil

	MySQL.Async.fetchAll("SELECT * FROM phone_calls WHERE `owner` = @num ORDER BY time DESC LIMIT 120", {
		['@num'] = num
	}, function(result)
		queryDone, queryResult = true, result
	end)

	while not queryDone do
		Citizen.Wait(10)
	end

	return queryResult
end

function sendHistoriqueCall(src, num)
	local histo = getHistoriqueCall(num)
	TriggerClientEvent('gcPhone:historiqueCall', src, histo)
end

function saveAppels(appelInfo)
	if appelInfo.extraData == nil or appelInfo.extraData.useNumber == nil then
		MySQL.Async.execute("INSERT INTO phone_calls (`owner`, `num`,`incoming`, `accepts`) VALUES(@owner, @num, @incoming, @accepts)", {
			['@owner'] = appelInfo.transmitter_num,
			['@num'] = appelInfo.receiver_num,
			['@incoming'] = 1,
			['@accepts'] = appelInfo.is_accepts
		}, function()
			notifyNewAppelsHisto(appelInfo.transmitter_src, appelInfo.transmitter_num)
		end)
	end

	if appelInfo.is_valid == true then
		local num = appelInfo.transmitter_num

		if appelInfo.hidden == true then
			mun = "###-####"
		end

		MySQL.Async.execute("INSERT INTO phone_calls (`owner`, `num`,`incoming`, `accepts`) VALUES(@owner, @num, @incoming, @accepts)", {
			['@owner'] = appelInfo.receiver_num,
			['@num'] = num,
			['@incoming'] = 0,
			['@accepts'] = appelInfo.is_accepts
		}, function()
			if appelInfo.receiver_src ~= nil then
				notifyNewAppelsHisto(appelInfo.receiver_src, appelInfo.receiver_num)
			end
		end)
	end
end

function notifyNewAppelsHisto(src, num)
	sendHistoriqueCall(src, num)
end

RegisterServerEvent('gcPhone:getHistoriqueCall')
AddEventHandler('gcPhone:getHistoriqueCall', function()
	TriggerEvent("ratelimit", source, "gcPhone:getHistoriqueCall")

	local sourcePlayer = tonumber(source)
	local srcIdentifier = ESX.GetIdentifierFromId(sourcePlayer)
	local srcPhone = getNumberPhone(srcIdentifier)
	sendHistoriqueCall(sourcePlayer, num)
end)

RegisterServerEvent('gcPhone:internal_startCall')
AddEventHandler('gcPhone:internal_startCall', function(source, phone_number, rtcOffer, extraData)
	TriggerEvent("ratelimit", source, "gcPhone:internal_startCall")

	if FixePhone[phone_number] ~= nil then
		onCallFixePhone(source, phone_number, rtcOffer, extraData)
		return
	end

	local rtcOffer = rtcOffer

	if phone_number == nil or phone_number == '' then
		print('BAD CALL NUMBER IS NIL')
		return
	end

	local hidden = string.sub(phone_number, 1, 1) == '#'
	if hidden == true then
		phone_number = string.sub(phone_number, 2)
	end

	local indexCall = lastIndexCall
	lastIndexCall = lastIndexCall + 1

	local sourcePlayer = tonumber(source)
	local srcIdentifier = ESX.GetIdentifierFromId(sourcePlayer)

	local srcPhone = ''
	if extraData ~= nil and extraData.useNumber ~= nil then
		srcPhone = extraData.useNumber
	else
		srcPhone = getNumberPhone(srcIdentifier)
	end
	local destPlayer = getIdentifierByPhoneNumber(phone_number)
	local is_valid = destPlayer ~= nil and destPlayer ~= srcIdentifier
	AppelsEnCours[indexCall] = {
		id = indexCall,
		transmitter_src = sourcePlayer,
		transmitter_num = srcPhone,
		receiver_src = nil,
		receiver_num = phone_number,
		is_valid = destPlayer ~= nil,
		is_accepts = false,
		hidden = hidden,
		rtcOffer = rtcOffer,
		extraData = extraData
	}

	if is_valid == true then
		local xPlayer = ESX.GetPlayerFromIdentifier(destPlayer)

		if xPlayer and tonumber(xPlayer.source) ~= nil then
			AppelsEnCours[indexCall].receiver_src = xPlayer.source
			TriggerEvent('gcPhone:addCall', AppelsEnCours[indexCall])
			TriggerClientEvent('gcPhone:waitingCall', sourcePlayer, AppelsEnCours[indexCall], true)
			TriggerClientEvent('gcPhone:waitingCall', xPlayer.source, AppelsEnCours[indexCall], false)
		else
			TriggerEvent('gcPhone:addCall', AppelsEnCours[indexCall])
			TriggerClientEvent('gcPhone:waitingCall', sourcePlayer, AppelsEnCours[indexCall], true)
		end
	else
		TriggerEvent('gcPhone:addCall', AppelsEnCours[indexCall])
		TriggerClientEvent('gcPhone:waitingCall', sourcePlayer, AppelsEnCours[indexCall], true)
	end
end)

RegisterServerEvent('gcPhone:startCall')
AddEventHandler('gcPhone:startCall', function(phone_number, rtcOffer, extraData)
	TriggerEvent("ratelimit", source, "gcPhone:startCall")

	TriggerEvent('gcPhone:internal_startCall',source, phone_number, rtcOffer, extraData)
end)

RegisterServerEvent('gcPhone:candidates')
AddEventHandler('gcPhone:candidates', function(callId, candidates)
	TriggerEvent("ratelimit", source, "gcPhone:candidates")

	if AppelsEnCours[callId] ~= nil then
		local source = source
		local to = AppelsEnCours[callId].transmitter_src

		if source == to then
			to = AppelsEnCours[callId].receiver_src
		end

		TriggerClientEvent('gcPhone:candidates', to, candidates)
	end
end)


RegisterServerEvent('gcPhone:acceptCall')
AddEventHandler('gcPhone:acceptCall', function(infoCall, rtcAnswer)
	TriggerEvent("ratelimit", source, "gcPhone:acceptCall")

	local id = infoCall.id
	if AppelsEnCours[id] ~= nil then
		if PhoneFixeInfo[id] ~= nil then
			onAcceptFixePhone(source, infoCall, rtcAnswer)
			return
		end

		AppelsEnCours[id].receiver_src = infoCall.receiver_src or AppelsEnCours[id].receiver_src

		if AppelsEnCours[id].transmitter_src ~= nil and AppelsEnCours[id].receiver_src ~= nil then
			AppelsEnCours[id].is_accepts = true
			AppelsEnCours[id].rtcAnswer = rtcAnswer
			TriggerClientEvent('gcPhone:acceptCall', AppelsEnCours[id].transmitter_src, AppelsEnCours[id], true)
			TriggerClientEvent('gcPhone:acceptCall', AppelsEnCours[id].receiver_src, AppelsEnCours[id], false)
			saveAppels(AppelsEnCours[id])
		end
	end
end)

RegisterServerEvent('gcPhone:rejectCall')
AddEventHandler('gcPhone:rejectCall', function(infoCall)
	TriggerEvent("ratelimit", source, "gcPhone:rejectCall")

	local id = infoCall.id

	if AppelsEnCours[id] ~= nil then
		if PhoneFixeInfo[id] ~= nil then
			onRejectFixePhone(source, infoCall)
			return
		end

		if AppelsEnCours[id].transmitter_src ~= nil then
			TriggerClientEvent('gcPhone:rejectCall', AppelsEnCours[id].transmitter_src)
		end

		if AppelsEnCours[id].receiver_src ~= nil then
			TriggerClientEvent('gcPhone:rejectCall', AppelsEnCours[id].receiver_src)
		end

		if not AppelsEnCours[id].is_accepts then
			saveAppels(AppelsEnCours[id])
		end

		TriggerEvent('gcPhone:removeCall', AppelsEnCours)
		AppelsEnCours[id] = nil
	end
end)

RegisterServerEvent('gcPhone:appelsDeleteHistorique')
AddEventHandler('gcPhone:appelsDeleteHistorique', function(numero)
	TriggerEvent("ratelimit", source, "gcPhone:appelsDeleteHistorique")

	local sourcePlayer = tonumber(source)
	local srcIdentifier = ESX.GetIdentifierFromId(sourcePlayer)
	local srcPhone = getNumberPhone(srcIdentifier)

	MySQL.Async.execute("DELETE FROM phone_calls WHERE `owner` = @owner AND `num` = @num", {
		['@owner'] = srcPhone,
		['@num'] = numero
	})
end)

function appelsDeleteAllHistorique(srcIdentifier)
	local srcPhone = getNumberPhone(srcIdentifier)

	MySQL.Async.execute("DELETE FROM phone_calls WHERE `owner` = @owner", {
		['@owner'] = srcPhone
	})
end

RegisterServerEvent('gcPhone:appelsDeleteAllHistorique')
AddEventHandler('gcPhone:appelsDeleteAllHistorique', function()
	TriggerEvent("ratelimit", source, "gcPhone:appelsDeleteAllHistorique")

	local sourcePlayer = tonumber(source)
	local srcIdentifier = ESX.GetIdentifierFromId(sourcePlayer)
	appelsDeleteAllHistorique(srcIdentifier)
end)

AddEventHandler('esx:playerLoaded', function(source)
	local sourcePlayer = tonumber(source)
	local identifier = ESX.GetIdentifierFromId(sourcePlayer)
	getOrGeneratePhoneNumber(sourcePlayer, identifier, function(myPhoneNumber)
		TriggerClientEvent("gcPhone:myPhoneNumber", sourcePlayer, myPhoneNumber)
		TriggerClientEvent("gcPhone:contactList", sourcePlayer, getContacts(identifier))
		TriggerClientEvent("gcPhone:allMessage", sourcePlayer, getMessages(identifier))
	end)
end)

RegisterServerEvent('gcPhone:allUpdate')
AddEventHandler('gcPhone:allUpdate', function()
	TriggerEvent("ratelimit", source, "gcPhone:allUpdate")

	local sourcePlayer = tonumber(source)
	local identifier = ESX.GetIdentifierFromId(sourcePlayer)
	local num = getNumberPhone(identifier)
	TriggerClientEvent("gcPhone:myPhoneNumber", sourcePlayer, num)
	TriggerClientEvent("gcPhone:contactList", sourcePlayer, getContacts(identifier))
	TriggerClientEvent("gcPhone:allMessage", sourcePlayer, getMessages(identifier))
	TriggerClientEvent('gcPhone:getBourse', sourcePlayer, getBourse())
	sendHistoriqueCall(sourcePlayer, num)
end)

MySQL.ready(function ()
	-- MySQL.Async.fetchAll("DELETE FROM phone_messages WHERE (DATEDIFF(CURRENT_DATE, time) > 10)")
end)

function getBourse()
	-- MySQL.Async.fetchAll("SELECT * FROM `recolt` LEFT JOIN `items` ON items.`id` = recolt.`treated_id` WHERE fluctuation = 1 ORDER BY price DESC", {})

	local result = {
		{
			libelle = 'Google',
			price = 125.2,
			difference =  -12.1
		},
		{
			libelle = 'Microsoft',
			price = 132.2,
			difference = 3.1
		},
		{
			libelle = 'Amazon',
			price = 120,
			difference = 0
		}
	}

	return result
end

function onCallFixePhone(source, phone_number, rtcOffer, extraData)
	TriggerEvent("ratelimit", source, "onCallFixePhone")
	local indexCall = lastIndexCall
	lastIndexCall = lastIndexCall + 1
	local hidden = string.sub(phone_number, 1, 1) == '#'

	if hidden == true then
		phone_number = string.sub(phone_number, 2)
	end

	local sourcePlayer = tonumber(source)
	local srcIdentifier = ESX.GetIdentifierFromId(sourcePlayer)
	local srcPhone = ''

	if extraData ~= nil and extraData.useNumber ~= nil then
		srcPhone = extraData.useNumber
	else
		srcPhone = getNumberPhone(srcIdentifier)
	end

	AppelsEnCours[indexCall] = {
		id = indexCall,
		transmitter_src = sourcePlayer,
		transmitter_num = srcPhone,
		receiver_src = nil,
		receiver_num = phone_number,
		is_valid = false,
		is_accepts = false,
		hidden = hidden,
		rtcOffer = rtcOffer,
		extraData = extraData,
		coords = FixePhone[phone_number].coords
	}

	PhoneFixeInfo[indexCall] = AppelsEnCours[indexCall]

	TriggerClientEvent('gcPhone:notifyFixePhoneChange', -1, PhoneFixeInfo)
	TriggerClientEvent('gcPhone:waitingCall', sourcePlayer, AppelsEnCours[indexCall], true)
end

function onAcceptFixePhone(source, infoCall, rtcAnswer)
	TriggerEvent("ratelimit", source, "onAcceptFixePhone")
	local id = infoCall.id
	AppelsEnCours[id].receiver_src = source

	if AppelsEnCours[id].transmitter_src ~= nil and AppelsEnCours[id].receiver_src~= nil then
		AppelsEnCours[id].is_accepts = true
		AppelsEnCours[id].forceSaveAfter = true
		AppelsEnCours[id].rtcAnswer = rtcAnswer
		PhoneFixeInfo[id] = nil
		TriggerClientEvent('gcPhone:notifyFixePhoneChange', -1, PhoneFixeInfo)
		TriggerClientEvent('gcPhone:acceptCall', AppelsEnCours[id].transmitter_src, AppelsEnCours[id], true)
		TriggerClientEvent('gcPhone:acceptCall', AppelsEnCours[id].receiver_src, AppelsEnCours[id], false)
		saveAppels(AppelsEnCours[id])
	end
end

function onRejectFixePhone(source, infoCall, rtcAnswer)
	TriggerEvent("ratelimit", source, "onRejectFixePhone")
	local id = infoCall.id
	PhoneFixeInfo[id] = nil

	TriggerClientEvent('gcPhone:notifyFixePhoneChange', -1, PhoneFixeInfo)
	TriggerClientEvent('gcPhone:rejectCall', AppelsEnCours[id].transmitter_src)

	if not AppelsEnCours[id].is_accepts then
		saveAppels(AppelsEnCours[id])
	end

	AppelsEnCours[id] = nil
end