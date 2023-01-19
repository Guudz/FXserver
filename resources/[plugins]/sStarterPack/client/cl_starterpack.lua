ESX = nil
ESXLoad = false 
Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end

    ESXLoad = true 
end)

Citizen.CreateThread(function()
    if ConfigStarterPack.Ped.Active then

        local hash = GetHashKey(ConfigStarterPack.Ped.Name)
        while not HasModelLoaded(hash) do
            RequestModel(hash)
            Wait(20)
        end
        PedCreated = CreatePed("PED_TYPE_CIVMALE", hash, ConfigStarterPack.Ped.Positon, ConfigStarterPack.Ped.Heading, false, true)
        SetBlockingOfNonTemporaryEvents(PedCreated, true)
        SetEntityInvincible(PedCreated, true)
        FreezeEntityPosition(PedCreated, true)
        TaskStartScenarioInPlace(PedCreated, "WORLD_HUMAN_HIKER_STANDING", 0, true)
    end
end)



OpenStarterPack = function()
    local mainstarterpack = RageUI.CreateMenu(ConfigStarterPack.Menu["Title"], ConfigStarterPack.Menu["Subtitle"])
    mainstarterpack:SetRectangleBanner(ConfigStarterPack.Menu.Color["r"], ConfigStarterPack.Menu.Color["g"], ConfigStarterPack.Menu.Color["b"], ConfigStarterPack.Menu.Color["a"])    

    RageUI.Visible(mainstarterpack, not RageUI.Visible(mainstarterpack))

    while mainstarterpack do 
        Wait(1)


        RageUI.IsVisible(mainstarterpack, function()
            for k, v in pairs(ConfigStarterPack.Pack) do 
                RageUI.Button("→ "..v.Type, v.Description, {RightLabel = "→→→"}, true, {
                    onSelected = function()
                        TriggerServerEvent("ronflex:starterpack", k)
                    end
                })

            end
        
        end, function()
        end)

        if not RageUI.Visible(mainstarterpack) then 
            mainstarterpack = RMenu:DeleteType('mainstarterpack')
            FreezeEntityPosition(PlayerPedId(), false)
        end

    end


end

CreateThread(function()
    while not ESXLoad do 
        Wait(1)
    end

    while true do 

        local dist = Vdist2(GetEntityCoords(PlayerPedId()), ConfigStarterPack.Ped.Positon)

        if dist < 30 then 
            Spam = true 
            ESX.ShowHelpNotification(ConfigStarterPack.HelpNotification)
            if IsControlJustPressed(0, 51) then 
                FreezeEntityPosition(PlayerPedId(), true)
                OpenStarterPack()
            end
        end

        if Spam then 
            Wait(1)
        else
            Wait(1000)
        end
    end
end)