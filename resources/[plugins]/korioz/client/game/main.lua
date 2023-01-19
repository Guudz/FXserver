AddEventHandler('korioz:init', function()
	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(750)
			local Player = LocalPlayer()
			DisablePlayerVehicleRewards(Player.ID)
			SetPlayerHealthRechargeMultiplier(Player.ID, 0.0)
			SetRunSprintMultiplierForPlayer(Player.ID, 1.0)
			SetSwimMultiplierForPlayer(Player.ID, 1.0)
			if Player.IsDriver then
				SetPlayerCanDoDriveBy(Player.ID, false)
			else
				SetPlayerCanDoDriveBy(Player.ID, true)
			end
			if GetPlayerWantedLevel(Player.ID) ~= 0 then
				ClearPlayerWantedLevel(Player.ID)
			end
		end
	end)

	Citizen.CreateThread(function()
		while true do
			local Player = LocalPlayer()
			
			AddTextEntry('FE_THDR_GTAO', ('~r~LystyLife~ w~Rôleplay | Votre ID : ~r~%s~w~ | Pseudo : ~r~%s~w~'):format(Player.ServerID, Player.Name))
			AddTextEntry('PM_PANE_KEYS', '~r~Configuration des touches')
			AddTextEntry('PM_PANE_AUD', '~r~Audio & Son')
			AddTextEntry('PM_PANE_GTAO', '~r~Touches Basique')
			AddTextEntry('PM_PANE_CFX', '~r~LystyLife~w~Rôleplay')
			
			ReplaceHudColourWithRgba(116, 255, 118, 148, 255)
			SetDiscordAppId(838805410437005342)
			SetDiscordRichPresenceAsset('LystyLifenew')
			SetDiscordRichPresenceAssetText('LystyLifeRôleplay')
			SetDiscordRichPresenceAssetSmall('')
			SetDiscordRichPresenceAssetSmallText('.gg/LystyLife')
			SetRichPresence(("%s [%s]"):format(Player.Name, Player.ServerID))
			SetDiscordRichPresenceAction(0, "💙 DISCORD", "https://discord.gg/LystyLife")
			SetDiscordRichPresenceAction(1, "🌊 SE CONNECTER", "fivem://connect/xop4o5")
			Citizen.Wait(30000)
		end
	end)
end)