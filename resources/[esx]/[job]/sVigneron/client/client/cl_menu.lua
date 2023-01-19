
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
mainMenu7.Display.Header = true 
mainMenu7.Closed = function()
  open = false
end

OpenMenuvigne = function()
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


			RageUI.Checkbox("Prendre votre service", nil, servicevigne, {}, {
                onChecked = function(index, items)
                    servicevigne = true
					ESX.ShowNotification("~g~Vous avez pris votre service !")
                end,
                onUnChecked = function(index, items)
                    servicevigne = false
					ESX.ShowNotification("~r~Vous avez quitter votre service !")
                end
            })

			if servicevigne then
				RageUI.Separator("Grade : ~r~"..ESX.PlayerData.job.grade_label.."") 
				RageUI.Separator("Métier : ~r~"..ESX.PlayerData.job.label.."") 
			RageUI.Button("→ Annonces", nil, {RightLabel = "→→→"}, true , {
				onActive = function()
					RageUI.Info("Gestion Vigneron", {"Type : ~r~Annonces~w~"}, {})
				end, 
				onSelected = function()
				end
			}, subMenu8)

			RageUI.Button("→ Intéractions", nil, {RightLabel = "→→→"}, true , {
				onActive = function()
					RageUI.Info("Gestion Vigneron", {"Type : ~r~Intéractions~w~"}, {})
				end, 
				onSelected = function()
				end
			}, subMenu9)

		end
			end)

			RageUI.IsVisible(subMenu8,function() 

			 RageUI.Button("→ Ouverture", nil, {RightLabel = "→→→"}, true , {
				onActive = function()
					RageUI.Info("Gestion Vigneron", {"Type : ~g~Ouvert~w~"}, {})
				end, 
				onSelected = function()
					TriggerServerEvent('Ouvre:vigne')
				end
			})

			RageUI.Button("→ Fermeture", nil, {RightLabel = "→→→"}, true , {
				onActive = function()
					RageUI.Info("Gestion Vigneron", {"Type : ~r~Fermer~w~"}, {})
				end, 
				onSelected = function()
					TriggerServerEvent('Ferme:vigne')
				end
			})

			RageUI.Button("→ Recrutement", nil, {RightLabel = "→→→"}, true , {
				onActive = function()
					RageUI.Info("Gestion Vigneron", {"Type : ~y~Recrutement~w~"}, {})
				end, 
				onSelected = function()
					TriggerServerEvent('Recru:vigne')
				end
			})

		end)
				
				RageUI.IsVisible(subMenu9,function()
					
					RageUI.Separator("Grade : ~r~"..ESX.PlayerData.job.grade_label.."") 

					RageUI.Button("→ Récolte", nil, {RightLabel = "→→→"}, true , {
						onSelected = function()
							SetNewWaypoint(-1803.69, 2214.42, 91.43)  
						end
					})
		
					RageUI.Button("→ Traitement", nil, {RightLabel = "→→→"}, true , {
						onSelected = function()
							SetNewWaypoint(-51.86, 1911.27, 195.36) 
						end 
					})
		
					RageUI.Button("→ Vente", nil, {RightLabel = "→→→"}, true , {
						onSelected = function()
							SetNewWaypoint(359.38, -1109.02, 29.41)
						end
					})

					RageUI.Separator()

					RageUI.Button("→ Facturer", nil, {RightLabel = "→→→"}, true , {
						onActive = function()
							RageUI.Info("Gestion Vigneron", {"Type : ~r~Facturation~w~", "Utilité : ~r~Facturer Joueur ~w~"}, {})
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
													TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(player), 'society_vigne', ('vigne'), montant)
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
		 Wait(0)
		end
	 end)
  end
end

-- OUVERTURE DU MENU --

Keys.Register('F6', 'vigne', 'Ouvrir le menu vigne', function()
	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'vigne' then
		if open == false then 
    	OpenMenuvigne()
		end
	end
end)

--- BLIPS Seeker#0009 ---

Citizen.CreateThread(function()

    local blip = AddBlipForCoord(-1889.19, 2046.0, 140.87)

    SetBlipSprite (blip, 616) -- Model du blip
    SetBlipDisplay(blip, 4)
    SetBlipScale  (blip, 0.7) -- Taille du blip
    SetBlipColour (blip, 27) -- Couleur du blip
    SetBlipAsShortRange(blip, true)

    BeginTextCommandSetBlipName('STRING')
    AddTextComponentSubstringPlayerName('~r~Entreprises | ~w~Vigneron') -- Nom du blip
    EndTextCommandSetBlipName(blip)
end)

 