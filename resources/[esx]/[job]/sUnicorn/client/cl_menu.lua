
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

OpenMenuUnicorn = function()
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


			RageUI.Checkbox("Prendre votre service", nil, serviceunicorn, {}, {
                onChecked = function(index, items)
                    serviceunicorn = true
					ESX.ShowNotification("~g~Vous avez pris votre service !")
                end,
                onUnChecked = function(index, items)
                    serviceunicorn = false
					ESX.ShowNotification("~r~Vous avez quitter votre service !")
                end
            })

			if serviceunicorn then
				RageUI.Separator("Grade : ~r~"..ESX.PlayerData.job.grade_label.."") 
				RageUI.Separator("Métier : ~r~"..ESX.PlayerData.job.label.."") 
			RageUI.Button("→ Annonces", nil, {RightLabel = "→→→"}, true , {
				onActive = function()
					RageUI.Info("Gestion Unicorn", {"Type : ~r~Annonces~w~"}, {})
				end, 
				onSelected = function()
				end
			}, subMenu8)

			RageUI.Button("→ Intéractions", nil, {RightLabel = "→→→"}, true , {
				onActive = function()
					RageUI.Info("Gestion Unicorn", {"Type : ~r~Intéractions~w~"}, {})
				end, 
				onSelected = function()
				end
			}, subMenu9)

		end
			end)

			RageUI.IsVisible(subMenu8,function() 

			 RageUI.Button("→ Ouverture", nil, {RightLabel = "→→→"}, true , {
				onActive = function()
					RageUI.Info("Gestion Unicorn", {"Type : ~g~Ouvert~w~"}, {})
				end, 
				onSelected = function()
					ESX.ShowAdvancedNotification('Unicorn', '~r~Annonce', '~g~L\'Unicorn est désormais ouvert vient te faire plaisir chez nous !', 'CHAR_JOE', 8)
				end
			})

			RageUI.Button("→ Fermeture", nil, {RightLabel = "→→→"}, true , {
				onActive = function()
					RageUI.Info("Gestion Unicorn", {"Type : ~r~Fermer~w~"}, {})
				end, 
				onSelected = function()
					ESX.ShowAdvancedNotification('Unicorn', '~r~Annonce', '~r~L\'Unicorn est désormais fermé à plus tard !', 'CHAR_JOE', 8)
				end
			})

			RageUI.Button("→ Recrutement", nil, {RightLabel = "→→→"}, true , {
				onActive = function()
					RageUI.Info("Gestion Unicorn", {"Type : ~y~Recrutement~w~"}, {})
				end, 
				onSelected = function()
				ESX.ShowAdvancedNotification('Unicorn', '~r~Annonce', '~y~Recrutement en cours, rendez-vous a l\'unicorn!', 'CHAR_JOE', 8)
				end
			})

		end)
				
				RageUI.IsVisible(subMenu9,function()
					
					RageUI.Separator("Grade : ~r~"..ESX.PlayerData.job.grade_label.."") 

					RageUI.Button("→ Point Achat", nil, {RightLabel = "→→→"}, true , {
						onActive = function()
							RageUI.Info("Gestion Unicorn", {"Type : ~r~Point Achat~w~", "Utilité : ~r~Magasin Boisson ~w~"}, {})
						end, 
						onSelected = function()
							SetNewWaypoint(980.89, -1705.84, 31.12)  
						end
					})

					RageUI.Button("→ Facturer", nil, {RightLabel = "→→→"}, true , {
						onActive = function()
							RageUI.Info("Gestion Unicorn", {"Type : ~r~Facturation~w~", "Utilité : ~r~Facturer Joueur ~w~"}, {})
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
													TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(player), 'society_taxi', ('taxi'), montant)
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

Keys.Register('F6', 'unicorn', 'Ouvrir le menu unicorn', function()
	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'unicorn' then
		if open == false then 
    	OpenMenuUnicorn()
		end
	end
end)

--- BLIPS Seeker#0009 ---

Citizen.CreateThread(function()

	local blip = AddBlipForCoord(128.03, -1296.75, 29.26) 
  
	SetBlipSprite (blip, 121)
	SetBlipDisplay(blip, 4)
	SetBlipScale  (blip, 0.9)
	SetBlipColour (blip, 7) 
	SetBlipAsShortRange(blip, true)
  
	BeginTextCommandSetBlipName('STRING')
	AddTextComponentSubstringPlayerName('Vanilla Unicorn')
	EndTextCommandSetBlipName(blip)
  end)