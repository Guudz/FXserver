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
local unicornDeTesMort = RageUI.CreateMenu('', 'Garage Unicorn')
unicornDeTesMort.Display.Header = true 
unicornDeTesMort.Closed = function()
  open = false
end

function OpenTesMortunicorn()
     if open then 
         open = false
         RageUI.Visible(unicornDeTesMort, false)
         return
     else
         open = true 
         RageUI.Visible(unicornDeTesMort, true)
         CreateThread(function()
         while open do 
            RageUI.IsVisible(unicornDeTesMort,function() 


               RageUI.Separator("")

                RageUI.Button("Véhicule de travaille", nil, {RightLabel = "→→"}, true , {
                  onActive = function()
                    RageUI.Info("Garage Unicorn", {"Type : ~r~Garage Véhicule~w~", "Modèle : ~r~Schafter~w~"}, {})
                  end, 
                    onSelected = function()
                      local model = GetHashKey("schafter2")
                      RequestModel(model)
                      while not HasModelLoaded(model) do Citizen.Wait(10) end
                      local pos = GetEntityCoords(PlayerPedId())
                      local vehicle = CreateVehicle(model, 144.64, -1287.7, 28.7, 120.33, true, true)
                    end
                })

                RageUI.Button("Ranger", nil, {RightLabel = "→→"}, true , {
                  onActive = function()
                    RageUI.Info('Garage Unicorn', {"Type : ~r~Rangement~w~"}, {})
                    end,
                  onSelected = function()
                    local veh,dist4 = ESX.Game.GetClosestVehicle(playerCoords)
                    if dist4 < 4 then
                        DeleteEntity(veh)
                        RageUI.CloseAll()
                  end
                end, })

           end)
          Wait(0)
         end
      end)
   end
end

----OUVRIR LE MENU------------

local position = {
	{x = 145.0, y = -1290.74, z = 29.35}
}

Citizen.CreateThread(function()
    while true do

      local wait = 750

        for k in pairs(position) do
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'unicorn' then 
            local plyCoords = GetEntityCoords(PlayerPedId(), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, position[k].x, position[k].y, position[k].z)

            if dist <= 15.0 then
            wait = 0
            DrawMarker(36, 145.0, -1290.74, 29.35, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.3, 0.3, 0.3, 255, 255, 59, 255, true, true, p19, true)  

        
            if dist <= 1.0 then
               wait = 0
                Visual.Subtitle("Appuyer sur ~r~[E]~s~ pour intéragir", 1) 
                if IsControlJustPressed(1,51) then
                  OpenTesMortunicorn()
            end
        end
    end
    end
    Citizen.Wait(wait)
    end
end
end)


