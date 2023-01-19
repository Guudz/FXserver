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
local taxiDeTesMort = RageUI.CreateMenu('', 'Garage taxi')
taxiDeTesMort.Display.Header = true 
taxiDeTesMort.Closed = function()
  open = false
end

function OpenTesMorttaxi()
     if open then 
         open = false
         RageUI.Visible(taxiDeTesMort, false)
         return
     else
         open = true 
         RageUI.Visible(taxiDeTesMort, true)
         CreateThread(function()
         while open do 
            RageUI.IsVisible(taxiDeTesMort,function() 


               RageUI.Separator("")

                RageUI.Button("Véhicule de travaille", nil, {RightLabel = "→→"}, true , {
                  onActive = function()
                    RageUI.Info("Garage taxi", {"Type : ~r~Garage Véhicule~w~", "Modèle : ~r~Taxi~w~"}, {})
                  end, 
                    onSelected = function()
                      local model = GetHashKey("taxi")
                      RequestModel(model)
                      while not HasModelLoaded(model) do Citizen.Wait(10) end
                      local pos = GetEntityCoords(PlayerPedId())
                      local vehicle = CreateVehicle(model, 920.74, -163.53, 74.85, 273.6657, true, true)
                    end
                })

                RageUI.Button("Ranger", nil, {RightLabel = "→→"}, true , {
                  onActive = function()
                    RageUI.Info('Garage Taxi', {"Type : ~r~Rangement~w~"}, {})
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
  {x = 917.03, y = -170.49, z = 74.48} 
}

Citizen.CreateThread(function()
    while true do

      local wait = 750

        for k in pairs(position) do
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'taxi' then 
            local plyCoords = GetEntityCoords(PlayerPedId(), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, position[k].x, position[k].y, position[k].z)

            if dist <= 15.0 then
            wait = 0
            DrawMarker(22, 917.03, -170.49, 74.48, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.3, 0.3, 0.3, 255, 235, 59, 255, true, true, p19, true)  

        
            if dist <= 1.0 then
               wait = 0
                Visual.Subtitle("Appuyer sur ~r~[E]~s~ pour intéragir", 1) 
                if IsControlJustPressed(1,51) then
                  OpenTesMorttaxi()
            end
        end
    end
    end
    Citizen.Wait(wait)
    end
end
end)


