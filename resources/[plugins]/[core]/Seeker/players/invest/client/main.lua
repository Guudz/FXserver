RegisterCommand('afk', function()
    OpenAFKMenu()
end)
RegisterCommand('invest', function()
    OpenAFKMenu()
end)
RegisterCommand('investissement', function()
    OpenAFKMenu()
end)

local AfkTime = 0
local InAfkZone = false
RegisterNetEvent("requestClientAfkTime", function(result)
    AfkTime = result
end)

RegisterNetEvent("ForceLunchInvest", function(result)
    InAfkZone = true
    InAFK = true
    Wait(150)
    OpenAFKMenuInvest()
end)

Citizen.CreateThread(function()
    Wait(2500)
    TriggerServerEvent("requteInvestTime")
    while true do
        if InAfkZone then
            if AfkTime >= 1 then
                Wait(60000)
                AfkTime = AfkTime - 1
                TriggerServerEvent("UpdateAfkTick", AfkTime)
            end
        end
        Wait(2500)
    end
end)

function OpenAFKMenu()
    if #(GetEntityCoords(PlayerPedId()) - vector3(1642.719, 2570.633, 51.516)) < 250 then
        ESX.ShowNotification('~r~LystyLife~w~~n~Vous ne pouvez pas faire cette commande en étant en Jail.')
    else
        if exports.korioz:GetSafeZone() then
            local menu = RageUI.CreateMenu("Menu Investissement", "Gagne de l'argent en étant AFK") 
            menu:SetSizeWidth(99)
            RageUI.Visible(menu, not RageUI.Visible(menu))
    
            while menu do
                Citizen.Wait(0)
                if not exports.korioz:GetSafeZone() then
                    RageUI.CloseAll()
                end
                RageUI.IsVisible(menu, function()
                    RageUI.Separator('Gagne de l\'argent en étant AFK !')
                    RageUI.Separator('Investis ton argent et double l\'investissement')
                    RageUI.Separator('')
                    if AfkTime <= 0 then
                        RageUI.Button('0$ -> 15.000$', nil, {RightLabel = '1h'}, true, {onSelected = function()
                            InAfkZone = true
                            TriggerServerEvent("GoInvest", 1)
                            RageUI.CloseAll()
                            InAFK = true
                            Wait(150)
                            OpenAFKMenuInvest()
                        end})
                        RageUI.Button('15.000$ -> 45.000$', nil, {RightLabel = '2h'}, true, {onSelected = function()
                            InAfkZone = true
                            TriggerServerEvent("GoInvest", 2)
                            RageUI.CloseAll()
                            InAFK = true
                            Wait(150)
                            OpenAFKMenuInvest()
                        end})
                        RageUI.Button('45.000$ -> 95.000$', nil, {RightLabel = '4h'}, true, {onSelected = function()
                            InAfkZone = true
                            TriggerServerEvent("GoInvest", 3)
                            RageUI.CloseAll()
                            InAFK = true
                            Wait(150)
                            OpenAFKMenuInvest()
                        end})
                        RageUI.Button('95.000$ -> 200.000$', nil, {RightLabel = '8h'}, true, {onSelected = function()
                            InAfkZone = true
                            TriggerServerEvent("GoInvest", 4)
                            RageUI.CloseAll()
                            InAFK = true
                            Wait(150)
                            OpenAFKMenuInvest()
                        end})
                        RageUI.Button('200.000$ -> 425.000$', nil, {RightLabel = '12h'}, true, {onSelected = function()
                            InAfkZone = true
                            TriggerServerEvent("GoInvest", 5)
                            RageUI.CloseAll()
                            InAFK = true
                            Wait(150)
                            OpenAFKMenuInvest()
                        end})
                        RageUI.Button('425.000$ -> 875.000$', nil, {RightLabel = '24h'}, true, {onSelected = function()
                            InAfkZone = true
                            TriggerServerEvent("GoInvest", 6)
                            RageUI.CloseAll()
                            InAFK = true
                            Wait(150)
                            OpenAFKMenuInvest()
                        end})
                        RageUI.Button('875.000$ -> 1.750.000$', nil, {RightLabel = '48h'}, true, {onSelected = function()
                            InAfkZone = true
                            TriggerServerEvent("GoInvest", 7)
                            RageUI.CloseAll()
                            InAFK = true
                            Wait(150)
                            OpenAFKMenuInvest()
                        end})
                    else
                        RageUI.Separator('Vous avez déjà un investissement en cours')
                        RageUI.Button('Reprendre l\'investissement', nil, {}, true, {onSelected = function()
                            InAfkZone = true
                            RageUI.CloseAll()
                            InAFK = true
                            Wait(150)
                            OpenAFKMenuInvest()
                        end})
                    end
                end, function()
                end)
    
                if not RageUI.Visible(menu) then
                    menu = RMenu:DeleteType('menu', true)
                end
            end
        else
            ESX.ShowNotification('~r~LystyLife ~w~~n~Vous devez être en Zone Safe pour utiliser le /invest')
        end
    end
end

local InAFK = false
Citizen.CreateThread(function()
    while true do
        if InAfkZone then
            if AfkTime >= 1 then
                if #(GetEntityCoords(PlayerPedId()) - vector3(482.998, 4812.112, -58.384)) > 50 then
                    SetEntityCoords(PlayerPedId(), vector3(482.998, 4812.112, -58.384))
                end
                DrawMissionText('~w~Vous êtes dans la ~r~Zone Investissement~w~ !\nVotre investissement est terminer dans ~r~'..AfkTime..' ~w~minutes', 100)
                InAFK = true
            else
                InAFK = false
            end
        else
            InAFK = false
        end
        if InAfkZone and AfkTime >= 1 then
            Wait(0)
        else
            Wait(2500)
        end
    end
end)

function OpenAFKMenuInvest()
	local menu = RageUI.CreateMenu("Menu Investissement", "Gagne de l'argent en étant AFK") 
    menu:SetSizeWidth(99)
    menu.Closable = false
    RageUI.Visible(menu, not RageUI.Visible(menu))

	while menu do
		Citizen.Wait(0)
        RageUI.IsVisible(menu, function()
            RageUI.Separator('Investissement en cours !')
            RageUI.Separator('Investis ton argent et double l\'investissement')
            RageUI.Separator('')
            RageUI.Button('Retourner en RP', 'Vous pourrez reprendre votre investissement la ou vous l\'avez arrêter', {}, true, {onSelected = function()
                InAfkZone = false
                SetEntityCoords(PlayerPedId(), vector3(239.6025, -763.1501, 30.826))
                RageUI.CloseAll()
            end})
            if AfkTime <= 0 then 
                RageUI.CloseAll()
            end
        end, function()
        end)

        if not RageUI.Visible(menu) then
            menu = RMenu:DeleteType('menu', true)
        end
    end
end