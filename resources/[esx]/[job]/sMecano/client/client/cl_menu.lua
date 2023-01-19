
-- Développeur Seeker#0009 CopyRight Atlanta RolePlay



Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
    end
    while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
    end
    if ESX.IsPlayerLoaded() then

		ESX.PlayerData = ESX.GetPlayerData()

    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)


RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)


-- MENU FUNCTION --

local open = false 
local mainMenu7 = RageUI.CreateMenu('', 'Interaction')
local subMenu8 = RageUI.CreateSubMenu(mainMenu7, "", "Interaction")
local subMenu9 = RageUI.CreateSubMenu(mainMenu7, "", "Interaction")
local subMenu10 = RageUI.CreateSubMenu(mainMenu7, "", "Interaction")
local subMenu11 = RageUI.CreateSubMenu(mainMenu7, "", "Interaction")
mainMenu7.Display.Header = true 
mainMenu7.Closed = function()
  open = false
end

OpenMenumechanic = function()
	if open then 
		open = false
		RageUI.Visible(mainMenu7, false)
		return
	else
		open = true 
		RageUI.Visible(mainMenu7, true)
		CreateThread(function()
		while open do 
		   RageUI.IsVisible(mainMenu7,function() 


			RageUI.Checkbox("Prendre votre service", nil, servicemechanic, {}, {
                onChecked = function(index, items)
                    servicemechanic = true
					ESX.ShowNotification("~g~Vous avez pris votre service !")
                end,
                onUnChecked = function(index, items)
                    servicemechanic = false
					ESX.ShowNotification("~r~Vous avez quitter votre service !")
                end
            })

			if servicemechanic then
				RageUI.Separator("Grade : ~r~"..ESX.PlayerData.job.grade_label.."") 
				RageUI.Separator("Métier : ~r~"..ESX.PlayerData.job.label.."") 
			RageUI.Button("→ Annonces", nil, {RightLabel = "→→→"}, true , {
				onActive = function()
					RageUI.Info("Gestion", {"Type : ~r~Annonces~w~"}, {})
				end, 
				onSelected = function()
				end
			}, subMenu8)

			RageUI.Button("→ Intéractions", nil, {RightLabel = "→→→"}, true , {
				onActive = function()
					RageUI.Info("Gestion", {"Type : ~r~Intéractions~w~"}, {})
				end, 
				onSelected = function()
				end
			}, subMenu9)

			RageUI.Button("→ Intéractions Véhicules", nil, {RightLabel = "→→→"}, true , {
				onActive = function()
					RageUI.Info("Gestion", {"Type : ~r~Intéractions Véhicules~w~"}, {})
				end, 
				onSelected = function()
				end
			}, subMenu11)

			RageUI.Button("→ Points", nil, {RightLabel = "→→→"}, true , {
				onActive = function()
					RageUI.Info("Gestion", {"Type : ~r~Points~w~"}, {})
				end, 
				onSelected = function()
				end
			}, subMenu10)

		end
			end)

			RageUI.IsVisible(subMenu8,function() 

				RageUI.Button("→ Ouverture", nil, {RightLabel = "→→→"}, true , {
					onActive = function()
						RageUI.Info("Gestion", {"Type : ~r~Annonces~w~", "Utilité : ~r~Annonce d'ouverture ~w~"}, {})
					end,
					onSelected = function()
						TriggerServerEvent('Ouvre:mechanic')
					end
				})
	
				RageUI.Button("→ Fermeture", nil, {RightLabel = "→→→"}, true , {
					onActive = function()
						RageUI.Info("Gestion", {"Type : ~r~Annonces~w~", "Utilité : ~r~Annonce de fermeture ~w~"}, {})
					end,
					onSelected = function()
						TriggerServerEvent('Ferme:mechanic')
					end
				})

		end)
				
				RageUI.IsVisible(subMenu9,function()
					
					RageUI.Separator("Grade : ~r~"..ESX.PlayerData.job.grade_label.."") 

					RageUI.Button("→ Facturer", nil, {RightLabel = "→→→"}, true , {
						onActive = function()
							RageUI.Info("Gestion", {"Type : ~r~Facturation~w~", "Utilité : ~r~Facturer Joueur ~w~"}, {})
						end,
						onSelected = function()
							local player, distance = ESX.Game.GetClosestPlayer()
								local raison = ""
								local montant = 0
								AddTextEntry("FMMC_MPM_NA", "Raison de la facture")
								DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "Donnez une raison de la facture:", "", "", "", "", 30)
								while (UpdateOnscreenKeyboard() == 0) do
									DisableAllControlActions(0)
									Wait(0)
								end
								if (GetOnscreenKeyboardResult()) then
									local result = GetOnscreenKeyboardResult()
									if result then
										raison = result
										result = nil
										AddTextEntry("FMMC_MPM_NA", "Montant de la facture")
										DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "Donnez le montant de la facture:", "", "", "", "", 30)
										while (UpdateOnscreenKeyboard() == 0) do
											DisableAllControlActions(0)
											Wait(0)
										end
										if (GetOnscreenKeyboardResult()) then
											result = GetOnscreenKeyboardResult()
											if result then
												montant = result
												result = nil
												if player ~= -1 and distance <= 3.0 then
													TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(player), 'society_mechanic', ('mechanic'), montant)
													TriggerEvent('esx:showAdvancedNotification', 'Fl~g~ee~s~ca ~g~Banque', 'Facture envoyée : ', 'Vous avez envoyé une facture de : ~r~'..montant.. ' $ ~s~pour : ~r~' ..raison.. '', 'CHAR_BANK_FLEECA', 9)
												else
													ESX.ShowNotification("~r~Problèmes~s~: Aucun joueur à proximitée")
												end
											end
										end
										
								  --  end
								end
								end
						end
					})


		   end)

		   RageUI.IsVisible(subMenu10,function() 

			RageUI.Separator("Grade : ~r~"..ESX.PlayerData.job.grade_label.."") 

			RageUI.Button("→ Récolte", nil, {RightLabel = "→→→"}, true , {
				onActive = function()
					RageUI.Info("Gestion", {"Type : ~r~Farm~w~", "Utilité : ~r~Gagner de l'argent seul ~w~"}, {})
				end,
				onSelected = function()
					SetNewWaypoint(1189.44, -3108.60)
				end
			})

			RageUI.Button("→ Traitement", nil, {RightLabel = "→→→"}, true , {
				onActive = function()
					RageUI.Info("Gestion", {"Type : ~r~Farm~w~", "Utilité : ~r~Gagner de l'argent seul ~w~"}, {})
				end,
				onSelected = function()
					SetNewWaypoint(473.88, -1952.02) 
				end
			})

			RageUI.Button("→ Vente", nil, {RightLabel = "→→→"}, true , {
				onActive = function()
					RageUI.Info("Gestion", {"Type : ~r~Farm~w~", "Utilité : ~r~Gagner de l'argent seul ~w~"}, {})
				end,
				onSelected = function()
					SetNewWaypoint(739.52, -546.27)
				end
			})

		end)

		RageUI.IsVisible(subMenu11,function() 

			RageUI.Separator("Grade : ~r~"..ESX.PlayerData.job.grade_label.."") 

			RageUI.Button("→ Réparer le véhicule", nil, {RightLabel = "→→→"}, true, {
				onActive = function()
					RageUI.Info("Gestion", {"Type : ~r~Réparation~w~", "Utilité : ~r~Réparer un véhicule~w~"}, {})
				end,
				onSelected = function()
					local playerPed = PlayerPedId()
					local vehicle   = ESX.Game.GetVehicleInDirection()
					local coords    = GetEntityCoords(playerPed)
		
					if IsPedSittingInAnyVehicle(playerPed) then
						ESX.ShowNotification('Veuillez descendre de la voiture.')
						return
					end
		
					if DoesEntityExist(vehicle) then
						isBusy = true
						TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_BUM_BIN', 0, true)
						Citizen.CreateThread(function()
							Citizen.Wait(20000)
		
							SetVehicleFixed(vehicle)
							SetVehicleDeformationFixed(vehicle)
							SetVehicleUndriveable(vehicle, false)
							SetVehicleEngineOn(vehicle, true, true)
							ClearPedTasksImmediately(playerPed)
		
							ESX.ShowNotification('la voiture est correctement réparer')
							isBusy = false
						end)
					else
						ESX.ShowNotification('Aucun véhicule à proximiter')
					end
		 
				end,}) 
				
				RageUI.Button("→ Nettoyer véhicule", nil, {RightLabel = "→→→"}, true , {
					onActive = function()
						RageUI.Info("Gestion", {"Type : ~r~Nettoyage~w~", "Utilité : ~r~Nettoyer un véhicule~w~"}, {})
					end,
					onSelected = function()
						local playerPed = PlayerPedId()
						local vehicle   = ESX.Game.GetVehicleInDirection()
						local coords    = GetEntityCoords(playerPed)
			
						if IsPedSittingInAnyVehicle(playerPed) then
							ESX.ShowNotification('Veuillez sortir de la voiture?')
							return
						end
			
						if DoesEntityExist(vehicle) then
							isBusy = true
							TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_MAID_CLEAN', 0, true)
							Citizen.CreateThread(function()
								Citizen.Wait(10000)
			
								SetVehicleDirtLevel(vehicle, 0)
								ClearPedTasksImmediately(playerPed)
			
								ESX.ShowNotification('Voiture néttoyé')
								isBusy = false
							end)
						else
							ESX.ShowNotification('Aucun véhicule trouvée')
						end
						end,})
						
				   RageUI.Button("→ Mettre véhicule en fourriere", nil, {RightLabel = "→→→"}, true , {
					onActive = function()
						RageUI.Info("Gestion", {"Type : ~r~Fourrière~w~", "Utilité : ~r~Mettre véhicule en fourrière ~w~"}, {})
					end,
					onSelected = function()
						local playerPed = PlayerPedId()

						if IsPedSittingInAnyVehicle(playerPed) then
							local vehicle = GetVehiclePedIsIn(playerPed, false)
			
							if GetPedInVehicleSeat(vehicle, -1) == playerPed then
								ESX.ShowNotification('la voiture a été mis en fourrière')
								ESX.Game.DeleteVehicle(vehicle)
							   
							else
								ESX.ShowNotification('Mais toi place conducteur, ou sortez de la voiture.')
							end
						else
							local vehicle = ESX.Game.GetVehicleInDirection()
			
							if DoesEntityExist(vehicle) then
								ESX.ShowNotification('La voiture à été placer en fourriere.')
								ESX.Game.DeleteVehicle(vehicle)
			
							else
								ESX.ShowNotification('Aucune voitures autours')
							end
						end
				end,})


				
		
				RageUI.Button("→ Crocheter véhicule", nil, {RightLabel = "→→→"}, true , {
					onActive = function()
						RageUI.Info("Gestion", {"Type : ~r~Crochetage~w~", "Utilité : ~r~Ouvrir un véhicule ~w~"}, {})
					end,
				onSelected = function()
						local playerPed = PlayerPedId()
						local vehicle = ESX.Game.GetVehicleInDirection()
						local coords = GetEntityCoords(playerPed)
			
						if IsPedSittingInAnyVehicle(playerPed) then
							ESX.ShowNotification('Action impossible')
							return
						end
			
						if DoesEntityExist(vehicle) then
							isBusy = true
							TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_WELDING', 0, true)
							Citizen.CreateThread(function()
								Citizen.Wait(10000)
			
								SetVehicleDoorsLocked(vehicle, 1)
								SetVehicleDoorsLockedForAllPlayers(vehicle, false)
								ClearPedTasksImmediately(playerPed)
			
								ESX.ShowNotification('Véhicule dévérouiller')
								isBusy = false
							end)
						else
							ESX.ShowNotification('Pas de véhicules à proximité')
						end
				end,})

			end)

		 Wait(0)
		end
	 end)
  end
end

-- OUVERTURE DU MENU --

Keys.Register('F6', 'mechanic', 'Ouvrir le menu mechanic', function()
	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'mechanic' then
		if open == false then 
    	OpenMenumechanic()
		end
	end
end)

--- BLIPS Seeker#0009 ---

Citizen.CreateThread(function()

    local blip = AddBlipForCoord(-205.77, -1310.05, 31.3)

    SetBlipSprite (blip, 446) -- Model du blip
    SetBlipDisplay(blip, 4)
    SetBlipScale  (blip, 0.7) -- Taille du blip
    SetBlipColour (blip, 47) -- Couleur du blip
    SetBlipAsShortRange(blip, true)

    BeginTextCommandSetBlipName('STRING')
    AddTextComponentSubstringPlayerName('~r~Entreprises ~w~| Mécano') -- Nom du blip
    EndTextCommandSetBlipName(blip)
end)