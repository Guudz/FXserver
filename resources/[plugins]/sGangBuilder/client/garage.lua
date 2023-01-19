IndexGarage = 1
OpenGarageGang = function()
    local maingaragegang = RageUI.CreateMenu("Garage du gang", "Voici les véhicules disponibles")
    ESX.TriggerServerCallback("ronflex:getvehiclegarage", function(vehicle, pos) 
        Vehicle = vehicle
        PosSpawn = vector3(pos.spawn.x, pos.spawn.y, pos.spawn.z)
        PosHading = pos.heading
    end, ESX.PlayerData.job2.name)
    Wait(100)
    RageUI.Visible(maingaragegang, not RageUI.Visible(maingaragegang))

    while maingaragegang do 
        Wait(0)

        RageUI.IsVisible(maingaragegang, function()

            for k, v in pairs(Vehicle) do 
                RageUI.List("→ "..GetDisplayNameFromVehicleModel(v.props.model), {"Sortir", (Garage[ESX.PlayerData.job2.name] ~= nil and "Peinture" or nil)}, IndexGarage, nil, {RightLabel = ""}, true, {
                    onListChange = function(index)
                        IndexGarage = index 
                    end,
                    onSelected = function(index)
                        if index == 1 then 
                            RageUI.CloseAll()
                            ESX.Game.SpawnVehicle(v.props.model, PosSpawn, PosHading, function(veh)
                                ESX.Game.SetVehicleProperties(veh, v.props) 
                            end)
                            TriggerServerEvent("ronflex:deletevehiculegangfromgaragezebi", v.plate)
                        elseif index == 2 then 
                            RageUI.CloseAll()
                            if Garage[ESX.PlayerData.job2.name] then 
                                ESX.Game.SpawnVehicle(v.props.model, PosSpawn, PosHading, function(veh)
                                    ESX.Game.SetVehicleProperties(veh, v.props) 
                                    SetVehicleCustomPrimaryColour(veh, Garage[ESX.PlayerData.job2.name].primary.r,  Garage[ESX.PlayerData.job2.name].primary.g,  Garage[ESX.PlayerData.job2.name].primary.b)
                                    SetVehicleCustomSecondaryColour(veh, Garage[ESX.PlayerData.job2.name].secondary.r, Garage[ESX.PlayerData.job2.name].secondary.g, Garage[ESX.PlayerData.job2.name].secondary.b)
                                end)
                                TriggerServerEvent("ronflex:deletevehiculegangfromgaragezebi", v.plate)
                                TriggerServerEvent("ronflex:paidvehiculecustom")

                            else
                                ESX.ShowNotification("Couleur non configuré pour votre gang")
                            end
                           


                        end

                    end
                })
                

            end
          
        
        end)

        if not RageUI.Visible(maingaragegang) then 
            maingaragegang = RMenu:DeleteType("maingaragegang")
        end

    end
end