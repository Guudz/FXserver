PoliceMenu = {
    AgentInService = 0,
    Matricule = "~r~Indéfini",
    NamePrename = "~r~Indéfini",
    ReasonArrestation = "~r~Indéfini",
    TimePrison = "~r~Indéfini",
    MatriculeKey = false,
    NamePrenameKey = false,
    ReasonArrestationKey = false,
    TimePrisonKey = false
}
CasierPolice = {}
local DragStatus = {}
DragStatus.isDragged = false
DragStatus.dragger = tonumber(draggerId)

OpenMenuPolice = function()
    local mainmenupolice = RageUI.CreateMenu("", "Voici les actions disponibles")
    local interactioncitoyenspolice = RageUI.CreateSubMenu(mainmenupolice, "", "Voici les actions disponibles")
    local interactionvehiculepolice = RageUI.CreateSubMenu(mainmenupolice, "", "Voici les actions disponibles")
    local demanderenfortpolice = RageUI.CreateSubMenu(mainmenupolice, "", "Voici les actions disponibles")
    local casierjudiciairepolice = RageUI.CreateSubMenu(mainmenupolice, "", "Voici les actions disponibles")
    local miseenprisonpolice = RageUI.CreateSubMenu(mainmenupolice, "", "Voici les actions disponibles")

    RageUI.Visible(mainmenupolice, not RageUI.Visible(mainmenupolice))
    while mainmenupolice do 
        Wait(0)

        RageUI.IsVisible(mainmenupolice, function()
            
            RageUI.Checkbox("Prendre votre service", "Vous permet de commencer/arréter votre service", ServicePoliceCheck, {}, {
                onChecked = function()
                    TriggerServerEvent("ronflex:servicepolice", true)
                    ServicePoliceCheck = true 
                end,
                onUnChecked = function()
                    TriggerServerEvent("ronflex:servicepolice", false)
                    ServicePoliceCheck = false 
                end
            })

            if ServicePoliceCheck then 
                RageUI.Separator("Agent en service: ~r~"..PoliceMenu.AgentInService.."")
                RageUI.Button("→ Intéractions citoyens", "Vous permet d'intéragir avec les citoyens", {RightLabel = "→→→"}, true, {}, interactioncitoyenspolice)
                RageUI.Button("→ Intéractions véhicule", "Vous permet d'intéragir avec les véhicules", {RightLabel = "→→→"}, true, {}, interactionvehiculepolice)
                RageUI.Button("→ Codes radio", "Vous permet de faire des demandes de renfort", {RightLabel = "→→→"}, true, {}, demanderenfortpolice)
                RageUI.Button("→ Rédiger un casier judiciaire", nil, {RightLabel = "→→→"}, true, {}, casierjudiciairepolice)
                RageUI.Button("→ Mise en cellule", nil, {RightLabel = "→→→"}, true, {}, miseenprisonpolice)
            end
    
        end)

        RageUI.IsVisible(interactioncitoyenspolice, function()
            
            RageUI.Button("Fouiller un individu", "Vous permet de fouiller un citoyen", {RightLabel = "→→→"}, true, {
                onActive = function()
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                    if closestPlayer ~= -1 and closestDistance <= 3.0 then
                        PlayerMarker(closestPlayer)
                    end
                end, 
                onSelected = function()
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                    if closestPlayer ~= -1 and closestDistance <= 3.0 then
                        OpenFouillePolice(closestPlayer)

                    end
                end
            })

            RageUI.Button("→ Mettre dans un véhicule", "Vous permet de mettre l'individu dans un véhicule", {RightLabel = "→→→"}, true, {
                onActive = function()
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                    if closestPlayer ~= -1 and closestDistance <= 3.0 then
                        PlayerMarker(closestPlayer)
                    end
                end, 
                onSelected = function()
                    local player, distance = ESX.Game.GetClosestPlayer()
                    if distance ~= -1 and distance <= 3.0 then
                        TriggerServerEvent('police:putInVehicle', GetPlayerServerId(player))
                    else
                        ESX.ShowNotification('~r~Aucun joueur~s~ à proximité')
                    end
                end
            })

            RageUI.Button("→ Sortir du véhicule", "Vous permet de sortir un individu du véhicule véhicule", {RightLabel = "→→→"}, true, {
                onActive = function()
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                    if closestPlayer ~= -1 and closestDistance <= 3.0 then
                        PlayerMarker(closestPlayer)
                    end
                end, 
                onSelected = function()
                    local player, distance = ESX.Game.GetClosestPlayer()
                    if distance ~= -1 and distance <= 3.0 then
                        TriggerServerEvent('police:OutVehicle', GetPlayerServerId(player))
                    else
                        ESX.ShowNotification('~r~Aucun joueur~s~ à proximité')
                    end
                end
            })

            RageUI.Button("→ Escorter", "Vous permet d'escorter le joueur", {RightLabel = "→→→"}, true, {
                onSelected = function() 
                    local player, distance = ESX.Game.GetClosestPlayer()
                    if distance ~= -1 and distance <= 3.0 then
                        TriggerServerEvent('esx_policejob:drag', GetPlayerServerId(player))
                    else
                        ESX.ShowNotification('~r~Aucun joueur~s~ à proximité')
                    end
                end,
            })

            RageUI.Button("→ Mettre une amande", "Vous permet de mettre une facture", {RightLabel = "→→→"}, true, {
                onSelected = function() 
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                    if closestPlayer ~= -1 and closestDistance <= 3.0 then
                        local string = KeyboardInput('Montant de la facture', ('Montant de la facture'), '', 999)
                        if string ~= "" then
                            Montant = tonumber(string)
                        end
                        TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(closestPlayer), 'society_police', 'Amande Police', Montant)
                    else
                        ESX.ShowNotification('~r~Erreur ~w~~n~Il n\'y a aucun joueurs au alentours')
                    end
                end,
            })
        
        end, function()
        end)

        RageUI.IsVisible(interactionvehiculepolice, function()
            RageUI.Button('Crocheter Véhicule', nil, {}, true, {

                onActive = function()
                    local vehicle   = ESX.Game.GetClosestVehicle(GetEntityCoords(PlayerPedId(), false), false)
                    local VehiclePos = 	GetEntityCoords(vehicle)
                    DrawMarker(2, VehiclePos.x, VehiclePos.y, VehiclePos.z+1.8, 0, 0, 0, 180.0,nil,nil, 0.5, 0.5, 0.5, 255, 143, 0, 170, false, true, nil, true)
                end,

                onSelected = function() 
                    local vehicle = ESX.Game.GetVehicleInDirection()
                    if DoesEntityExist(vehicle) then
                        local plyPed = PlayerPedId()
    
                        TaskStartScenarioInPlace(plyPed, 'WORLD_HUMAN_WELDING', 0, true)
                        Citizen.Wait(20000)
                        ClearPedTasksImmediately(plyPed)
    
                        SetVehicleDoorsLocked(vehicle, 1)
                        SetVehicleDoorsLockedForAllPlayers(vehicle, false)
                        ESX.ShowAdvancedNotification('~r~~r~Police~s~', '~h~Information véhicule~s~', 'Véhicule ~g~dévérouillé~s~', 'CHAR_CARSITE', 1)
                    else
                        ESX.ShowAdvancedNotification('~r~~r~Police~s~', '~h~Information véhicule~s~', '~r~Aucun véhicule~s~ à proximité~s~', 'CHAR_CARSITE', 1)
                    end
                end,
            })

            RageUI.Button('Mettre en fourrière', nil, {}, true, {
                onActive = function()
                    local vehicle   = ESX.Game.GetClosestVehicle(GetEntityCoords(PlayerPedId(), false), false)
                    local VehiclePos = 	GetEntityCoords(vehicle)
                    DrawMarker(2, VehiclePos.x, VehiclePos.y, VehiclePos.z+1.8, 0, 0, 0, 180.0,nil,nil, 0.5, 0.5, 0.5, 255, 143, 0, 170, false, true, nil, true)
                end,

                onSelected = function() 
                    local vehicle = ESX.Game.GetVehicleInDirection()
                    local plyPed = PlayerPedId()

                    TaskStartScenarioInPlace(plyPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
                    
                    ClearPedTasks(plyPed)
                    Citizen.Wait(4000)
                    ESX.Game.DeleteVehicle(vehicle)
                    ClearPedTasks(plyPed) 
                    ESX.ShowAdvancedNotification('~r~~r~Police~s~', '~h~Information véhicule~s~', 'Le véhicule à été mis en fourrière', 'CHAR_CARSITE', 1)
                end
            })
        
        end, function()
        end)

        
        RageUI.IsVisible(demanderenfortpolice, function()

            RageUI.Separator("↓ Demande de renfort ↓")

            RageUI.Button("→ Petite demande", "Vous permet de faire une petite demande de renfort", {RightLabel = "→→→"}, true, {
                onSelected = function()
                    TriggerServerEvent("ronflex:demandederenfort", "petite")
                end
            })

            RageUI.Button("→ Importante demande", "Vous permet de faire une demande de renfort importante", {RightLabel = "→→→"}, true, {
                onSelected = function()
                    TriggerServerEvent("ronflex:demandederenfort", "important")
                end
            })

            RageUI.Button("→ Code 99", "Vous permet de faire une allerte d'urgence", {RightLabel = "→→→"}, true, {
                onSelected = function()
                    TriggerServerEvent("ronflex:demandederenfort", "rouge")
                end
            })

            RageUI.Separator("↓ Codes radio ↓")

            RageUI.Button("→ Pause de service", "Vous permet de faire une allerte de pause de service", {RightLabel = "→→→"}, true, {
                onSelected = function()
                    TriggerServerEvent("ronflex:demandederenfort", "pause")
                end
            })

            RageUI.Button("→ Controle en cours", "Vous permet de faire une allerte de controle ", {RightLabel = "→→→"}, true, {
                onSelected = function()
                    TriggerServerEvent("ronflex:demandederenfort", "control")
                end
            })

            RageUI.Button("→ Retour au commisariat", "Vous permet de faire une allerte de retour au PDP ", {RightLabel = "→→→"}, true, {
                onSelected = function()
                    TriggerServerEvent("ronflex:demandederenfort", "retrourpdp")
                end
            })

        end)


        RageUI.IsVisible(casierjudiciairepolice, function()
            
            RageUI.Button("→ Votre Matricule", nil, {RightLabel = PoliceMenu.Matricule}, true, {
                onSelected = function()
                    local matricule = KeyboardInput("Indiquer votre matricule", "Indiquer votre matricule", "", 20)
                    if matricule then 
                        PoliceMenu.Matricule = matricule
                        CasierPolice.matricule = matricule
                        PoliceMenu.MatriculeKey = true 
                    end
                end
            })

            RageUI.Button("→ Nom/Prénom de l'individu", nil, {RightLabel = PoliceMenu.NamePrename}, PoliceMenu.MatriculeKey, {
                onSelected = function()
                    local nameprename = KeyboardInput("Indiquer le nom et prenom de l'individu", "Indiquer le nom et prenom de l'individu", "", 80)
                    if nameprename then 
                        PoliceMenu.NamePrename = "~g~Définie"
                        CasierPolice.nameprename = nameprename
                        PoliceMenu.NamePrenameKey = true 
                    end
                end
            })

            RageUI.Button("→ Raison de l'arrestation", nil, {RightLabel = PoliceMenu.ReasonArrestation}, PoliceMenu.NamePrenameKey, {
                onSelected = function()
                    local reason = KeyboardInput("Indiquer la raison de l'arrestation", "Indiquer la raison de l'arrestation", "", 200)
                    if reason then 
                        PoliceMenu.ReasonArrestation = "~g~Définie"
                        CasierPolice.reason = reason
                        PoliceMenu.ReasonArrestationKey = true 
                    end
                end
            })

            RageUI.Button("→ Temps mis en cellule", nil, {RightLabel = PoliceMenu.TimePrison}, PoliceMenu.ReasonArrestationKey, {
                onSelected = function()
                    local timecellule = KeyboardInput("Indiquer le temps mis en prison", "Indiquer le temps mis en prison", "", 200)
                    if timecellule then 
                        PoliceMenu.TimePrison = "~g~Définie"
                        CasierPolice.timecellule = timecellule
                        PoliceMenu.TimePrisonKey = true 
                    end
                end
            })

            RageUI.Button("→ Valider le casier", nil, {RightLabel = "→→→"}, PoliceMenu.TimePrisonKey, {
                onSelected = function()
                    TriggerServerEvent("ronflex:newcasierpolice", CasierPolice)
                end
            })
        
        end)

        RageUI.IsVisible(miseenprisonpolice, function()

            RageUI.Button("→ Cellule 1", "Mettre en prison dans la cellule 1", {RightLabel = "→→→"}, true, {
                onActive = function()
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                    if closestPlayer ~= -1 and closestDistance <= 3.0 then
                        PlayerMarker(closestPlayer)
                    end
                end, 
                onSelected = function()
                    local verif, timer = CheckQuantity(KeyboardInput("Indiquer le temps de prison", "Indiquer le temps de prison", "", 20))
                    if verif then 
                        local player, distance = ESX.Game.GetClosestPlayer()
                        if distance ~= -1 and distance <= 3.0 then
                            TriggerServerEvent('ronflex:miseencelule', GetPlayerServerId(player), timer, "1")
                        else
                            ESX.ShowNotification('~r~Aucun joueur~s~ à proximité')
                        end
                    end
                    
                end
            })
      
            RageUI.Button("→ Cellule 2", "Mettre en prison dans la cellule 1", {RightLabel = "→→→"}, true, {
                onActive = function()
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                    if closestPlayer ~= -1 and closestDistance <= 3.0 then
                        PlayerMarker(closestPlayer)
                    end
                end, 
                onSelected = function()
                    local verif, timer = CheckQuantity(KeyboardInput("Indiquer le temps de prison", "Indiquer le temps de prison", "", 20))
                    if verif then 
                        local player, distance = ESX.Game.GetClosestPlayer()
                        if distance ~= -1 and distance <= 3.0 then
                            TriggerServerEvent('ronflex:miseencelule', GetPlayerServerId(player), timer, "2")
                        else
                            ESX.ShowNotification('~r~Aucun joueur~s~ à proximité')
                        end
                    end
                    
                end

            })

            RageUI.Button("→ Cellule 3", "Mettre en prison dans la cellule 1", {RightLabel = "→→→"}, true, {
                onActive = function()
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                    if closestPlayer ~= -1 and closestDistance <= 3.0 then
                        PlayerMarker(closestPlayer)
                    end
                end, 
                onSelected = function()
                    local verif, timer = CheckQuantity(KeyboardInput("Indiquer le temps de prison", "Indiquer le temps de prison", "", 20))
                    if verif then 
                        local player, distance = ESX.Game.GetClosestPlayer()
                        if distance ~= -1 and distance <= 3.0 then
                            TriggerServerEvent('ronflex:miseencelule', GetPlayerServerId(player), timer, "3")
                        else
                            ESX.ShowNotification('~r~Aucun joueur~s~ à proximité')
                        end
                    end
                    
                end
            })
        
        end, function()
        end)

        if not RageUI.Visible(mainmenupolice) and
        not RageUI.Visible(interactioncitoyenspolice) and 
        not RageUI.Visible(interactionvehiculepolice) and
        not RageUI.Visible(casierjudiciairepolice) and
        not RageUI.Visible(miseenprisonpolice) and 
        not RageUI.Visible(demanderenfortpolice) then 
            mainmenupolice = RMenu:DeleteType('mainmenupolice')
        end
    end
end


RegisterNetEvent("ronflex:demandederenfort", function(type, coords)
    if type == "petite" then
        PlaySoundFrontend(-1,"Lose_1st", "GTAO_Magnate_Boss_Modes_Soundset", false); 
        local blipId = AddBlipForCoord(coords)
        SetBlipSprite(blipId, 161)
        SetBlipScale(blipId, 0.7)
        SetBlipColour(blipId, 2)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('~g~Demande renfort')
        EndTextCommandSetBlipName(blipId)
        Wait(80 * 1000)
        RemoveBlip(blipId)
    elseif type == 'important' then 
        local blipId = AddBlipForCoord(coords)
        SetBlipSprite(blipId, 161)
        SetBlipScale(blipId, 0.7)
        SetBlipColour(blipId, 47)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('~o~Demande renfort')
        EndTextCommandSetBlipName(blipId)
        Wait(80 * 1000)
        RemoveBlip(blipId)
    elseif type == 'rouge' then 
        PlaySoundFrontend(-1, "police_notification", "DLC_AS_VNT_Sounds", true);
        local blipId = AddBlipForCoord(coords)
        SetBlipSprite(blipId, 161)
        SetBlipScale(blipId, 0.7)
        SetBlipColour(blipId, 1)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('~r~Demande renfort')
        EndTextCommandSetBlipName(blipId)
        Wait(80 * 1000)
        RemoveBlip(blipId)
    end
end)

Keys.Register("F6", "Menu_Police", "Menu Intéraction police", function()
    if ESX.PlayerData.job.name == "police" then 
        OpenMenuPolice()
    end
end)


RegisterNetEvent("ronflex:recieveagentpolice")
AddEventHandler("ronflex:recieveagentpolice", function(count)
    PoliceMenu.AgentInService = count
end)


RegisterNetEvent('police:OutVehicle')
AddEventHandler('police:OutVehicle', function()
	local plyPed = PlayerPedId()

	if not IsPedSittingInAnyVehicle(plyPed) then
		return
	end

	DetachEntity(plyPed, true, false)
	local vehicle = GetVehiclePedIsIn(plyPed, false)
	TaskLeaveVehicle(plyPed, vehicle, 16)
end)


RegisterNetEvent('police:putInVehicle')
AddEventHandler('police:putInVehicle', function()
	local plyPed = PlayerPedId()
	local coords = GetEntityCoords(plyPed, false)

    if IsAnyVehicleNearPoint(coords, 5.0) then
		local vehicle = GetClosestVehicle(coords, 5.0, 0, 71)

		if DoesEntityExist(vehicle) then
			local maxSeats = GetVehicleMaxNumberOfPassengers(vehicle)
			local freeSeat = nil

			for i = maxSeats - 1, 0, -1 do
				if IsVehicleSeatFree(vehicle, i) then
					freeSeat = i
					break
				end
			end

			if freeSeat ~= nil then
				DetachEntity(plyPed, true, false)
				TaskWarpPedIntoVehicle(plyPed, vehicle, freeSeat)
			end
		end
	end
end)


RegisterNetEvent('esx_policejob:drag')
AddEventHandler('esx_policejob:drag', function(draggerId)
    DragStatus.isDragged = not DragStatus.isDragged
    DragStatus.dragger = tonumber(draggerId)

    if not DragStatus.isDragged then
        DetachEntity(PlayerPedId(), true, false)
    end
end)

CreateThread(function()
    while true do
        Wait(0)
        local plyPed = PlayerPedId()

        if DragStatus.isDragged then
            local target = GetPlayerFromServerId(DragStatus.dragger)

            if target ~= PlayerId() and target > 0 then
                local targetPed = GetPlayerPed(target)

                if not IsPedSittingInAnyVehicle(targetPed) then
                    AttachEntityToEntity(plyPed, targetPed, 11816, 0.54, 0.54, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
                else
                    DragStatus.isDragged = false
                    DetachEntity(plyPed, true, false)
                end
            else
                Wait(500)
            end
        else
            Wait(500)
        end
    end
end)







OpenFouillePolice = function(closestPlayer)
    local mainfouille = RageUI.CreateMenu("Fouille", "Voici l'inventaire du joueur")

    RageUI.Visible(mainfouille, not RageUI.Visible(mainfouille))
    InventoryLoad = false 

    ESX.TriggerServerCallback("ronfex:fouillepolicecb", function(data)
        weaponplayer = data.weapon 
        inventoryplayer = data.inventory
        InventoryLoad = true 
    end, GetPlayerServerId(closestPlayer))    

    while mainfouille do
        Wait(0)

        RageUI.IsVisible(mainfouille, function()

            if InventoryLoad == false then 
                RageUI.Separator("")
                RageUI.Separator("~r~Récupération des données")
                RageUI.Separator("")
            else
                RageUI.Separator("↓ Items ↓")
                for k, v in pairs(inventoryplayer) do 
                    if v.count > 0 then 
                        RageUI.Button("→ "..v.label.." ["..v.count.."]", nil, {RightLabel = "~r~Récupérer"}, true, {
                            onSelected = function()
                                local verif, count = CheckQuantity(KeyboardInput("Combien voulez vous en prendre", "Combien voulez vous en prendre", "", 20))
                                if verif then 
                                    TriggerServerEvent("ronflex:confiscateitem", count, v.name, GetPlayerServerId(closestPlayer), "item")
                                    Wait(50)
                                    ESX.TriggerServerCallback("ronfex:fouillepolicecb", function(data)
                                        weaponplayer = data.weapon 
                                        inventoryplayer = data.inventory
                                        InventoryLoad = true 
                                    end, GetPlayerServerId(closestPlayer))    
                                end
                            end
                        })
                    end
   
                end

                RageUI.Separator("↓ Armes ↓")
                for k, v in pairs(weaponplayer) do
                    RageUI.Button("→ "..tostring(v.label).."", nil, {RightLabel = "~r~Récupérer"}, false, {
                        onSelected = function()
                            TriggerServerEvent("ronflex:confiscateitem", nil, v.name, GetPlayerServerId(closestPlayer), "weapon", v.label)
                            Wait(50)
                            ESX.TriggerServerCallback("ronfex:fouillepolicecb", function(data)
                                weaponplayer = data.weapon 
                                inventoryplayer = data.inventory
                                InventoryLoad = true 
                            end, GetPlayerServerId(closestPlayer))   
                        end
                    })
                end
            
            end
        end)

        if not RageUI.Visible(mainfouille) then 
            mainfouille = RMenu:DeleteType('mainfouille')
            OpenMenuPolice()
        end

    end
end