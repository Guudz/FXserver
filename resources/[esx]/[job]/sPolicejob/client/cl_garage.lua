OpenGaragePolice = function()
    local maingarage = RageUI.CreateMenu("", "Voici les véhicules disponibles")

    RageUI.Visible(maingarage, not RageUI.Visible(maingarage))

    while maingarage do 
        Wait(0)

        RageUI.IsVisible(maingarage, function()

            for k, v in pairs(GaragePolice) do
                RageUI.Button("→ "..v.label.."", nil, {RightLabel = "→→→"}, true, {
                    onSelected = function()
                        ESX.Game.SpawnVehicle(v.name, vector3(445.964844, -1021.621948, 28.487916), 90.0, function(veh)
                            RageUI.CloseAll()
                            TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1) 
                        end)
                    end
                })

            end
        
        end, function()
        end)

        if not RageUI.Visible(maingarage) then 
            maingarage = RMenu:DeleteType('maingarage')
        end
    end
end

