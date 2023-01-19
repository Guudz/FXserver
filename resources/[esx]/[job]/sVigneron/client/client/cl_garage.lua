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
local vigneDeTesMort = RageUI.CreateMenu('', 'Garage Vigneron')
vigneDeTesMort.Display.Header = true 
vigneDeTesMort.Closed = function()
  open = false
end

function OpenTesMortvigne()
     if open then 
         open = false
         RageUI.Visible(vigneDeTesMort, false)
         return
     else
         open = true 
         RageUI.Visible(vigneDeTesMort, true)
         CreateThread(function()
         while open do 
            RageUI.IsVisible(vigneDeTesMort,function() 


               RageUI.Separator("")

               RageUI.Button("Pick-Up", nil, {RightLabel = "→→"}, true , {
                  onActive = function()
                    RageUI.Info("Garage Vigneron", {"Type : ~r~Garage Véhicule~w~", "Modèle : ~r~Pick-Up~w~"}, {})
                  end, 
                    onSelected = function()
                      local model = GetHashKey("bison3")
                      RequestModel(model)
                      while not HasModelLoaded(model) do Citizen.Wait(10) end
                      local pos = GetEntityCoords(PlayerPedId())
                      local vehicle = CreateVehicle(model, -1918.58, 2056.9, 140.74, 253.810, true, true)
                    end
                })

                RageUI.Button("Van", nil, {RightLabel = "→→"}, true , {
                  onActive = function()
                    RageUI.Info("Garage Vigneron", {"Type : ~r~Garage Véhicule~w~", "Modèle : ~r~Van~w~"}, {})
                  end, 
                    onSelected = function()
                      local model = GetHashKey("buritto3")
                      RequestModel(model)
                      while not HasModelLoaded(model) do Citizen.Wait(10) end
                      local pos = GetEntityCoords(PlayerPedId())
                      local vehicle = CreateVehicle(model, -1918.58, 2056.9, 140.74, 253.810, true, true)
                    end
                })

                RageUI.Button("Ranger", nil, {RightLabel = "→→"}, true , {
                  onActive = function()
                    RageUI.Info('Garage Vigneron', {"Type : ~r~Rangement~w~"}, {})
                    end,
                  onSelected = function()
                    local veh,dist4 = ESX.Game.GetClosestVehicle(playerCoords)
                    if dist4 < 8 then
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
	{x = -1919.97, y = 2052.96, z = 140.74}  
}

Citizen.CreateThread(function()
    while true do

      local wait = 750

        for k in pairs(position) do
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'vigne' then 
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, position[k].x, position[k].y, position[k].z)

            if dist <= 4.0 then
            wait = 0
            DrawMarker(22, -1919.97, 2052.96, 140.74, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.3, 0.3, 0.3, 136, 14, 79, 255, true, true, p19, true)  

        
            if dist <= 5.0 then
               wait = 0
                Visual.Subtitle("Appuyez sur [~p~E~w~] pour accéder au garage", 1) 
                if IsControlJustPressed(1,51) then
                  OpenTesMortvigne()
            end
        end
    end
    end
    Citizen.Wait(wait)
    end
end
end)


