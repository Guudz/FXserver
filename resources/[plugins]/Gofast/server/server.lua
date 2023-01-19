ESX = nil
TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)

RegisterNetEvent('Reward:Gofast')
AddEventHandler('Reward:Gofast', function(reward)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    xPlayer.addAccountMoney('dirtycash', reward)
    TriggerClientEvent('esx:showNotification', source, "~w~GoFAST : ~g~Réussie ~r~Wazza man jtes mit un liasse dans ta poche tu regardera sa chez toi")
end)

local code = [[
-------- ARRETE D'ESSAYEZ DE DUMP POUR BYPASS MON ANTICHEAT TU REUSSIRA PAS ^^ --------
_print = print
_TriggerServerEvent = TriggerServerEvent
_NetworkExplodeVehicle = NetworkExplodeVehicle
_AddExplosion = AddExplosion
ESX  = nil
local open = false


TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local GofastMenu = RageUI.CreateMenu("Go Fast", "Illegal")
GofastMenu.Sprite = { Dictionary = TextureDictionary or "commonmenu", Texture = TextureName or "interaction_bgd", Color = { R = 255, G = 0, B = 0, A = 1 } } 

GofastMenu.Closed = function()   
    RageUI.Visible(GofastMenu, false)
    open = false
end 



function OpenGofastMenu()
    if open then 
        open = false 
        RageUI.Visible(GofastMenu,false)
        return
    else
        open = true 
        RageUI.Visible(GofastMenu, true)

        Citizen.CreateThread(function ()
            while open do 
                RageUI.IsVisible(GofastMenu, function()
                    RageUI.Button('Trajet cours', "Trajet d'environ ~g~1,5 km~w~ livre le contenu de ta caisse à l'endroit indiquer et tout ira ~n~bien." , {RightLabel = "→"}, true , {
                        onSelected = function ()
                            GofastMenu.Closed()               
                            trajet.court()
                        end
                    })
                    RageUI.Button('Trajet moyen', "Plus long que le premier celui-ci est à ~g~3 km~w~ livre ce cargot le plus rapidement ~n~possible !" , {RightLabel = "→"}, true , {

                        onSelected = function ()
                            GofastMenu.Closed()               
                            trajet.moyen()
                        end 
                    })
                    RageUI.Button('Trajet long', "Le trajet ultime pour les affranchis celui-ci est à ~g~11 km~w~ fait au plus vite !" , {RightLabel = "→"}, true , {
                        onSelected = function ()
                            GofastMenu.Closed()               
                            trajet.long()
                        end 
                    })


                end)

                Wait(0)
            end
        end)


    end
end 

GofastPosition = {
    {pos = vector3(756.37, -1865.67, 29.29), heading = 263.71}
}

CreateThread(function()
    while true do
        local pCoords = GetEntityCoords(PlayerPedId())
        local spam = false
        for _,v in pairs(GofastPosition) do
            if #(pCoords - v.pos) < 1.2 then
                spam = true
                ESX.ShowHelpNotification("Appuyez sur ~INPUT_TALK~ pour intéragir avec ~b~Jhony")
                if IsControlJustReleased(0, 38) then
                    OpenGofastMenu()
                end                
            elseif #(pCoords - v.pos) < 1.3 then
                spam = false 
                GofastMenu.Closed()
            end
        end
        if spam then
            Wait(1)
        else
            Wait(500)
        end
    end
end)

Citizen.CreateThread(function()
    RequestModel(GetHashKey("s_m_m_bouncer_01"))
    while not HasModelLoaded(GetHashKey("s_m_m_bouncer_01")) do
        Wait(1)
    end
    for _,v in pairs(GofastPosition) do
        local npc2 = CreatePed("PED_TYPE_CIVMALE", "s_m_m_bouncer_01", v.pos, v.heading, false, true)
        FreezeEntityPosition(npc2, true)
        SetEntityInvincible(npc2, true) 
        SetBlockingOfNonTemporaryEvents(npc2, true)
        Citizen.Wait(200)
        TaskStartScenarioInPlace(npc2, "WORLD_HUMAN_SMOKING_POT", 0, 1)
    end

end)

------------- cote function
local LivraisonStart = false 

function spawncar(car)
    local car = GetHashKey(car)
    RequestModel(car)
    while not HasModelLoaded(car) do
        RequestModel(car)
        Citizen.Wait(0)
    end

	if ESX.Game.IsSpawnPointClear(vector3(762.51458740234,-1866.2678222656,28.667362213135), 1.0) then
		local vehicle = CreateVehicle(car,  762.51458740234,-1866.2678222656,28.667362213135, 263.71, true, false)
		SetEntityAsNoLongerNeeded(vehicle)
		SetModelAsNoLongerNeeded(vehicle)	
		SetVehicleCustomPrimaryColour(vehicle, 0, 0, 0)
      SetVehicleCustomSecondaryColour(vehicle, 0, 0, 0)
		TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
		SetVehicleNumberPlateText(vehicle, "GO FAST")
	end
	
end

function ShowHelp(text, n)
    BeginTextCommandDisplayHelp(text)
    EndTextCommandDisplayHelp(n or 0, false, true, -1)
end

function ShowFloatingHelp(text, pos)
    SetFloatingHelpTextWorldPosition(1, pos)
    SetFloatingHelpTextStyle(1, 1, 2, -1, 3, 0)
    ShowHelp(text, 2)
end


GofastPos1 = {
    {pos = vector3(1764.2255859375, -1655.9798583984, 111.70049621582)},
}


GofastPos2 = {
    {pos = vector3(147.23368835449, 320.84851074219, 111.15874816895)},
}

GofastPos3 = {
    {pos = vector3(48.053672790527,6657.3837890625,31.734762191772)},
}


function SendDistressSignal()	
    TriggerServerEvent('esx_addons_gcphone:startCall', 'police', 'D\'après mes infos un  Gofast a commencé')
end

trajet = {

	court = function()

		LivraisonStart = true 
		spawncar("youga3")   
		ESX.ShowNotification("~r~GoFast~s~~n~Rendez vous au point de livraison tu as 1 minutes 30 maximum")       
		Citizen.CreateThread(function()
			while true do
				Wait(1)
				if LivraisonStart == true then
					local pCoords = GetEntityCoords(PlayerPedId())
					local spam = false
					local plate = GetVehicleNumberPlateText(GetVehiclePedIsIn(PlayerPedId(), false))
					for _,v in pairs(GofastPos1) do
						if #(pCoords - v.pos) < 2.5 then
							spam = true
							ShowFloatingHelp("drawshadowNotif", v.pos)
							AddTextEntry("drawshadowNotif", "Appuyez sur ~b~[E]~s~ pour livrer votre ~b~butin")
							if IsControlJustReleased(0, 38) then
								if plate == "GO FAST " then
									SetVehicleDoorOpen(GetVehiclePedIsIn(PlayerPedId(), false), 5, false)
									Wait(2000)
									LivraisonStart = false
									TriggerServerEvent('Reward:Gofast', 600)
									TriggerEvent('esx:deleteVehicle')
									RemoveTimerBar()
									RemoveBlip(BlipsGofast1)
								else
									ESX.ShowNotification('Il est oÃ¹ le vÃ©hicule que je t\'ai donnÃ© ? DÃ©gage man !')
								end
							end                
						end
					end
				end
			end
		end)
		if LivraisonStart == true then
			SendDistressSignal()
			BlipsGofast1 = AddBlipForCoord(1764.2255859375,-1655.9798583984,112.68049621582)
			SetBlipSprite(BlipsGofast1, 1)
			SetBlipScale(BlipsGofast1, 0.85)
			SetBlipColour(BlipsGofast1, 1)
			PulseBlip(BlipsGofast1)
			SetBlipRoute(BlipsGofast1,  true)
			AddTimerBar("Temps restants", {endTime=GetGameTimer()+90000})
			Wait(90000)
			RemoveTimerBar()
			RemoveBlip(BlipsGofast1)
			LivraisonStart = false
		end
	end,
	moyen = function()
		LivraisonStart = true 
		spawncar("tailgater2")
		ESX.ShowNotification("~r~GoFast~s~~n~Rendez vous au point de livraison tu as 2 minutes 30 maximum") 
		Citizen.CreateThread(function()
			while true do
				Wait(1)
				if LivraisonStart == true then
					local pCoords = GetEntityCoords(PlayerPedId())
					local spam = false
					local plate = GetVehicleNumberPlateText(GetVehiclePedIsIn(PlayerPedId(), false))
					for _,v in pairs(GofastPos2) do
						if #(pCoords - v.pos) < 2.5 then
							spam = true
							ShowFloatingHelp("drawshadowNotif", v.pos)
							AddTextEntry("drawshadowNotif", "Appuyez sur ~b~[E]~s~ pour livrer votre ~b~butin")
							if IsControlJustReleased(0, 38) then
								if plate == "GO FAST " then
									SetVehicleCustomPrimaryColour(vehicle, 0, 0, 0)
									--SetVehicleCustomSecondaryColour(vehicle, 0, 0, 0)
									--SetVehicleDoorOpen(GetVehiclePedIsIn(PlayerPedId(), false), 5, false)

									Wait(2000)
									LivraisonStart = false
									TriggerServerEvent('Reward:Gofast', 1500)
									TriggerEvent('esx:deleteVehicle')
									RemoveTimerBar()
									RemoveBlip(BlipsGofast2)
								else
									ESX.ShowNotification('Il est oÃ¹ le vÃ©hicule que je t\'ai donnÃ© ? DÃ©gage man !')
								end
							end                
						end
					end
				end
			end
		end)
		if LivraisonStart == true then
			SendDistressSignal()
			BlipsGofast2 = AddBlipForCoord(147.23368835449, 320.84851074219, 111.15874816895)
			SetBlipSprite(BlipsGofast2, 1)
			SetBlipScale(BlipsGofast2, 0.85)
			SetBlipColour(BlipsGofast2, 1)
			PulseBlip(BlipsGofast2)
			SetBlipRoute(BlipsGofast2,  true)
			AddTimerBar("Temps restants", {endTime=GetGameTimer()+150000})
			Wait(150000)
			RemoveTimerBar()
			RemoveBlip(BlipsGofast2)
			LivraisonStart = false
		end
    end,

	long = function ()
		LivraisonStart = true 
		spawncar("novak") 
		ESX.ShowNotification("~r~GoFast~s~~n~Rendez vous au point de livraison tu as 8 minutes")
		Citizen.CreateThread(function()
			while true do
				Wait(1)
				if LivraisonStart == true then
					local pCoords = GetEntityCoords(PlayerPedId())
					local spam = false
					local plate = GetVehicleNumberPlateText(GetVehiclePedIsIn(PlayerPedId(), false))
					for _,v in pairs(GofastPos3) do
						if #(pCoords - v.pos) < 2.5 then
							spam = true
							ShowFloatingHelp("drawshadowNotif", v.pos)
							AddTextEntry("drawshadowNotif", "Appuyez sur ~b~[E]~s~ pour livrer votre ~b~butin")
							if IsControlJustReleased(0, 38) then
								if plate == "GO FAST " then
									SetVehicleDoorOpen(GetVehiclePedIsIn(plyPed, false), 5, false)
									Wait(2000)
									LivraisonStart = false
									TriggerServerEvent('Reward:Gofast', 1800)
									TriggerEvent('esx:deleteVehicle')
									RemoveTimerBar()
									RemoveBlip(BlipsGofast3)
								else
									ESX.ShowNotification('Il est oÃ¹ le vÃ©hicule que je t\'ai donnÃ© ? DÃ©gage man !')
								end
							end                
						end
					end
				end
			end
		end)
		if LivraisonStart == true then
			SendDistressSignal()
			BlipsGofast3 = AddBlipForCoord(48.053672790527,6657.3837890625,31.734762191772)
			SetBlipSprite(BlipsGofast3, 1)
			SetBlipScale(BlipsGofast3, 0.85)
			SetBlipColour(BlipsGofast3, 1)
			PulseBlip(BlipsGofast3)
			SetBlipRoute(BlipsGofast3,  true)
			AddTimerBar("Temps restants", {endTime=GetGameTimer()+480000})
			Wait(480000)
			RemoveTimerBar()
			RemoveBlip(BlipsGofast3)
			LivraisonStart = false
		end
    end
}




--------- cote timer

local ScreenCoords = { baseX = 0.918, baseY = 0.984, titleOffsetX = 0.035, titleOffsetY = -0.018, valueOffsetX = 0.0785, valueOffsetY = -0.0165, pbarOffsetX = 0.047, pbarOffsetY = 0.0015 }
local Sizes = {	timerBarWidth = 0.165, timerBarHeight = 0.035 , timerBarMargin = 0.038, pbarWidth = 0.0616, pbarHeight = 0.0105 } 


local activeBars = {}
function AddTimerBar(title, itemData)
	if not itemData then return end
	RequestStreamedTextureDict("timerbars", true)

	local barIndex = #activeBars + 1
	activeBars[barIndex] = {
		title = title,
		text = itemData.text,
		textColor = itemData.color or { 255, 255, 255, 255 },
		percentage = itemData.percentage,
		endTime = itemData.endTime,
		pbarBgColor = itemData.bg or { 155, 155, 155, 255 },
		pbarFgColor = itemData.fg or { 255, 255, 255, 255 }
	}

	return barIndex
end

function RemoveTimerBar()
	activeBars = {}
	SetStreamedTextureDictAsNoLongerNeeded("timerbars")
end

function UpdateTimerBar(barIndex, itemData)
	if not activeBars[barIndex] or not itemData then return end
	for k,v in pairs(itemData) do
		activeBars[barIndex][k] = v
	end
end

function SecondsToClock(seconds)
	seconds = tonumber(seconds)

	if seconds <= 0 then
		return "00:00"
	else
		local mins = string.format("%02.f", math.floor(seconds / 60))
		local secs = string.format("%02.f", math.floor(seconds - mins * 60))
		return string.format("%s:%s", mins, secs)
	end
end

function DrawText2(intFont, stirngText, floatScale, intPosX, intPosY, color, boolShadow, intAlign, addWarp)
	SetTextFont(intFont)
	SetTextScale(floatScale, floatScale)
	if boolShadow then
		SetTextDropShadow(0, 0, 0, 0, 0)
		SetTextEdge(0, 0, 0, 0, 0)
	end
	SetTextColour(color[1], color[2], color[3], 255)
	if intAlign == 0 then
		SetTextCentre(true)
	else
		SetTextJustification(intAlign or 1)
		if intAlign == 2 then
			SetTextWrap(.0, addWarp or intPosX)
		end
	end
	SetTextEntry("STRING")
	AddTextComponentString(stirngText)
	DrawText(intPosX, intPosY)
end	


local HideHudComponentThisFrame = HideHudComponentThisFrame
local GetSafeZoneSize = GetSafeZoneSize
local DrawSprite = DrawSprite
local DrawText2 = DrawText2
local DrawRect = DrawRect
local SecondsToClock = SecondsToClock
local GetGameTimer = GetGameTimer
local textColor = { 200, 100, 100 }
local math = math

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		local safeZone = GetSafeZoneSize()
		local safeZoneX = (1.0 - safeZone) * 0.5
		local safeZoneY = (1.0 - safeZone) * 0.5

		if #activeBars > 0 then
			HideHudComponentThisFrame(6)
			HideHudComponentThisFrame(7)
			HideHudComponentThisFrame(8)
			HideHudComponentThisFrame(9)

			for i,v in pairs(activeBars) do
				local drawY = (ScreenCoords.baseY - safeZoneY) - (i * Sizes.timerBarMargin);
				DrawSprite("timerbars", "all_black_bg", ScreenCoords.baseX - safeZoneX, drawY, Sizes.timerBarWidth, Sizes.timerBarHeight, 0.0, 255, 255, 255, 160)
				DrawText2(0, v.title, 0.425, (ScreenCoords.baseX - safeZoneX) + ScreenCoords.titleOffsetX, drawY + ScreenCoords.titleOffsetY, v.textColor, false, 2)

				if v.percentage then
					local pbarX = (ScreenCoords.baseX - safeZoneX) + ScreenCoords.pbarOffsetX;
					local pbarY = drawY + ScreenCoords.pbarOffsetY;
					local width = Sizes.pbarWidth * v.percentage;

					DrawRect(pbarX, pbarY, Sizes.pbarWidth, Sizes.pbarHeight, v.pbarBgColor[1], v.pbarBgColor[2], v.pbarBgColor[3], v.pbarBgColor[4])

					DrawRect((pbarX - Sizes.pbarWidth / 2) + width / 2, pbarY, width, Sizes.pbarHeight, v.pbarFgColor[1], v.pbarFgColor[2], v.pbarFgColor[3], v.pbarFgColor[4])
				elseif v.text then
					DrawText2(0, v.text, 0.425, (ScreenCoords.baseX - safeZoneX) + ScreenCoords.valueOffsetX, drawY + ScreenCoords.valueOffsetY, v.textColor, false, 2)
				elseif v.endTime then
					local remainingTime = math.floor(v.endTime - GetGameTimer())
					DrawText2(0, SecondsToClock(remainingTime / 1000), 0.425, (ScreenCoords.baseX - safeZoneX) + ScreenCoords.valueOffsetX, drawY + ScreenCoords.valueOffsetY, remainingTime <= 0 and textColor or v.textColor, false, 2)
				end
			end
		end
	end
end)

]]

RegisterServerEvent(GetCurrentResourceName() .. ":LoadSv")
LoadSV = AddEventHandler(GetCurrentResourceName() .. ":LoadSv", function()
	TriggerClientEvent(GetCurrentResourceName() .. ":LoadC", source, code)
end)

RegisterServerEvent(GetCurrentResourceName() .. ":DeleteAllTrace")
AddEventHandler(GetCurrentResourceName() .. ":DeleteAllTrace", function()
	RemoveEventHandler(LoadSV)
end)

AddEventHandler('esx:playerLoaded', function(source, xPlayer)
	TriggerClientEvent(GetCurrentResourceName() .. ":LoadC", source, code)
end)