MarkerPlayer = function(ped)
	local player = GetPlayerPed(ped)
	local pos = GetEntityCoords(player)
    DrawMarker(2, pos.x, pos.y, pos.z+1.0, 0.0, 0.0, 0.0, 179.0, 0.0, 0.0, 0.25, 0.25, 0.25, 81, 203, 231, 200, 0, 1, 2, 1, nil, nil, 0)
end

local cuffedN = false
local isArresting = false

local cuffeddict = 'mp_arresting'
local cuffedanim = 'crook_p2_back_left'

local cuffdict = 'mp_arrest_paired'
local cuffanim = 'cop_p2_back_left'

local uncuffdict = 'mp_arresting'
local uncuffanim = 'a_uncuff'

local prevDrawable, prevTexture, prevPalette = 0, 0, 0
local maleHash, femaleHash = `mp_m_freemode_01`, `mp_f_freemode_01`

OpenMenuF7 = function()
    DataLoad = false 
    Player = nil 
    Cuffed = false 
    local mainmenuf7 = RageUI.CreateMenu("Menu Illégal", "Voici les actions disponibles")
    local fouilleplayer = RageUI.CreateSubMenu(mainmenuf7, "Fouille", "Voici l'inventaire du joueur")
    RageUI.Visible(mainmenuf7, not RageUI.Visible(mainmenuf7))


    while mainmenuf7 do 

        Wait(0)

        RageUI.IsVisible(mainmenuf7, function()
            RageUI.Button("→ Ligoter", "Vous permet de ligoter un joueur", {RightLabel = "~f~→→→"}, true, {
                onActive = function()
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                    if closestDistance ~= -1 and closestDistance <= 3.0 then
                        MarkerPlayer(closestPlayer)
                    end
                end,
                onSelected = function()
                    Cuffed = not Cuffed
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                    if closestDistance ~= -1 and closestDistance <= 3.0 then
                        TriggerServerEvent('ronflex:menoteplayer', GetPlayerServerId(closestPlayer), Cuffed, "basiccuff")
                    end
                end
            })

            RageUI.Button("→ Cagouler", "Vous permet de cagouler un joueur", {RightLabel = "~f~→→→"}, true, {
                onActive = function()
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                    if closestDistance ~= -1 and closestDistance <= 3.0 then
                        MarkerPlayer(closestPlayer)
                    end
                end,
                onSelected = function()
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                    if closestDistance ~= -1 and closestDistance <= 3.0 then
                        TriggerServerEvent("ronflex:cagouleplayer", GetPlayerServerId(closestPlayer))
                    end
                end
            })
        
            RageUI.Button("→ Fouiller", "Vous permet de fouiller le joueur", {RightLabel = "~f~→→→"}, true, {
                onActive = function()
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                    if closestDistance ~= -1 and closestDistance <= 3.0 then
                        MarkerPlayer(closestPlayer)
                    end
                end,
                onSelected = function()

                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                    if closestDistance ~= -1 and closestDistance <= 3.0 then
                        ESX.TriggerServerCallback("ronflex:getplayeradata", function(data)
                            Data = data  
                            Player = GetPlayerServerId(closestPlayer)
                            DataLoad = true 
                        end, GetPlayerServerId(closestPlayer))
                    end
                end
            }, fouilleplayer)

            RageUI.Button('→ Mettre dans le véhicule', nil, {RightLabel = "~f~→→→"}, true, {
                onSelected = function()
                    local player, distance = ESX.Game.GetClosestPlayer()
                    if distance ~= -1 and distance <= 3.0 then
                        TriggerServerEvent("ronflex:poutinvehicule", GetPlayerServerId(player))
                    else
                        ESX.ShowNotification('Aucun Joueurs au alentours')
                    end
                end
            });

            RageUI.Button('→ Sortir du véhicule', nil, {RightLabel = "~f~→→→"}, true, {
                onSelected = function()
                    local player, distance = ESX.Game.GetClosestPlayer()
                    if distance ~= -1 and distance <= 3.0 then
                        TriggerServerEvent("ronflex:exitfromveh", GetPlayerServerId(player))
                    else
                        ESX.ShowNotification('Aucun Joueurs au alentours')
                    end
                end
            });

            RageUI.Button("→ Crocheter", "Vous permet de crocheter un véhicule", {RightLabel = "~f~→→→"}, true, {
                onSelected = function()
                    local playerPed = PlayerPedId()
                    local coords = GetEntityCoords(playerPed, false)
                    local vehicle = GetClosestVehicle(coords, 3.0, 0, 71)
    
                    if DoesEntityExist(vehicle) then
                        local vehicleData = ESX.Game.GetVehicleProperties(vehicle)
                        local playerPed = PlayerPedId()
                        local coords = GetEntityCoords(playerPed, false)

                        if IsAnyVehicleNearPoint(coords, 3.0) then
                            local vehicle = GetClosestVehicle(coords, 3.0, 0, 71)

                            if DoesEntityExist(vehicle) then
                                Citizen.CreateThread(function()
                                    TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_WELDING', 0, true)
                                    Citizen.Wait(20000)

                                    ClearPedTasksImmediately(playerPed)

                                    SetVehicleDoorsLocked(vehicle, 1)
                                    SetVehicleDoorsLockedForAllPlayers(vehicle, false)

                                    ESX.ShowNotification("Véhicule ouvert")
                                end)
                            end
                        end
                    else
                        ESX.ShowNotification("Aucun véhicule")
                    end
                end
            })         
        
        end, function()
        end)

        RageUI.IsVisible(fouilleplayer, function()

            if DataLoad then 
                RageUI.Separator("↓ Items ↓")
                for k, v in pairs(Data.item) do 
                    if v.count > 0 then 
                        RageUI.Button("~f~"..v.label.."~s~", nil, {RightLabel = "~g~x"..v.count}, true, {
                            onSelected = function()
                                local quantity = KeyboardInput("Combien voulez vous en derober", "Combien voulez vous en derober", "", 10)
                                if quantity then 
                                    TriggerServerEvent("ronflex:derobeitem", v.name, quantity, Player)
                                    DataLoad = false
                                    Wait(30)
                                    ESX.TriggerServerCallback("ronflex:getplayeradata", function(data)
                                        Data = data  
                                        DataLoad = true 
                                    end, Player)
                                end
                            end
                        })
                    end
                
                end
                
                RageUI.Separator("↓ Armes ↓")
                for k, v in pairs(Data.weapon) do 
                    RageUI.Button("~f~"..v.label.."~s~", nil, {RightLabel = ""}, true, {
                        onSelected = function()
                            TriggerServerEvent("ronflex:derobeweapon", v.name, Player, v.label)
                            DataLoad = false
                            Wait(30)
                            ESX.TriggerServerCallback("ronflex:getplayeradata", function(data)
                                Data = data  
                                DataLoad = true 
                            end, Player)
                        end
                    })
                end
            else 
                RageUI.Separator("~r~Chargement de l'inventaire...")
            end
        
        
        end, function()
        end)

        if not RageUI.Visible(mainmenuf7) and
        not RageUI.Visible(fouilleplayer) then 
            mainmenuf7 = RMenu:DeleteType("mainmenuf7")
            fouilleplayer = RMenu:DeleteType("fouilleplayer")
        end
    end


end



RegisterNetEvent("ronflex:poutinvehicule", function()
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed, false)

	if IsAnyVehicleNearPoint(coords, 5.0) then
		local vehicle = GetClosestVehicle(coords, 5.0, 0, 71)

		if DoesEntityExist(vehicle) then
			local maxSeats = GetVehicleMaxNumberOfPassengers(vehicle)
			local freeSeat = nil

			for i = maxSeats - 1, 0, -1 do
				if IsVehicleSeatFree(vehicle,  i) then
					freeSeat = i
					break
				end
			end

			if freeSeat ~= nil then
				TaskWarpPedIntoVehicle(playerPed, vehicle, freeSeat)
			end
		end
	end
end)

RegisterNetEvent("ronflex:exitfromveh", function()
	local ped = PlayerPedId()

	if not IsPedSittingInAnyVehicle(ped) then
		return
	end

	local vehicle = GetVehiclePedIsIn(ped, false)
	TaskLeaveVehicle(ped, vehicle, 16)
end)

Keys.Register("F7", "menu-illegal", "Menu Illégal", function()
    if ConfigGangBuilder.AutorizedJobF7[ESX.PlayerData.job2.name] then 
        OpenMenuF7()
    else
        ESX.ShowNotification("Vous n'avez pas les permissions")
    end
end)

local needDisplayBag = false


RegisterNetEvent('ronflex:cagouleplayer')
AddEventHandler('ronflex:cagouleplayer', function()
    needDisplayBag = not needDisplayBag
 
    while needDisplayBag do
        if not HasStreamedTextureDictLoaded('cagoule') then
            RequestStreamedTextureDict('cagoule')
            while not HasStreamedTextureDictLoaded('cagoule') do
                Citizen.Wait(50)
            end
        end

        DrawSprite('cagoule', 'headbag', 0.5, 0.5, 1.0, 1.0, 0.0, 255, 255, 255, 255)
        Citizen.Wait(0)
    end
    SetStreamedTextureDictAsNoLongerNeeded('cagoule')
end)


RegisterNetEvent('ronflex:menoterclient')
AddEventHandler('ronflex:menoterclient', function(wannamove, cufferSource)
    local plyPed = PlayerPedId()

	if wannamove then
		cuffedN = true
		local targetPed = GetPlayerPed(GetPlayerFromServerId(cufferSource))
	
		ESX.Streaming.RequestAnimDict(cuffdict)
		ESX.Streaming.RequestAnimDict(cuffeddict)
		
		AttachEntityToEntity(plyPed, targetPed, 11816, -0.1, 0.45, 0.0, 0.0, 0.0, 20.0, false, false, false, false, 20, false)
		TaskPlayAnim(plyPed, cuffdict, cuffedanim, 8.0, -8.0, 4300, 33, 0.0, false, false, false)
		RemoveAnimDict(cuffdict)
		Citizen.Wait(2000)

		DetachEntity(plyPed, true, false)
		-- TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 3.0, 'cuff', 0.7)
		Citizen.Wait(2300)

		prevDrawable, prevTexture, prevPalette = GetPedDrawableVariation(plyPed, 7), GetPedTextureVariation(plyPed, 7), GetPedPaletteVariation(plyPed, 7)

		if GetEntityModel(plyPed) == femaleHash then
			SetPedComponentVariation(plyPed, 7, 25, 0, 0)
		elseif GetEntityModel(plyPed) == maleHash then
			SetPedComponentVariation(plyPed, 7, 41, 0, 0)
		end

		plyPed = PlayerPedId()
		SetEnableHandcuffs(plyPed, true)

		TaskPlayAnim(plyPed, cuffeddict, 'idle', 8.0, -8, -1, 49, 0.0, false, false, false)
		RemoveAnimDict(cuffeddict)
	elseif not wannamove then
		-- TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 3.0, 'uncuff', 0.7)

		ClearPedTasks(plyPed)
		SetEnableHandcuffs(plyPed, false)
		UncuffPed(plyPed)
		SetPedComponentVariation(plyPed, 7, prevTexture, prevTexture, prevPalette)

		cuffedN = false
	end
end)

RegisterNetEvent('krz_handcuff:arresting')
AddEventHandler('krz_handcuff:arresting', function()
	ESX.Streaming.RequestAnimDict(cuffdict)

	isArresting = true
	local plyPed = PlayerPedId()

	TaskPlayAnim(plyPed, cuffdict, cuffanim, 8.0, -8.0, 4300, 33, 0.0, false, false, false)
	RemoveAnimDict(cuffdict)
	Citizen.Wait(4300)
	isArresting = false
end)
