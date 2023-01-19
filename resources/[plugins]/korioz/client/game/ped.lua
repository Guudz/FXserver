--[[ Ped ]]--
AddEventHandler('korioz:init', function()
	Citizen.CreateThread(function()
		local wait = 15
		local count = 60

		while true do
			local Player = LocalPlayer()

			SetPedConfigFlag(Player.Ped, 35, false)
			SetPedConfigFlag(Player.Ped, 149, true)
			SetPedConfigFlag(Player.Ped, 438, true)

			if Player.Fighting then
				if Player.Health < 115 then
					ESX.ShowNotification("~r~LystyLifeRôleplay~s~\nTu viens de te faire assomé ! Patiente un peux.")
					wait = 15
					Player.KO = true
					SetEntityHealth(Player.Ped, 116)
				end
			end

			if Player.KO then
				SetPlayerInvincible(Player.ID, true)
				DisablePlayerFiring(Player.ID, true)
				SetPedToRagdoll(Player.Ped, 1000, 1000, 0, 0, 0, 0)
				ResetPedRagdollTimer(Player.Ped)
					
				if wait >= 0 then
					count = count - 1

					if count == 0 then
						count = 60
						wait = wait - 1
						SetEntityHealth(Player.Ped, GetEntityHealth(Player.Ped) + 4)
					end
				else
					SetPlayerInvincible(Player.ID, false)
					Player.KO = false
				end
			end

			Citizen.Wait(0)
		end
	end)
end)