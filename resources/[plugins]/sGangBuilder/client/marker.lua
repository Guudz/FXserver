Citizen.CreateThread(function()
    while not ESXLoad do 
        Wait(1)
    end
    while not GangLoad do 
        Wait(1)
    end

    while true do 

        for k, v in pairs(GangInfos) do 
            
            if ESX.PlayerData.job2 ~= nil and ESX.PlayerData.job2.name == v.name then 
                if v.pospatron then 
                    pospatron = v.pospatron
                    
                    local dist = Vdist2(GetEntityCoords(PlayerPedId()), pospatron.x, pospatron.y, pospatron.z)
                    if dist <= 20 then
                        Spam = true
                        DrawMarker(ConfigGangBuilder.Marker.Type, pospatron.x, pospatron.y, pospatron.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.35, 0.35, 0.35, ConfigGangBuilder.Marker.Color["r"], ConfigGangBuilder.Marker.Color["g"],ConfigGangBuilder.Marker.Color["b"], 255, 55555, false, true, 2, false, false, false, false)
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le coffre")
                        if IsControlJustPressed(0, 51) then 
                            OpenCoffreGang(ESX.PlayerData.job2.name)
                        end
                    end
                end
            end

            if v.posgarage then 
                if ESX.PlayerData.job2 ~= nil and ESX.PlayerData.job2.name == v.name then 
                    posgarage = v.posgarage
                
                    local dist = Vdist2(GetEntityCoords(PlayerPedId()), posgarage.x, posgarage.y, posgarage.z)
                    if dist <= 20 then
                        Spam = true
                        DrawMarker(ConfigGangBuilder.Marker.Type, posgarage.x, posgarage.y, posgarage.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.35, 0.35, 0.35, ConfigGangBuilder.Marker.Color["r"], ConfigGangBuilder.Marker.Color["g"],ConfigGangBuilder.Marker.Color["b"], 255, 55555, false, true, 2, false, false, false, false)
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le garage")
                        if IsControlJustPressed(0, 51) then 
                            OpenGarageGang()
                        end
                    end
                end
               
            end

            if v.posvestiaire then 
                if ESX.PlayerData.job2 ~= nil and ESX.PlayerData.job2.name == v.name then 
                    posvestiaire = v.posvestiaire
                    
                    local dist = Vdist2(GetEntityCoords(PlayerPedId()), posvestiaire.x, posvestiaire.y, posvestiaire.z)
                    if dist <= 20 then
                        Spam = true
                        DrawMarker(ConfigGangBuilder.Marker.Type, posvestiaire.x, posvestiaire.y, posvestiaire.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.35, 0.35, 0.35, ConfigGangBuilder.Marker.Color["r"], ConfigGangBuilder.Marker.Color["g"],ConfigGangBuilder.Marker.Color["b"], 255, 55555, false, true, 2, false, false, false, false)
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour ouvrir les vestiaire")
                        if IsControlJustPressed(0, 51) then 
                            OpenVestiaireGang()
                        end
                    end
                end
            end

            if v.posgaragedelete then 
                if ESX.PlayerData.job2 ~= nil and ESX.PlayerData.job2.name == v.name then 
                    posgaragedelete = v.posgaragedelete
                
                    local dist = Vdist2(GetEntityCoords(PlayerPedId()), posgaragedelete.x, posgaragedelete.y, posgaragedelete.z)
                    if dist <= 20 then
                        Spam = true
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour ranger le véhicule")
                        if IsControlJustPressed(0, 51) then 
                            local veh = GetVehiclePedIsIn(PlayerPedId(), false)
                            local props = ESX.Game.GetVehicleProperties(veh)
                            if veh ~= 0 then 
                                TriggerServerEvent("ronflex:addnewvehiculetogaragegangzebi", props)
                                DeleteEntity(veh)
                            else
                                ESX.ShowNotification("Vous n'etes pas dans un véhicule")
                            end
                        end
                    end
                end

            end
        end
        
        if Spam then 
            Wait(0)
        else
            Wait(255)
        end
    end
end)


Citizen.CreateThread(function()
    while not GangLoad do 
        Wait(1)
    end
    for k, v in pairs(GangInfos) do 
        blipsinfos = v.blips
        if v.pospatron then 
            pospatron = v.pospatron
            print(blipsinfos.colour)
            local blips = AddBlipForCoord(pospatron.x, pospatron.y, pospatron.z)
            SetBlipSprite(blips, tonumber(blipsinfos.id))
            SetBlipColour(blips, tonumber(blipsinfos.colour))
            SetBlipAsShortRange(blips, true)

            SetBlipScale(blips, tonumber(blipsinfos.scale))
            BeginTextCommandSetBlipName('STRING')
            AddTextComponentSubstringPlayerName(blipsinfos.name)
            EndTextCommandSetBlipName(blips)
        end
    end
   
end)