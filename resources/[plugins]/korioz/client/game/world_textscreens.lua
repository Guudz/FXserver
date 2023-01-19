--[[ Main ]]--
local textscreens = {
	{
		coords = vector3(-790.2898, -2046.571, 12.48528),
		text = "Bienvenue sur ~r~LystyLifeRôleplay~s~ !\ndiscord.gg/~r~LystyLiferp",
		size = 0.7,
		font = 0,
		maxDistance = 10
	}
}

AddEventHandler('korioz:init', function()
	Citizen.CreateThread(function()
		while true do
			local PlayerCoords = LocalPlayer().Coords

			for i = 1, #textscreens, 1 do
				if #(PlayerCoords - textscreens[i].coords) < textscreens[i].maxDistance then
					ESX.Game.Utils.DrawText3D(textscreens[i].coords, textscreens[i].text, textscreens[i].size, textscreens[i].font)
				end
			end

			Citizen.Wait(0)
		end
	end)
end)