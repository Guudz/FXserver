LystyLife.Ambulance = {}
IsInServiceEMS = false
LystyLife.Ambulance.OpenGetItemSoins = function()
    local menu = RageUI.CreateMenu('Emergency System', "Prends les objets que tu souhaites")

    RageUI.Visible(menu, not RageUI.Visible(menu))
    while menu do
        Citizen.Wait(0)
        RageUI.IsVisible(menu, function()
            RageUI.Button('Trousse de soin', nil, {RightLabel = '>'}, true, {
                onSelected = function() 
                    LystyLifeClientUtils.toServer('EMS:GetItemSoins', 'medikit')
                end
            })
            RageUI.Button('Bandage', nil, {RightLabel = '>'}, true, {
                onSelected = function()
                    LystyLifeClientUtils.toServer('EMS:GetItemSoins', 'bandage')
                end
            })
        end, function()
        end)

        if not RageUI.Visible(menu) then
            menu = RMenu:DeleteType('menu', true)
        end
    end
end

LystyLife.Ambulance.OpenAmbulanceMenu = function()
    local menu = RageUI.CreateMenu('Emergency System', "Voici les appeles disponibles")
    local OpenInteractAmbulanceMenu = RageUI.CreateSubMenu(menu, "Emergency System", 'Actions disponible')
    local OpenPubMenuAmbulance = RageUI.CreateSubMenu(menu, "Emergency System", 'Actions disponible')
    RageUI.Visible(menu, not RageUI.Visible(menu))
    while menu do
        Citizen.Wait(0)
        RageUI.IsVisible(menu, function()
            RageUI.Button('Menu Intéraction', nil, {RightLabel = '>'}, true, {
                onSelected = function() 
                end
            }, OpenInteractAmbulanceMenu)
            RageUI.Button('Menu Publicitaire', nil, {RightLabel = '>'}, true, {
                onSelected = function() 
                end
            }, OpenPubMenuAmbulance)
        end, function()
        end)

        RageUI.IsVisible(OpenInteractAmbulanceMenu, function()
            RageUI.Button('Réanimer', nil, {RightLabel = '>'}, true, {
                onSelected = function()
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                    if closestPlayer == -1 or closestDistance > 3.0 then
                        ESX.ShowNotification('~r~LystyLife~w~~n~Aucun joueur au alentours.')
                    else
                        TaskStartScenarioInPlace(PlayerPedId(), 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
                        Citizen.Wait(10000)
                        ClearPedTasks(PlayerPedId())
                        LystyLifeClientUtils.toServer('EMS:RevivePlayer', GetPlayerServerId(closestPlayer))
                    end
                end
            })
            RageUI.Button('Mettre une Facture', nil, {RightLabel = '>'}, true, {
                onSelected = function() 
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                    if closestPlayer == -1 or closestDistance > 3.0 then
                        ESX.ShowNotification('~r~Erreur ~w~~n~Il n\'y a aucun joueur au alentours')
                    else
                        local string = KeyboardInput('Montant de la facture', ('Montant de la facture'), '', 999)
                        if string ~= "" then
                            Montant = tonumber(string)
                        end
                        LystyLifeClientUtils.toServer("Core:AddBilling", GetPlayerServerId(closestPlayer), tonumber(Montant), 'ambulance')
                    end
                end
            })
            RageUI.Button('Faire un bandage', nil, {RightLabel = '>'}, true, {
                onSelected = function()
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                    if closestPlayer == -1 or closestDistance > 3.0 then
                        ESX.ShowNotification('~r~LystyLife~w~~n~Aucun joueur au alentours.')
                    else
                        TaskStartScenarioInPlace(PlayerPedId(), 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
                        Citizen.Wait(10000)
                        ClearPedTasks(PlayerPedId())
                        LystyLifeClientUtils.toServer('EMS:HealPlayer', GetPlayerServerId(closestPlayer))
                    end
                end
            })
        end)

        RageUI.IsVisible(OpenPubMenuAmbulance, function()
            RageUI.Button('EMS Disponible', nil, {RightLabel = '>'}, true, {
                onSelected = function()
                    LystyLifeClientUtils.toServer('EMS:Annonce', 'open')
                end
            })
            RageUI.Button('EMS Indisponible', nil, {RightLabel = '>'}, true, {
                onSelected = function()
                    LystyLifeClientUtils.toServer('EMS:Annonce', 'close')
                end
            })
        end)

        if not RageUI.Visible(menu) and not RageUI.Visible(OpenInteractAmbulanceMenu) and not RageUI.Visible(OpenPubMenuAmbulance) then
            menu = RMenu:DeleteType('menu', true)
        end
    end
end

LystyLife.Ambulance.OpenVestiaire = function()
    local menu = RageUI.CreateMenu('Emergency System', "Voici les appeles disponibles")
    RageUI.Visible(menu, not RageUI.Visible(menu))
    while menu do
        Citizen.Wait(0)
        RageUI.IsVisible(menu, function()
            RageUI.Button('Prise de Service', nil, {RightLabel = '>'}, true, {
                onSelected = function()
                    IsInServiceEMS = true
                    LystyLifeClientUtils.toServer('EMS:Service', true)
                    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                        if skin.sex == 0 then
                            --Homme
                            TriggerEvent('skinchanger:loadClothes', skin, {
                                ['tshirt_1'] = 202, ['tshirt_2'] = 0,
                                ['torso_1'] = 445, ['torso_2'] = 3,
                                ['decals_1'] = 0, ['decals_2'] = 0,
                                ['arms'] = 90,
                                ['pants_1'] = 146, ['pants_2'] = 0,
                                ['shoes_1'] = 25, ['shoes_2'] = 0,
                                ['chain_1'] = 182, ['chain_2'] = 0
                            })
                        else
                            -- Femme
                            TriggerEvent('skinchanger:loadClothes', skin, {
                                ['tshirt_1'] = 222, ['tshirt_2'] = 0,
                                ['torso_1'] = 456, ['torso_2'] = 3,
                                ['decals_1'] = 0, ['decals_2'] = 0,
                                ['arms'] = 103,
                                ['pants_1'] = 150, ['pants_2'] = 0,
                                ['shoes_1'] = 25, ['shoes_2'] = 0,
                                ['chain_1'] = 0, ['chain_2'] = 0
                            })
                        end
                    end)
                end
            })
            RageUI.Button('Fin de Service', nil, {RightLabel = '>'}, true, {
                onSelected = function()
                    IsInServiceEMS = false
                    LystyLifeClientUtils.toServer('EMS:Service', false)
                    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                        TriggerEvent('skinchanger:loadSkin', skin)
                    end)
                end
            })
        end, function()
        end)

        if not RageUI.Visible(menu) then
            menu = RMenu:DeleteType('menu', true)
        end
    end
end

LystyLife.netRegisterAndHandle('EMS:HealClientPlayer', function()
    local healt = GetEntityHealth(PlayerPedId())
    if healt >= 175 then
        HealtMax = 200
    else
        HealtMax = healt + 25
    end
    SetEntityHealth(PlayerPedId(), HealtMax)
end)