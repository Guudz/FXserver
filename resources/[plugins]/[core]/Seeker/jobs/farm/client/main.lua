LystyLife.netRegisterAndHandle('ewen:createEntreprise', function()
    LystyLife.Job.OpenCreateEntrepriseFarmMenu()
end)

Citizen.CreateThread(function()
    Wait(2000)
    LystyLifeClientUtils.toServer('ewen:initFarmSociety')
end)

local EntrepriseFarmList = {}
local EntrepriseFarmListLoaded = false

LystyLife.netRegisterAndHandle('ewen:SendEntrepriseFarmList', function(Table)
    EntrepriseFarmList = Table
    EntrepriseFarmListLoaded = true
end)

Citizen.CreateThread(function()
    while not EntrepriseFarmListLoaded do 
        Wait(1)
    end
    
    for k,v in pairs(EntrepriseFarmList) do
        LystyLife.EntrepriseFarmList = v
        local blip = AddBlipForCoord(LystyLife.EntrepriseFarmList.PosBoss.x, LystyLife.EntrepriseFarmList.PosBoss.y, LystyLife.EntrepriseFarmList.PosBoss.z)
        SetBlipSprite(blip, 181)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, 0.6)
        SetBlipColour(blip, 46)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("~r~Entreprise ~r~|~s~ ".. v.label)
        EndTextCommandSetBlipName(blip)

        if ESX.PlayerData.job.name == LystyLife.EntrepriseFarmList.name then 
            local blip = AddBlipForCoord(LystyLife.EntrepriseFarmList.PosRecolte.x, LystyLife.EntrepriseFarmList.PosRecolte.y, LystyLife.EntrepriseFarmList.PosRecolte.z)
            SetBlipSprite(blip, 501)
            SetBlipDisplay(blip, 4)
            SetBlipScale(blip, 0.6)
            SetBlipColour(blip, 43)
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("~r~Récolte ~r~|~s~ ".. LystyLife.EntrepriseFarmList.label)
            EndTextCommandSetBlipName(blip)
            local blip = AddBlipForCoord(LystyLife.EntrepriseFarmList.PosTraitement.x, LystyLife.EntrepriseFarmList.PosTraitement.y, LystyLife.EntrepriseFarmList.PosTraitement.z)
            SetBlipSprite(blip, 501)
            SetBlipDisplay(blip, 4)
            SetBlipScale(blip, 0.6)
            SetBlipColour(blip, 43)
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("~r~Traitement ~r~|~s~ ".. LystyLife.EntrepriseFarmList.label)
            EndTextCommandSetBlipName(blip)
            local blip = AddBlipForCoord(LystyLife.EntrepriseFarmList.PosVente.x, LystyLife.EntrepriseFarmList.PosVente.y, LystyLife.EntrepriseFarmList.PosVente.z)
            SetBlipSprite(blip, 501)
            SetBlipDisplay(blip, 4)
            SetBlipScale(blip, 0.6)
            SetBlipColour(blip, 43)
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("~r~Vente ~r~|~s~ ".. LystyLife.EntrepriseFarmList.label)
            EndTextCommandSetBlipName(blip)
        end
    end

    while true do
        local isProche = false
        for k,v in pairs(EntrepriseFarmList) do
            LystyLife.EntrepriseFarmList = v
           if ESX.PlayerData.job.name == LystyLife.EntrepriseFarmList.name then
               local CoffreAction = vector3(LystyLife.EntrepriseFarmList.PosBoss.x, LystyLife.EntrepriseFarmList.PosBoss.y, LystyLife.EntrepriseFarmList.PosBoss.z)

               local distanceCoffreAction = Vdist2(GetEntityCoords(PlayerPedId(), false), CoffreAction)

               if distanceCoffreAction < 50 then
                   isProche = true
               end
               if distanceCoffreAction < 3 then
                   ESX.ShowHelpNotification("~r~LystyLifeRôleplay\n~r~Appuyez sur ~INPUT_CONTEXT~ pour intéragir")
                   if IsControlJustPressed(1,51) then
                    LystyLife.Job.OpenSocietyMenu({label = ESX.PlayerData.job.label, name = ESX.PlayerData.job.name }, CoffreAction)
                   end
               end
           end
        end
        
		if isProche then
			Wait(0)
		else
			Wait(750)
		end
	end
end)

local farming = false
local WaitFarming = false

Citizen.CreateThread(function()
    while true do
        local Open = false
        for k,v in pairs(EntrepriseFarmList) do
            LystyLife.EntrepriseFarmList = v
            if ESX.PlayerData.job.name == LystyLife.EntrepriseFarmList.name then
                if Vdist2(GetEntityCoords(PlayerPedId(), false), vector3(LystyLife.EntrepriseFarmList.PosRecolte.x,LystyLife.EntrepriseFarmList.PosRecolte.y, LystyLife.EntrepriseFarmList.PosRecolte.z)) < 100 then
                    Open = true
                    if not farming then
                        if not WaitFarming then
                            ESX.ShowHelpNotification('~r~Intéraction ~w~~n~Appuyez sur ~r~E ~w~pour intéragir')
                            if IsControlJustPressed(1,51) then
                                farming = true
                                WaitFarming = true
                                LystyLifeClientUtils.toServer('framework:startActivity', LystyLife.EntrepriseFarmList.PosRecolte, LystyLife.EntrepriseFarmList.RecolteItem, 1, '0', ESX.PlayerData.job.name)
                            end
                        else
                            ESX.ShowHelpNotification('~r~ANTI-GLITCH ~w~~n~Merci de ne pas allez trop vite')
                        end
                    else
                        DrawMissionText("~r~Appuyez sur ~w~E ~r~pour arrêter l\'activité", 100)
                        if IsControlJustPressed(1,51) then
                            farming = false
                            LystyLifeClientUtils.toServer('framework:stopActivity')
                            Wait(5000)
                            WaitFarming = false
                        end
                    end
                end

                if Vdist2(GetEntityCoords(PlayerPedId(), false), vector3(LystyLife.EntrepriseFarmList.PosRecolte.x,LystyLife.EntrepriseFarmList.PosRecolte.y, LystyLife.EntrepriseFarmList.PosRecolte.z)) > 100 and Vdist2(GetEntityCoords(PlayerPedId(), false), vector3(LystyLife.EntrepriseFarmList.PosRecolte.x,LystyLife.EntrepriseFarmList.PosRecolte.y, LystyLife.EntrepriseFarmList.PosRecolte.z)) < 105 then
                    farming = false
                    LystyLifeClientUtils.toServer('framework:stopActivity')
                    Wait(5000)
                    WaitFarming = false
                end

                if Vdist2(GetEntityCoords(PlayerPedId(), false), vector3(LystyLife.EntrepriseFarmList.PosTraitement.x,LystyLife.EntrepriseFarmList.PosTraitement.y, LystyLife.EntrepriseFarmList.PosTraitement.z)) > 100 and Vdist2(GetEntityCoords(PlayerPedId(), false), vector3(LystyLife.EntrepriseFarmList.PosTraitement.x,LystyLife.EntrepriseFarmList.PosTraitement.y, LystyLife.EntrepriseFarmList.PosTraitement.z)) < 105 then
                    farming = false
                    LystyLifeClientUtils.toServer('framework:stopActivity')
                    Wait(5000)
                    WaitFarming = false
                end

                if Vdist2(GetEntityCoords(PlayerPedId(), false), vector3(LystyLife.EntrepriseFarmList.PosVente.x,LystyLife.EntrepriseFarmList.PosVente.y, LystyLife.EntrepriseFarmList.PosVente.z)) > 100 and Vdist2(GetEntityCoords(PlayerPedId(), false), vector3(LystyLife.EntrepriseFarmList.PosVente.x,LystyLife.EntrepriseFarmList.PosVente.y, LystyLife.EntrepriseFarmList.PosVente.z)) < 105 then
                    farming = false
                    LystyLifeClientUtils.toServer('framework:stopActivity')
                    Wait(5000)
                    WaitFarming = false
                end

                if Vdist2(GetEntityCoords(PlayerPedId(), false), vector3(LystyLife.EntrepriseFarmList.PosTraitement.x,LystyLife.EntrepriseFarmList.PosTraitement.y, LystyLife.EntrepriseFarmList.PosTraitement.z)) < 100 then
                    Open = true
                    if not farming then
                        if not WaitFarming then
                            ESX.ShowHelpNotification('~r~Intéraction ~w~~n~Appuyez sur ~r~E ~w~pour intéragir')
                            if IsControlJustPressed(1,51) then
                                farming = true
                                WaitFarming = true
                                LystyLifeClientUtils.toServer('framework:startActivity', LystyLife.EntrepriseFarmList.PosTraitement, LystyLife.EntrepriseFarmList.RecolteItem, 2, LystyLife.EntrepriseFarmList.TraitementItem, ESX.PlayerData.job.name)
                            end
                        else
                            ESX.ShowHelpNotification('~r~ANTI-GLITCH ~w~~n~Merci de ne pas allez trop vite')
                        end
                    else
                        DrawMissionText("~r~Appuyez sur ~w~E ~r~pour arrêter l\'activité", 100)
                        if IsControlJustPressed(1,51) then
                            farming = false
                            LystyLifeClientUtils.toServer('framework:stopActivity')
                            Wait(5000)
                            WaitFarming = false
                        end
                    end
                end

                if Vdist2(GetEntityCoords(PlayerPedId(), false), vector3(LystyLife.EntrepriseFarmList.PosVente.x,LystyLife.EntrepriseFarmList.PosVente.y, LystyLife.EntrepriseFarmList.PosVente.z)) < 100 then
                    Open = true
                    if not farming then
                        
                        if not WaitFarming then
                            ESX.ShowHelpNotification('~r~Intéraction ~w~~n~Appuyez sur ~r~E ~w~pour intéragir')
                            if IsControlJustPressed(1,51) then
                                farming = true
                                LystyLifeClientUtils.toServer('framework:startActivity', LystyLife.EntrepriseFarmList.PosVente, '0', 3, LystyLife.EntrepriseFarmList.TraitementItem, ESX.PlayerData.job.name)
                            end
                        else
                            ESX.ShowHelpNotification('~r~ANTI-GLITCH ~w~~n~Merci de ne pas allez trop vite')
                        end
                    else
                        DrawMissionText("~r~Appuyez sur ~w~E ~r~pour arrêter l\'activité", 100)
                        if IsControlJustPressed(1,51) then
                            farming = false
                            LystyLifeClientUtils.toServer('framework:stopActivity')
                            Wait(5000)
                            WaitFarming = false
                        end
                    end
                end
            end

        end
                
        if Open then
          Wait(0)
      else
          Wait(1000)
      end
    end
end)

LystyLife.netRegisterAndHandle('framework:farmanimation', function()
	local dict, anim = 'random@domestic', 'pickup_low'
	local playerPed = PlayerPedId()
    ESX.Streaming.RequestAnimDict(dict)
	TaskPlayAnim(playerPed, dict, anim, 8.0, 1.0, 1000, 16, 0.0, false, false, false)
end)