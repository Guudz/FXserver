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
local mechanicDeTesMort = RageUI.CreateMenu('', 'Garage mechanic')
mechanicDeTesMort.Display.Header = true 
mechanicDeTesMort.Closed = function()
  open = false
end

function OpenTesMortmechanic()
     if open then 
         open = false
         RageUI.Visible(mechanicDeTesMort, false)
         return
     else
         open = true 
         RageUI.Visible(mechanicDeTesMort, true)
         CreateThread(function()
         while open do 
            RageUI.IsVisible(mechanicDeTesMort,function() 


              RageUI.Separator("Grade : ~r~"..ESX.PlayerData.job.grade_label.."") 

                  RageUI.Button("→ FlatBed", nil, {RightLabel = "→→→"}, true , {
                    onActive = function()
                      RageUI.Info("Garage mechanic", {"Type : ~r~Garage Véhicule~w~", "Modèle : ~r~Flatbed~w~"}, {})
                    end, 
                    onSelected = function()
                      local model = GetHashKey("flatbed")
                      RequestModel(model)
                      while not HasModelLoaded(model) do Citizen.Wait(10) end
                      local pos = GetEntityCoords(PlayerPedId())
                      local vehicle = CreateVehicle(model, -183.26, -1302.42, 31.3, 274.25, true, true)
                      RageUI.CloseAll()
                    end
                })

                RageUI.Button("→ Tow-truck 1", nil, {RightLabel = "→→→"}, true , {
                  onActive = function()
                    RageUI.Info("Garage mechanic", {"Type : ~r~Garage Véhicule~w~", "Modèle : ~r~Tow-truck 1~w~"}, {})
                  end, 
                  onSelected = function()
                    local model = GetHashKey("towtruck")
                    RequestModel(model)
                    while not HasModelLoaded(model) do Citizen.Wait(10) end
                    local pos = GetEntityCoords(PlayerPedId())
                    local vehicle = CreateVehicle(model, -183.26, -1302.42, 31.3, 274.25, true, true)
                    RageUI.CloseAll()
                  end
              })

              RageUI.Button("→ Tow-truck 2", nil, {RightLabel = "→→→"}, true , {
                onActive = function()
                  RageUI.Info("Garage mechanic", {"Type : ~r~Garage Véhicule~w~", "Modèle : ~r~Tow-truck 2~w~"}, {})
                end, 
                onSelected = function()
                  local model = GetHashKey("towtruck2")
                  RequestModel(model)
                  while not HasModelLoaded(model) do Citizen.Wait(10) end
                  local pos = GetEntityCoords(PlayerPedId())
                  local vehicle = CreateVehicle(model, -183.26, -1302.42, 31.3, 274.25, true, true)
                  RageUI.CloseAll()
                end
            })

            RageUI.Separator()

                RageUI.Button("→ Ranger", nil, {RightLabel = "→→→"}, true , {
                  onActive = function()
                    RageUI.Info('Garage mechanic', {"Type : ~r~Rangement~w~"}, {})
                    end,
                  onSelected = function()
                    local veh,dist4 = ESX.Game.GetClosestVehicle(playerCoords)
                    if dist4 < 15 then
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
  {x = -192.51, y = -1290.19, z = 31.3} 
}

Citizen.CreateThread(function()
    while true do

      local wait = 750

        for k in pairs(position) do
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'mechanic' then 
            local plyCoords = GetEntityCoords(PlayerPedId(), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, position[k].x, position[k].y, position[k].z)

            if dist <= 15.0 then
            wait = 0
            DrawMarker(22, -192.51, -1290.19, 31.3, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.3, 0.3, 0.3, 255, 118, 148, 255, true, true, p19, true)  

        
            if dist <= 1.0 then
               wait = 0
                Visual.Subtitle("Appuyer sur ~r~[E]~s~ pour intéragir", 1) 
                if IsControlJustPressed(1,51) then
                  OpenTesMortmechanic()
            end
        end
    end
    end
    Citizen.Wait(wait)
    end
end
end)


