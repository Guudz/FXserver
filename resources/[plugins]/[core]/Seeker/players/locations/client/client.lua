local Couldown = false

local LocationVehicleStart = {
    {Label = 'Cruiser', Name = 'cruiser', Price = 15}, 
    {Label = 'Fixter', Name = 'fixter', Price = 25}, 
    {Label = 'Panto', Name = 'panto', Price = 250}
}

LocationVehicle = { 
    {Label = 'Faggio', Name = 'faggio', Price = 150}, 
    {Label = 'Blista', Name = 'blista', Price = 300},
    {Label = 'Panto', Name = 'panto', Price = 250}
}

local LocationVehicleJetski = {
    {Label = 'Jetski', Name = 'seashark', Price = 100}, 
    {Label = 'Jetski 2', Name = 'seashark2', Price = 155}, 
    {Label = 'Jetski 3', Name = 'seashark3', Price = 200}, 
}

local LocationVelo = {
    {Label = 'BMX', Name = 'bmx', Price = 15}, 
    {Label = 'Cruiser', Name = 'cruiser', Price = 20}, 
    {Label = 'Fixter', Name = 'fixter', Price = 25}, 
    {Label = 'Scorcher', Name = 'scorcher', Price = 30},
}

local LocationVehicleTravaille = {
    {Label = 'Burrito', Name = 'burrito', Price = 150},
}

function openLocation(id)
    local location = RageUI.CreateMenu("Location", "Location")
	RageUI.Visible(location, not RageUI.Visible(location))

	while location do
        Citizen.Wait(0)
        RageUI.IsVisible(location, function()
            if id == 1 then 
                if not Couldown then
                    for k,v in pairs(LocationVehicleStart) do
                        RageUI.Button(v.Label, nil, {RightLabel = "~r~"..v.Price.."$"}, true, {
                            onSelected = function() 
                                local playerPed = GetPlayerPed(-1)
                                local coords    = GetEntityCoords(PlayerPedId())
                                ESX.Game.SpawnVehicle(v.Name, coords, 200.0, function(vehicle)
                                    TaskWarpPedIntoVehicle(playerPed, vehicle, -1) 
                                    SetVehicleNumberPlateText(vehicle, 'LOCATION') 
                                end)
                                TriggerServerEvent('Location:Buy', v.Name, v.Price)
                                location = RMenu:DeleteType('location', true)
                                TriggerEvent('couldownlocation')
                            end
                        });
                    end
                else
                    RageUI.Separator('~r~')
                    RageUI.Separator('~r~Vous devez attendre 1 minutes')
                    RageUI.Separator('~r~')
                end
            elseif id == 2 then
                if not Couldown then
                    for k,v in pairs(LocationVehicleJetski) do
                        RageUI.Button(v.Label, nil, {RightLabel = "~r~"..v.Price.."$"}, true, {
                            onSelected = function() 
                                local playerPed = GetPlayerPed(-1)
                                local coords = GetEntityCoords(PlayerPedId())
                                ESX.Game.SpawnVehicle(v.Name, coords, 200.0, function(vehicle)
                                    TaskWarpPedIntoVehicle(playerPed, vehicle, -1) 
                                    SetVehicleNumberPlateText(vehicle, 'LOCATION') 
                                end)
                                TriggerServerEvent('Location:Buy', v.Name, v.Price)
                                location = RMenu:DeleteType('location', true)
                                TriggerEvent('couldownlocation')
                            end
                        });
                    end
                else
                    RageUI.Separator('~r~')
                    RageUI.Separator('~r~Vous devez attendre 1 minutes')
                    RageUI.Separator('~r~')
                end
            elseif id == 3 then 
                if not Couldown then
                    for k,v in pairs(LocationVelo) do 
                        RageUI.Button(v.Label, nil, {RightLabel = "~r~"..v.Price.."$"}, true, {
                            onSelected = function() 
                                local playerPed = GetPlayerPed(-1)
                                local coords = GetEntityCoords(PlayerPedId())
                                ESX.Game.SpawnVehicle(v.Name, coords, 200.0, function(vehicle)
                                    TaskWarpPedIntoVehicle(playerPed, vehicle, -1) 
                                    SetVehicleNumberPlateText(vehicle, 'LOCATION') 
                                end)
                                TriggerServerEvent('Location:Buy', v.Name, v.Price)
                                location = RMenu:DeleteType('location', true)
                                TriggerEvent('couldownlocation')
                            end
                        });
                    end
                else
                    RageUI.Separator('~r~')
                    RageUI.Separator('~r~Vous devez attendre 1 minutes')
                    RageUI.Separator('~r~')
                end
            elseif id == 4 then
                if not Couldown then
                    for k,v in pairs(LocationVehicleJetski) do
                        RageUI.Button(v.Label, nil, {RightLabel = "~r~"..v.Price.."$"}, true, {
                            onSelected = function() 
                                local playerPed = GetPlayerPed(-1)
                                local coords = vector3(-1528.039, 1504.714, 109.257)
                                ESX.Game.SpawnVehicle(v.Name, coords, 200.0, function(vehicle)
                                    TaskWarpPedIntoVehicle(playerPed, vehicle, -1) 
                                    SetVehicleNumberPlateText(vehicle, 'LOCATION') 
                                end)
                                TriggerServerEvent('Location:Buy', v.Name, v.Price)
                                location = RMenu:DeleteType('location', true)
                                TriggerEvent('couldownlocation')
                            end
                        });
                    end
                else
                    RageUI.Separator('~r~')
                    RageUI.Separator('~r~Vous devez attendre 1 minutes')
                    RageUI.Separator('~r~')
                end
            elseif id == 5 then
                if not Couldown then
                    for k,v in pairs(LocationVehicleTravaille) do
                        RageUI.Button(v.Label, nil, {RightLabel = "~r~"..v.Price.."$"}, true, {
                            onSelected = function()
                                local plate = string.upper(GetRandomLetter(3) .. ' ' .. GetRandomNumber(3))
                                local playerPed = GetPlayerPed(-1)
                                local coords = GetEntityCoords(PlayerPedId())
                                ESX.Game.SpawnVehicle(v.Name, coords, 200.0, function(vehicle)
                                    TaskWarpPedIntoVehicle(playerPed, vehicle, -1) 
                                    SetVehicleNumberPlateText(vehicle, 'LOCATION') 
                                end)
                                TriggerServerEvent('Location:Buy', v.Name, v.Price)
                                location = RMenu:DeleteType('location', true)
                                TriggerEvent('couldownlocation')
                            end
                        });
                    end
                else
                    RageUI.Separator('~r~')
                    RageUI.Separator('~r~Vous devez attendre 1 minutes')
                    RageUI.Separator('~r~')
                end
            elseif id == 6 then 
                if not Couldown then
                    for k,v in pairs(LocationVehicle) do 
                        RageUI.Button(v.Label, nil, {RightLabel = "~r~"..v.Price.."$"}, true, {
                            onSelected = function()
                                local plate = 'LOCATION'
                                local playerPed = GetPlayerPed(-1)
                                local coords = GetEntityCoords(PlayerPedId())
                                ESX.Game.SpawnVehicle(v.Name, coords, 200.0, function(vehicle)
                                    TaskWarpPedIntoVehicle(playerPed, vehicle, -1) 
                                    SetVehicleNumberPlateText(vehicle, 'LOCATION') 
                                end)
                                TriggerServerEvent('Location:Buy', v.Name, v.Price)
                                location = RMenu:DeleteType('location', true)
                                TriggerEvent('couldownlocation')
                            end
                        });
                    end
                else
                    RageUI.Separator('~r~')
                    RageUI.Separator('~r~Vous devez attendre 1 minutes')
                    RageUI.Separator('~r~')
                end
            end
        end)
        
		if not RageUI.Visible(location) then
			location = RMenu:DeleteType('location', true)
		end
	end
end

RegisterNetEvent('couldownlocation')
AddEventHandler('couldownlocation', function()
    Couldown = true 
    Wait(60000)
    Couldown = false
end)