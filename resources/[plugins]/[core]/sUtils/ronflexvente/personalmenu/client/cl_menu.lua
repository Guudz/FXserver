local pma = exports["pma-voice"]
local currentChannel = 0
local itemCooldown = false

RonflexMenu = {

    Indexaccesories = 1,
    IndexgestionAccesories = 1,
    IndexClothes = 1,
    Indexinvetory = 1,
    IndexVetement = 1,
    Accesoires = 1,
    Indexdoor = 1,
    LimitateurIndex = 1,
    Item = true,
    Weapon = true,
    Radar = true,
    Vetement = true,
    AccesoiresMenu = true,
    Report = true,
    ui = true,
    TickRadio = false,
    InfosRadio = false,
    Bruitages = true,
    Statut = "~g~Allumé",
    VolumeRadio = 1,

    DoorState = {
        FrontLeft = false,
        FrontRight = false,
        BackLeft = false,
        BackRight = false,
        Hood = false,
        Trunk = false
    },

    voiture_limite = {
        "50 km/h",
        "80 km/h",
        "130 km/h",
        "Personalisée",
        "Désactiver"
    },
}
function startAnimAction(lib, anim)
	ESX.Streaming.RequestAnimDict(lib, function()
		TaskPlayAnim(plyPed, lib, anim, 8.0, 1.0, -1, 49, 0, false, false, false)
		RemoveAnimDict(lib)
	end)
end
Masque = true 

function GetCurrentWeight()
	local currentWeight = 0
	for i = 1, #ESX.PlayerData.inventory, 1 do
		if ESX.PlayerData.inventory[i].count > 0 then
			currentWeight = currentWeight + (ESX.PlayerData.inventory[i].weight * ESX.PlayerData.inventory[i].count)
		end
	end
	return currentWeight
end

local BillData = {}

openMenuF5 = function()

    local mainf5 = RageUI.CreateMenu("Menu Interaction", "Voici les actions disponibles")
    
    --Menu Principaux
    local invetory = RageUI.CreateSubMenu(mainf5, "Inventaire", "Voici votre inventaire")
    local portefeuille = RageUI.CreateSubMenu(mainf5, "Portefeuille", "Voici votre portefeuille")
    local vehicle = RageUI.CreateSubMenu(mainf5, "Gestion véhicule", "Voici les actions disponibles")
    local vetmenu = RageUI.CreateSubMenu(mainf5, "Vêtement", "Actions vêtements")
    local radio = RageUI.CreateSubMenu(mainf5, "Radio", "Voici les actions disponibles")
    local diversmenu = RageUI.CreateSubMenu(mainf5, "Divers", "Voici les actions disponibles")

    local actioninventory = RageUI.CreateSubMenu(invetory, "Inventaire", "Voici les actions disponibles")
    local actionweapon = RageUI.CreateSubMenu(invetory, "Armes", "Voici les actions dipsonibles")

    local infojob = RageUI.CreateSubMenu(portefeuille, "Métier", "Voici les information sur votre travail")
    local infojob2 = RageUI.CreateSubMenu(portefeuille, "Oraganisation", "Voici les information sur votre organisation")
    local gestionjob = RageUI.CreateSubMenu(mainf5, "Gestion Entreprise", "Voici les information sur votre entreprise")
    local gestionjob2 = RageUI.CreateSubMenu(mainf5, "Gestion Organisation", "Voici les information sur votre organisation")
    local billingmenu = RageUI.CreateSubMenu(portefeuille, "Facture", "Voici vos facture")
    local gestionlicense = RageUI.CreateSubMenu(portefeuille, "License", "Voici vos license")
    local gestionaccesories = RageUI.CreateSubMenu(vetmenu, "Gestion Accesoires", "Voici vos accésoires")
    mainf5.Closed = function()end 
    radio.EnableMouse = true
    RageUI.Visible(mainf5, not RageUI.Visible(mainf5))

    ESX.TriggerServerCallback("ronflex:getradio", function(cb)
        RonflexMenu.InfosRadio = cb
    end)

    while mainf5 do
        Wait(0)

        RageUI.IsVisible(mainf5, function()

            RageUI.Separator("[  Joueur : ~r~".. GetPlayerName(PlayerId()) .."~s~ | ID : ~r~"..GetPlayerServerId(PlayerId()).."~s~  ]")
            
            RageUI.Info('~r~Lysty~w~Life', {'Job : ', 'Grade Job : ', '--------------------------', 'Faction : ', 'Grade Faction : '}, {ESX.PlayerData.job.label, ESX.PlayerData.job.grade_label, '--------------------------', ESX.PlayerData.job2.label, ESX.PlayerData.job2.grade_label})


            RageUI.Button("> Inventaire", "Accéder à votre inventaire", {RightLabel = "→→→"}, true, {}, invetory)

            RageUI.Button("> Portefeuille", "Votre Portefeuille", {RightLabel = "→→→"}, true, {}, portefeuille)

            if IsPedSittingInAnyVehicle(PlayerPedId()) then 
                RageUI.Button('> Gestion véhicule', 'Actions sur le véhicule', {RightLabel = "→→→"}, true, {}, vehicle)
            end

            RageUI.Button("> Vêtements", "Actions sur vos vêtements", {RightLabel = "→→→"}, true, {}, vetmenu)
            RageUI.Button('> Animations', nil, {RightLabel = "→→→" }, true, {onSelected = function() Wait(150) ExecuteCommand('emotemenu') end});


            if ESX.PlayerData.job.grade_name == "boss" then 
                RageUI.Button("> Gestion Entreprise", nil, {RightLabel = "→→→"}, true, {
                    onSelected = function()
                    end
                }, gestionjob)
            end

            if ESX.PlayerData.job2.grade_name == "boss" then 
                RageUI.Button("> Gestion Organisation", nil, {RightLabel = "→→→"}, true, {
                    onSelected = function()
                    end
                }, gestionjob2)
            end

            RageUI.Button("> Radio", "Accéder à la radio", {RightLabel = "→→→"}, RonflexMenu.InfosRadio, {
                onSelected = function()
                end
            }, radio)

            RageUI.Button("> Divers", "Actions diverses", {RightLabel = "→→→"}, true, {}, diversmenu)
        
        end, function()
        end)

        RageUI.IsVisible(invetory, function()
            ESX.PlayerData = ESX.GetPlayerData()

            RageUI.Separator('Poids > '.. GetCurrentWeight() + 0.0 .. '/' .. ESX.PlayerData.maxWeight + 0.0)

            RageUI.List("Filtre", {"Aucun", "Inventaire", "Armes", "Vetements", "Accesoires"}, RonflexMenu.Indexinvetory, nil, {}, true, {
                onListChange = function(index)
                    RonflexMenu.Indexinvetory = index 
                    if index == 1 then 
                        RonflexMenu.Item, RonflexMenu.Weapon, RonflexMenu.Vetement, RonflexMenu.AccesoiresMenu = true, true, true, true
                    elseif index == 2 then 
                        RonflexMenu.Item, RonflexMenu.Weapon, RonflexMenu.Vetement, RonflexMenu.AccesoiresMenu = true, false, false, false
                    elseif index == 3 then 
                        RonflexMenu.Item, RonflexMenu.Weapon, RonflexMenu.Vetement, RonflexMenu.AccesoiresMenu = false, true, false, false
                    elseif index == 4 then 
                        RonflexMenu.Item, RonflexMenu.Weapon, RonflexMenu.Vetement, RonflexMenu.AccesoiresMenu = false, false, true, false
                    elseif index == 5 then 
                        RonflexMenu.Item, RonflexMenu.Weapon, RonflexMenu.Vetement, RonflexMenu.AccesoiresMenu = false, false, false, true
                    end
                end
            })

            if RonflexMenu.Item then 
                if #ESX.PlayerData.inventory > 0 then 
                    RageUI.Separator("↓ Item ↓")
                    for k, v in pairs(ESX.PlayerData.inventory) do 
                        if v.count > 0 then 
                            RageUI.Button("> "..v.label.."", nil,  {RightLabel = "Quantité : ~r~x"..v.count..""}, not itemCooldown, {
                                onSelected = function()
                                    count = v.count 
                                    label  = v.label
                                    name = v.name
                                    remove = v.canRemove
                                    Wait(100)
                                end
                            }, actioninventory)
                        end
                    end
                else
                    RageUI.Separator("~r~Aucun Item")
                end
            end

            if RonflexMenu.Weapon then 
                if #Player.WeaponData > 0 then 
                    RageUI.Separator("↓ Armes ↓")
                    for i = 1, #Player.WeaponData, 1 do
                        if HasPedGotWeapon(PlayerPedId(), Player.WeaponData[i].hash, false) then
                            local ammo = GetAmmoInPedWeapon(PlayerPedId(), Player.WeaponData[i].hash)
                            RageUI.Button("> "..Player.WeaponData[i].label, nil, { RightLabel = "Munition(s) : ~r~x"..ammo }, true, {
                                onSelected = function()
                                    ammooweapon = ammo 
                                    name = Player.WeaponData[i].name 
                                    labelweapon = Player.WeaponData[i].label
                                    Wait(100)
                                end
                            }, actionweapon)
                        end
                    end
                else
                    RageUI.Separator("~r~Aucune Armes")
                end
            end

            if RonflexMenu.Vetement then 
                if ClothesPlayer ~= nil  then 
                    RageUI.Separator("Vetement")
                    for k, v in pairs(ClothesPlayer) do 
                        if v.label ~= nil and v.type == "vetement" and v.equip ~= "n" then 
                            RageUI.List("> Tenue "..v.label, {"Equiper", "Renomer", "Supprimer", "Donner"}, RonflexMenu.IndexVetement, nil, {}, true, {
                                onListChange = function(Index)
                                    RonflexMenu.IndexVetement = Index
                                end,
                                onSelected = function(Index)
                                    if Index == 1 then 
                                        startAnimAction('clothingtie', 'try_tie_neutral_a')
                                        Wait(1000)
                                        ExecuteCommand("me équipe une tenue")
                                        TriggerEvent("skinchanger:getSkin", function(skin)
                                            TriggerEvent("skinchanger:loadClothes", skin, json.decode(v.skin))
                                        end)
                                        TriggerEvent("skinchanger:getSkin", function(skin)
                                            TriggerServerEvent("esx_skin:save", skin)
                                        end)
                                    elseif Index == 2 then 
                                        local newname = KeyboardInput("Nouveau nom","Nouveau nom", "", 15)
                                        if newname then 
                                            TriggerServerEvent("ewen:RenameTenue", v.id, newname)
                                        end
                                    elseif Index == 3 then 
                                        TriggerServerEvent('ronflex:deletetenue', v.id)
                                    elseif Index == 4 then 
                                        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                                        if closestDistance ~= -1 and closestDistance <= 3 then
                                            local closestPed = GetPlayerPed(closestPlayer)
                                            TriggerServerEvent("ronflex:donnertenue", GetPlayerServerId(closestPlayer), v.id)
                                            RageUI.CloseAll()
                                        else
                                            ESX.ShowNotification("Personne aux alentours")
                                        end
                                    end
                                end,
                              
                            })
                        end
                    end
                else
                    RageUI.Separator("~r~Aucune Tenue")
                end
            end

            if RonflexMenu.AccesoiresMenu then 
                if ClothesPlayer ~= nil then 
                    RageUI.Separator("Accesoires")
                    if not ClothesPlayer ~= nil then
                        for k, v in pairs(ClothesPlayer) do 
                            if v.label ~= nil and v.type ~= "vetement" then 
                                RageUI.List("> "..v.type..' '..v.label, {"Equiper", "Renomer", "Supprimer", "Donner"}, RonflexMenu.IndexVetement, nil, {}, true, {
                                    onListChange = function(Index)
                                        RonflexMenu.IndexVetement = Index
                                    end,
                                    onSelected = function(Index)
                                        if Index == 1 then 
                                            startAnimAction('clothingtie', 'try_tie_neutral_a')
                                            Wait(1000)
                                            ExecuteCommand("me équipe un "..v.type)
                                            TriggerEvent("skinchanger:getSkin", function(skin)
                                                TriggerEvent("skinchanger:loadClothes", skin, json.decode(v.skin))
                                            end)
                                            TriggerEvent("skinchanger:getSkin", function(skin)
                                                TriggerServerEvent("esx_skin:save", skin)
                                            end)
                                        elseif Index == 2 then 
                                            local newname = KeyboardInput("Nouveau nom","Nouveau nom", "", 15)
                                            if newname then 
                                                TriggerServerEvent("ewen:RenameTenue", v.id, newname)
                                            end
                                        elseif Index == 3 then 
                                            ExecuteCommand("me supprime le/la "..v.type.." ")
                                            TriggerServerEvent('ronflex:deletetenue', v.id)
                                        elseif Index == 4 then 
                                            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                                            if closestDistance ~= -1 and closestDistance <= 3 then
                                                local closestPed = GetPlayerPed(closestPlayer)
                                                TriggerServerEvent("ronflex:donnertenue", GetPlayerServerId(closestPlayer), v.id)
                                                RageUI.CloseAll()
                                            else
                                                ESX.ShowNotification("Personne aux alentours")
                                            end
                                        end
                                    end
                                })
                            end
                        end
                    end
                else
                    RageUI.Separator("~r~Aucun Accésoire")
                end
            end

        end, function()
        end)

        RageUI.IsVisible(portefeuille, function()

            local player, closestplayer = ESX.Game.GetClosestPlayer()

            RageUI.Separator('[Information Compte]')

            for i = 1, #ESX.PlayerData.accounts, 1 do
                if ESX.PlayerData.accounts[i].name == 'bank'  then
                    RageUI.Button('Argent en banque: ~r~'..ESX.PlayerData.accounts[i].money.."$", nil, {RightLabel = ""}, true, {})
                end
            end
			
            for i = 1, #ESX.PlayerData.accounts, 1 do
                if ESX.PlayerData.accounts[i].name == 'cash'  then
                    RageUI.Button('Argent en liquide: ~g~'..ESX.PlayerData.accounts[i].money.."$", nil, {RightLabel = ""}, true, {
                        onActive = function()
                            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                            if closestDistance ~= -1 and closestDistance <= 3 then
                                PlayerMakrer(closestPlayer)
                            end
                        end,
                        onSelected = function()
                            local check, quantity = CheckQuantity(KeyboardInput("Nombres d'argent que vous voulez donner", '', '', 100))
                            if check then 
                                local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

                                if closestDistance ~= -1 and closestDistance <= 3 then
                                    local closestPed = GetPlayerPed(closestPlayer)
                                    if not IsPedSittingInAnyVehicle(closestPed) then
                                        TriggerServerEvent('esx:giveInventoryItem', GetPlayerServerId(closestPlayer), 'item_account', "cash", quantity)
                                        RageUI.GoBack()
                                    else
                                        ESX.ShowNotification("~r~Vous ne pouvez pas faire ceci dans un véhicule !")
                                    end
                                else
                                    ESX.ShowNotification('Aucun joueur proche !')
                                end
                            else
                                ESX.ShowNotification("Arguments Inssufisant")
                            end
                        end
                    })
                end
            end

            for i = 1, #ESX.PlayerData.accounts, 1 do
                if ESX.PlayerData.accounts[i].name == 'dirtycash'  then
                    RageUI.Button('Argent non déclaré: ~r~'..ESX.PlayerData.accounts[i].money.."$", nil, {RightLabel = ""}, true, {
                        onActive = function()
                            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                            if closestDistance ~= -1 and closestDistance <= 3 then
                                PlayerMakrer(closestPlayer)
                            end
                        end,
                        onSelected = function()
                            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                            local check, quantity = CheckQuantity(KeyboardInput("Nombres d'argent que vous voulez donner", '', '', 100))
                            if check then 
                                if closestDistance ~= -1 and closestDistance <= 3 then
                                    local closestPed = GetPlayerPed(closestPlayer)
                                    if not IsPedSittingInAnyVehicle(closestPed) then
                                        TriggerServerEvent('esx:giveInventoryItem', GetPlayerServerId(closestPlayer), 'item_account', "dirtycash", quantity)
                                        RageUI.GoBack()
                                    else
                                        ESX.ShowNotification("~r~Vous ne pouvez pas faire ceci dans un véhicule !")
                                    end
                                else
                                    ESX.ShowNotification('Aucun joueur proche !')
                                end
                            else
                                ESX.ShowNotification("Arguments Inssufisant")
                            end
                        end
                    })
                end
            end
			
            RageUI.Button("> Accéder à vos factures", nil, {RightLabel = "→→→"}, true, {
                onSelected = function()
                    ESX.TriggerServerCallback('ewen:getFactures', function(bills) BillData = bills end)
                end
            }, billingmenu)

            RageUI.Separator("[Information Personnelles]")

            RageUI.Button("Information Métier", "Accéder aux information de votre métier", {RightLabel = "→→→"}, true, {onSelected = function()RefreshMoney()end}, infojob)

            RageUI.Button("Information Organisation", "Accéder aux information de votre organisation", {RightLabel = "→→→"}, true, {onSelected = function()RefreshMoney2()end}, infojob2)

            RageUI.Button("> Gestion License", nil, {RightLabel = "→→→"}, true, {}, gestionlicense)

        end, function()
        end)

        RageUI.IsVisible(vehicle, function()

            local pVeh = GetVehiclePedIsUsing(PlayerPedId())

            local vModel = GetEntityModel(pVeh)
            if IsPedInAnyVehicle(PlayerPedId(), true) then 
                local vPlate = GetVehicleNumberPlateText(GetVehiclePedIsIn(PlayerPedId()), false)
                local vName = GetDisplayNameFromVehicleModel(vModel) --Avoir le nom du véhicule
                local Essence = GetVehicleFuelLevel(pVeh)
                local vMoteur = GetVehicleEngineHealth(pVeh)
                RageUI.Separator('[Plaque]   '..vPlate ..'')
                RageUI.Separator('[Modèle]   '..vName..'')
                RageUI.Separator('[Moteur]   '..math.floor(ESX.Math.Round(vMoteur/10, 0)..'%'))
                --RageUI.Separator('[Essence]   '..math.floor(ESX.Math.Round(Essence, 0)..'%'))
                SetPlayerCanDoDriveBy(PlayerId(), false)
            else
                RageUI.Separator('[Plaque]   '.."Non défini" ..'')
                RageUI.Separator('[Modèle]   '.."Non défini"..'')
                RageUI.Separator('[Essence]   '.."Non défini"..'')
                RageUI.Separator('[Moteur]    '.."Non défini")
            end

            RageUI.Button("Allumer / Eteindre le moteur", nil, {RightLabel = RonflexMenu.Statut}, true, {
                onSelected = function()
                    if GetIsVehicleEngineRunning(pVeh) then
                        RonflexMenu.Statut = "~r~Eteint"

                        SetVehicleEngineOn(pVeh, false, false, true)
                        SetVehicleUndriveable(pVeh, true)
                    elseif not GetIsVehicleEngineRunning(pVeh) then
                        RonflexMenu.Statut = "~g~Allumé"

                        SetVehicleEngineOn(pVeh, true, false, true)
                        SetVehicleUndriveable(pVeh, false)
                    end
                end
            })

            RageUI.List("Ouvrir / Fermer porte", {"Avant gauche", "Avant Droite", "Arrière Gauche", "Arrière Droite", "Capot", "Coffre"}, RonflexMenu.Indexdoor, nil, {}, true, {
                onListChange = function(index)
                    RonflexMenu.Indexdoor = index 
                end,
                onSelected = function(index)
                    
                    if index == 1 then
                        if not RonflexMenu.DoorState.FrontLeft then
                            RonflexMenu.DoorState.FrontLeft = true
                            SetVehicleDoorOpen(pVeh, 0, false, false)
                        elseif RonflexMenu.DoorState.FrontLeft then
                            RonflexMenu.DoorState.FrontLeft = false
                            SetVehicleDoorShut(pVeh, 0, false, false)
                        end
                    elseif index == 2 then
                        if not RonflexMenu.DoorState.FrontRight then
                            RonflexMenu.DoorState.FrontRight = true
                            SetVehicleDoorOpen(pVeh, 1, false, false)
                        elseif RonflexMenu.DoorState.FrontRight then
                            RonflexMenu.DoorState.FrontRight = false
                            SetVehicleDoorShut(pVeh, 1, false, false)
                        end
                    elseif index == 3 then
                        if not RonflexMenu.DoorState.BackLeft then
                            RonflexMenu.DoorState.BackLeft = true
                            SetVehicleDoorOpen(pVeh, 2, false, false)
                        elseif RonflexMenu.DoorState.BackLeft then
                            RonflexMenu.DoorState.BackLeft = false
                            SetVehicleDoorShut(pVeh, 2, false, false)
                        end
                    elseif index == 4 then
                        if not RonflexMenu.DoorState.BackRight then
                            RonflexMenu.DoorState.BackRight = true
                            SetVehicleDoorOpen(pVeh, 3, false, false)
                        elseif RonflexMenu.DoorState.BackRight then
                            RonflexMenu.DoorState.BackRight = false
                            SetVehicleDoorShut(pVeh, 3, false, false)
                        end
                    elseif index == 5 then 
                        if not RonflexMenu.DoorState.Hood then
                            RonflexMenu.DoorState.Hood = true
                            SetVehicleDoorOpen(pVeh, 4, false, false)
                        elseif RonflexMenu.DoorState.Hood then
                            RonflexMenu.DoorState.Hood = false
                            SetVehicleDoorShut(pVeh, 4, false, false)
                        end
                    elseif index == 6 then 
                        if not RonflexMenu.DoorState.Trunk then
                            RonflexMenu.DoorState.Trunk = true
                            SetVehicleDoorOpen(pVeh, 5, false, false)
                        elseif RonflexMenu.DoorState.Trunk then
                            RonflexMenu.DoorState.Trunk = false
                            SetVehicleDoorShut(pVeh, 5, false, false)
                        end
                    end
                end
            })

            RageUI.Button("Fermer toutes les portes", nil, {RightLabel =  "→→→"}, true, {
                onSelected = function ()
                    for door = 0, 7 do
                        SetVehicleDoorShut(pVeh, door, false)
                    end
                end
            })

            RageUI.List("Limitateur", RonflexMenu.voiture_limite, RonflexMenu.LimitateurIndex, nil, {}, true, {
                onListChange = function(i, item)
                    RonflexMenu.LimitateurIndex = i
                end,

                onSelected = function(i, item)
                    if i == 1 then
                        SetEntityMaxSpeed(GetVehiclePedIsIn(PlayerPedId(), false), 50.0/3.6)
                        ESX.ShowNotification("Limitateur de vitesse défini sur ~r~50 km/h")
                    elseif i == 2 then  
                        SetEntityMaxSpeed(GetVehiclePedIsIn(PlayerPedId(), false), 80.0/3.6)
                        ESX.ShowNotification("Limitateur de vitesse défini sur ~r~80 km/h")
                    elseif i == 3  then
                        SetEntityMaxSpeed(GetVehiclePedIsIn(PlayerPedId(), false), 130.0/3.6)
                        ESX.ShowNotification("Limitateur de vitesse défini sur ~r~130 km/h")
                    elseif i == 4 then
                        local speed = KeyboardInput("Indiquer la vitesse", "Indiquer la viteese", "", 10)
                        if speed ~= nil or speed ~= tostring("") then 
                            SetEntityMaxSpeed(GetVehiclePedIsIn(PlayerPedId(), false), ESX.Math.Round(speed, 1)/3.6)
                            ESX.ShowNotification("Limitateur de vitesse défini sur ~r~"..speed..'km/h')
                        else
                            return
                        end
                    elseif i == 5 then 
                        SetEntityMaxSpeed(GetVehiclePedIsIn(PlayerPedId(), false), 10000.0/3.6)    
                        ESX.ShowNotification("Limitateur de vitesse désactivé")
                    end
                end
            })

   
        
        end, function()
        end)

        RageUI.IsVisible(vetmenu, function()

            RageUI.List(" Vetement", {"Haut", "Bas", "Chaussures", "Sac", "Giltet par balle"}, RonflexMenu.IndexClothes, nil, {LeftBadge = RageUI.BadgeStyle.Clothes}, true, {
                onListChange = function(index)
                    RonflexMenu.IndexClothes = index 
                end, 
                onSelected = function(index)
                    ESX.TriggerServerCallback("esx_skin:getPlayerSkin", function(skin)
                        TriggerEvent("skinchanger:getSkin", function(skina)
                            if index == 1 then 
                                if skin.torso_1 ~= skina.torso_1 then
                                    ExecuteCommand("me remet son haut")
                                    TriggerEvent("skinchanger:loadClothes", skina, { ["torso_1"] = skin.torso_1, ["torso_2"] = skin.torso_2, ["tshirt_1"] = skin.tshirt_1, ["tshirt_2"] = skin.tshirt_2, ["arms"] = skin.arms })
                                else
                                    ExecuteCommand("me retire son haut")
                                    if skin.sex == 0 then
                                        TriggerEvent("skinchanger:loadClothes", skina, { ["torso_1"] = 15, ["torso_2"] = 0, ["tshirt_1"] = 15, ["tshirt_2"] = 0, ["arms"] = 15 })
                                    else
                                        TriggerEvent("skinchanger:loadClothes", skina, { ["torso_1"] = 15, ["torso_2"] = 0, ["tshirt_1"] = 15, ["tshirt_2"] = 0, ["arms"] = 15 })
                                    end
                                end
                            elseif index == 2 then 
                                if skin.pants_1 ~= skina.pants_1 then
                                    ExecuteCommand("me remet son pantalon")
                                    TriggerEvent("skinchanger:loadClothes", skina, { ["pants_1"] = skin.pants_1, ["pants_2"] = skin.pants_2 })
                                else
                                    ExecuteCommand("me retire son pantalon")
                                    if skin.sex == 0 then
                                        TriggerEvent("skinchanger:loadClothes", skina, { ["pants_1"] = 14, ["pants_2"] = 0 })
                                    else
                                        TriggerEvent("skinchanger:loadClothes", skina, { ["pants_1"] = 15, ["pants_2"] = 0 })
                                    end
                                end
                            elseif index == 3 then 
                                if skin.shoes_1 ~= skina.shoes_1 then
                                    ExecuteCommand("me remet ses chaussures")
                                    TriggerEvent("skinchanger:loadClothes", skina, { ["shoes_1"] = skin.shoes_1, ["shoes_2"] = skin.shoes_2 })
                                else
                                    if skin.sex == 0 then
                                        ExecuteCommand("me enlève ses chaussures")
                                        TriggerEvent("skinchanger:loadClothes", skina, { ["shoes_1"] = 34, ["shoes_2"] = 0 })
                                    else
                                        TriggerEvent("skinchanger:loadClothes", skina, { ["shoes_1"] = 46, ["shoes_2"] = 0 })
                                    end
                                end
                            elseif index == 4 then
                                if skin.bags_1 ~= skina.bags_1 then
                                    ExecuteCommand("me retire son sac")
                                    TriggerEvent("skinchanger:loadClothes", skina, { ["bags_1"] = skin.bags_1, ["bags_2"] = skin.bags_2 })
                                else
                                    ExecuteCommand("me retire son sac")
                                    TriggerEvent("skinchanger:loadClothes", skina, { ["bags_1"] = 0, ["bags_2"] = 0 })
                                end
                            elseif index == 5 then 
                                if skin.bproof_1 ~= skina.bproof_1 then
                                    ExecuteCommand("me retire son gilet par balle")
                                    TriggerEvent("skinchanger:loadClothes", skina, { ["bproof_1"] = skin.bproof_1, ["bproof_2"] = skin.bproof_2 })
                                else
                                    ExecuteCommand("me retire son gilet par balle")
                                    TriggerEvent("skinchanger:loadClothes", skina, { ["bproof_1"] = 0, ["bproof_2"] = 0 })
                                end
                            end
                        end)
                    end)
                end
            })

            RageUI.List('Accesoires', {"Masque","Chapeau", "Lunette", "Boucle d'oreilles"}, RonflexMenu.Indexaccesories, nil, {LeftBadge = RageUI.BadgeStyle.Mask}, true, {
                onListChange = function(Index)
                    RonflexMenu.Indexaccesories = Index;
                end,

                onSelected = function(Index)
                    if Index == 1 then
                        playerPed = GetPlayerPed(-1)
                        TriggerEvent('skinchanger:getSkin', function(skin)
                            local clothesSkin = { ['mask_1'] = 0,   ['mask_2'] = 0  }
                            TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
                            TriggerServerEvent('esx_skin:save', skin)
                        end)
                    elseif Index == 2 then
                        TriggerEvent('skinchanger:getSkin', function(skin)
                            local clothesSkin = {
                            ['helmet_1'] = -1,   ['helmet_2'] = 0
                            }
                            TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
                            TriggerServerEvent('esx_skin:save', skin)
                        end)
                    elseif Index == 3 then
                        playerPed = GetPlayerPed(-1)
                        ClearPedProp(playerPed, 1)
                        TriggerEvent('skinchanger:getSkin', function(skin)
                            local clothesSkin = {['glasses_1'] = 0,   ['glasses_2'] = 0 }
                            TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
                            TriggerServerEvent('esx_skin:save', skin)
                        end)
                    end
                end
            })

        end, function()
        end)

        RageUI.IsVisible(radio, function()

            RageUI.Button("Allumer / Eteindre", "Vous permet d'allumer ou d'éteindre la radio", {RightLabel = "→→→"}, true, {
                onSelected = function()
                    if not RonflexMenu.TickRadio then 
                        RonflexMenu.TickRadio = true 
                        pma:setVoiceProperty("radioEnabled", true)
                        ESX.ShowNotification("~r~LystyLife~s~~n~Radio Allumé !")
                    else
                        RonflexMenu.TickRadio = false
                        pma:setRadioChannel(0)
                        pma:setVoiceProperty("radioEnabled", false)
                        ESX.ShowNotification("~r~LystyLife~s~~n~Radio Eteinte !")
                    end
                end
            })

            if RonflexMenu.TickRadio then
                RageUI.Separator("Radio: ~g~Allumée")

                if RonflexMenu.Bruitages then 
                    RageUI.Separator("Bruitages: ~g~Activés")
                else
                    RageUI.Separator("Bruitages: ~r~Désactivés")
                end

                if RonflexMenu.VolumeRadio*100 <= 20 then 
                    ColorRadio = "~g~" 
                elseif RonflexMenu.VolumeRadio*100 <= 45 then 
                    ColorRadio ="~y~" 
                elseif RonflexMenu.VolumeRadio*100 <= 65 then 
                    ColorRadio ="~r~" 
                elseif RonflexMenu.VolumeRadio*100 <= 100 then 
                    ColorRadio ="~r~" 
                end 

                RageUI.Separator("Volume: "..ColorRadio..ESX.Math.Round(RonflexMenu.VolumeRadio*100).."~s~ %")
                RageUI.Button("Se connecter à une fréquence ", "Choissisez votre fréquence", {RightLabel = RonflexMenu.Frequence}, true, {
                    onSelected = function()
                        local verif, Frequence = CheckQuantity(KeyboardInput("Frequence", "Frequence", "", 10))
                        if verif then
                            RonflexMenu.Frequence = tostring(Frequence)
                            pma:setRadioChannel(Frequence)
                            ESX.ShowNotification("~r~LystyLife~s~~n~Fréquence définie sur "..Frequence.." MHZ")
                        end
                    end
                })

                RageUI.Button("Se déconnecter de la fréquence", "Vous permet de déconnecter de votre fréquence actuelle", {RightLabel = "→→→"}, true, {
                    onSelected = function()
                        pma:setRadioChannel(0)
                        RonflexMenu.Frequence = "0"
                        ESX.ShowNotification("Vous vous êtes déconnecter de la fréquence")
                    end
                })

                RageUI.Button("Activer les bruitages", "Vous permet d'activer les bruitages'", {RightLabel = "→→→"}, true, {
                    onSelected = function()
                        if RonflexMenu.Bruitages then 
                            RonflexMenu.Bruitages = false
                            pma:setVoiceProperty("micClicks", false)
                            ESX.ShowNotification("Bruitages radio désactives")
                        else
                            RonflexMenu.Bruitages = true 
                            ESX.ShowNotification("Bruitages radio activés")
                            pma:setVoiceProperty("micClicks", true)
                        end
                    end
                })
            else
                RageUI.Separator("Radio: ~r~Eteinte")
            end

        end, function()
            RageUI.PercentagePanel(RonflexMenu.VolumeRadio, 'Volume', '0%', '100%', {
                onProgressChange = function(Percentage)
                    RonflexMenu.VolumeRadio = Percentage
                    pma:setRadioVolume(Percentage)
                end
            }, 5) 
        end)

        RageUI.IsVisible(diversmenu, function()

            RageUI.Checkbox("Activer le radar", "Vous permet d'activer ou de désactiver la minimap", RonflexMenu.Radar, {}, {
                onChecked = function()
                end,
                onUnChecked = function()
                end,
                onSelected = function(Index)
                    DisplayRadar(RonflexMenu.Radar)
                    RonflexMenu.Radar = Index
                end
                
            })

            RageUI.Checkbox("Activer l'HUD", "Vous permet d'activer ou de désactiver l'HUD", RonflexMenu.ui, {}, {
                onChecked = function()
                end,
                onUnChecked = function()
                end,
                onSelected = function(Index)
                    TriggerEvent("tempui:toggleUi", not RonflexMenu.ui)
                    RonflexMenu.ui = Index
                end
                
            })

            RageUI.Checkbox('Mode cinématique', nil, cinemamode, {}, {
                onChecked = function()
                    ExecuteCommand('noir')
                    cinemamode = true
                end,
                onUnChecked = function()
                    ExecuteCommand('noir')
                    cinemamode = false
                end,
            })
          --  RageUI.Checkbox('Mode drift', description, driftmode, {RightLabel = 'Options VIP'}, {
            --    onChecked = function()
              --      if GetVIP() then
                --        driftmode = not driftmode
                  --  else
                    --    driftmode = false 
                      --  ESX.ShowNotification('~r~LystyLife~w~~n~Vous devez être ~r~VIP ~w~afin d\'activer le mode drift')
               --0     end
             --   end,
             --   onUnChecked = function()
             --       if GetVIP() then
             --           driftmode = false
             --       end
            --    end,
            --    onSelected = function(Index)
            --        if GetVIP() then
            --            driftmode = Index
           --         end
        --        end
           -- })

        
            RageUI.Checkbox('Désactiver les coups de crosse', description, coupCrosse, {}, {
                onChecked = function()
                    Citizen.CreateThread(function()
                        while coupCrosse do
                            Citizen.Wait(0)
                            local ped = PlayerPedId()
                            if IsPedArmed(ped, 6) then
                                DisableControlAction(1, 140, true)
                                DisableControlAction(1, 141, true)
                                DisableControlAction(1, 142, true)
                            end
                        end
                    end)
                end,
                onUnChecked = function()
                    coupCrosse = false
                end,
                onSelected = function(Index)
                    coupCrosse = Index
                end
            })

        end, function()
        end)
        
        RageUI.IsVisible(gestionjob, function()
        
            if ESX.PlayerData.job.grade_name == "boss" then 
                RageUI.Separator("[Entreprise]")

                RageUI.Button("Recruter un employé", nil, {RightLabel = "→→→"}, true, {
                    onActive = function()
                        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                        if closestDistance ~= -1 and closestDistance <= 3 then
                            PlayerMakrer(closestPlayer)
                        end
                    end, 
                    onSelected = function()
                        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                        if closestDistance ~= -1 and closestDistance <= 3 then
                            TriggerServerEvent("KorioZ-PersonalMenu:Boss_recruterplayer", GetPlayerServerId(closestPlayer), ESX.PlayerData.job.name)
                        else
                            ESX.ShowNotification("Aucun joueur à proximité")
                        end
                    end
                })

                RageUI.Button("Virer un employé", nil, {RightLabel = "→→→"}, true, {
                    onActive = function()
                        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                        if closestDistance ~= -1 and closestDistance <= 3 then
                            PlayerMakrer(closestPlayer)
                        end
                    end, 
                    onSelected = function()
                        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                        if closestDistance ~= -1 and closestDistance <= 3 then
                            TriggerServerEvent("KorioZ-PersonalMenu:Boss_virerplayer", GetPlayerServerId(closestPlayer))
                        else
                            ESX.ShowNotification("Aucun joueur à proximité")
                        end
                    end
                })

                RageUI.Button("Promouvroir un employé", nil, {RightLabel = "→→→"}, true, {
                    onActive = function()
                        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                        if closestDistance ~= -1 and closestDistance <= 3 then
                            PlayerMakrer(closestPlayer)
                        end
                    end, 
                    onSelected = function()
                        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                        if closestDistance ~= -1 and closestDistance <= 3 then
                            TriggerServerEvent("KorioZ-PersonalMenu:Boss_promouvoirplayer", GetPlayerServerId(closestPlayer))
                        else
                            ESX.ShowNotification("Aucun joueur à proximité")
                        end
                    end
                })

                RageUI.Button("Rétrograder un employé", nil, {RightLabel = "→→→"}, true, {
                    onActive = function()
                        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                        if closestDistance ~= -1 and closestDistance <= 3 then
                            PlayerMakrer(closestPlayer)
                        end
                    end, 
                    onSelected = function()
                        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                        if closestDistance ~= -1 and closestDistance <= 3 then
                            TriggerServerEvent("KorioZ-PersonalMenu:Boss_destituerplayer", GetPlayerServerId(closestPlayer))
                        else
                            ESX.ShowNotification("Aucun joueur à proximité")
                        end
                    end
                })
            end
        end, function()
        end)


        RageUI.IsVisible(gestionjob2, function()

            if ESX.PlayerData.job2.grade_name == "boss" then 
                RageUI.Separator("[Organisation]")

                RageUI.Button("Recruter un employé", nil, {RightLabel = "→→→"}, true, {
                    onActive = function()
                        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                        if closestDistance ~= -1 and closestDistance <= 3 then
                            PlayerMakrer(closestPlayer)
                        end
                    end, 
                    onSelected = function()
                        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                        if closestDistance ~= -1 and closestDistance <= 3 then
                            TriggerServerEvent("KorioZ-PersonalMenu:Boss_recruterplayer2", GetPlayerServerId(closestPlayer), ESX.PlayerData.job2.name)
                        else
                            ESX.ShowNotification("Aucun joueur à proximité")
                        end
                    end
                })

                RageUI.Button("Virer un employé", nil, {RightLabel = "→→→"}, true, {
                    onActive = function()
                        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                        if closestDistance ~= -1 and closestDistance <= 3 then
                            PlayerMakrer(closestPlayer)
                        end
                    end, 
                    onSelected = function()
                        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                        if closestDistance ~= -1 and closestDistance <= 3 then
                            TriggerServerEvent("KorioZ-PersonalMenu:Boss_virerplayer2", GetPlayerServerId(closestPlayer))
                        else
                            ESX.ShowNotification("Aucun joueur à proximité")
                        end
                    end
                })

                RageUI.Button("Promouvroir un employé", nil, {RightLabel = "→→→"}, true, {
                    onActive = function()
                        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                        if closestDistance ~= -1 and closestDistance <= 3 then
                            PlayerMakrer(closestPlayer)
                        end
                    end, 
                    onSelected = function()
                        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                        if closestDistance ~= -1 and closestDistance <= 3 then
                            TriggerServerEvent("KorioZ-PersonalMenu:Boss_promouvoirplayer2", GetPlayerServerId(closestPlayer))
                        else
                            ESX.ShowNotification("Aucun joueur à proximité")
                        end
                    end
                })

                RageUI.Button("Rétrograder un employé", nil, {RightLabel = "→→→"}, true, {
                    onActive = function()
                        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                        if closestDistance ~= -1 and closestDistance <= 3 then
                            PlayerMakrer(closestPlayer)
                        end
                    end, 
                    onSelected = function()
                        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                        if closestDistance ~= -1 and closestDistance <= 3 then
                            TriggerServerEvent("KorioZ-PersonalMenu:Boss_destituerplayer2", GetPlayerServerId(closestPlayer))
                        else
                            ESX.ShowNotification("Aucun joueur à proximité")
                        end
                    end
                })
            end

        end, function()
        end)

        RageUI.IsVisible(actioninventory, function()

            RageUI.Separator("Nom : ~r~"..tostring(label).." ~s~/ Quantité : ~g~"..tostring(count).."")

            RageUI.Button("> Utilser", nil, {RightLabel = "→→→"}, not itemCooldown, {
                onSelected = function()
                    itemCooldown = true
                    typee = "use"
                    TriggerServerEvent('esx:useItem', name)
                    ExecuteCommand("me utilise x1 "..label)
                    count = count - 1
                    if count < 0 then 
                        RageUI.GoBack()
                    end
                    Citizen.SetTimeout(1500, function() itemCooldown = false end)
                end
            })

            RageUI.Button("> Donner", nil, {RightLabel = "→→→"}, not itemCooldown, {
                onActive = function()
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                    if closestDistance ~= -1 and closestDistance <= 3 then
                        PlayerMakrer(closestPlayer)
                    end
                end,
                onSelected = function()
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                    local check, quantity = CheckQuantity(KeyboardInput("", "Indiquer le nombre à donner", "", 20))
                    if check then 
                        local closestPed = GetPlayerPed(closestPlayer)
                        if tonumber(quantity) > tonumber(count) then 
                            ESX.ShowNotification('Vous n\'en n\'avez pas asser')
                        else
                            if not ESX.ContribItem(name) then 
                                itemCooldown = true
                                TriggerServerEvent('esx:giveInventoryItem', GetPlayerServerId(closestPlayer), 'item_standard', name, quantity)
                                ExecuteCommand("me donne un/une "..label.." à la personne")
                                RageUI.GoBack()
                                Citizen.SetTimeout(1500, function() itemCooldown = false end)
                            else
                                ESX.ShowNotification('~r~LystyLife ~w~~n~Vous ne pouvez pas donner cette objets')
                            end
                        end
                    else
                        ESX.ShowNotification('Arguments Manquants !')
                    end
                end
            })
            
        end , function()
        end)

        RageUI.IsVisible(actionweapon, function()
            RageUI.Separator("Nom : ~r~"..tostring(labelweapon).." ~s~/ Balles : ~g~"..tostring(ammooweapon).."")

          
            RageUI.Button("> Donner", nil, {RightLabel = "→→→"}, true, {
                onActive = function()
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                    if closestDistance ~= -1 and closestDistance <= 3 then
                        PlayerMakrer(closestPlayer)
                    end
                end,
                onSelected = function()
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

                    if closestDistance ~= -1 and closestDistance <= 3 then
                        local closestPed = GetPlayerPed(closestPlayer)
                        TriggerServerEvent("esx:giveInventoryItem", GetPlayerServerId(closestPlayer), "item_weapon", name, nil)
                        RageUI.CloseAll()
                    else
                        ESX.ShowNotification("Personne aux alentours")
                    end
                end
            })

        end, function()
        end)

        RageUI.IsVisible(infojob, function()
            ESX.PlayerData = ESX.GetPlayerData()
            
            RageUI.Button("Votre Métier: ", nil, {RightLabel = "~r~"..ESX.PlayerData.job.label}, true, {})
            RageUI.Button("Votre Grade: ", nil, {RightLabel = "~r~"..ESX.PlayerData.job.grade_label}, true, {})

        end, function()
        end)


        RageUI.IsVisible(infojob2, function()
            
            RageUI.Button("Votre Organisation: ", nil, {RightLabel = "~r~"..ESX.PlayerData.job2.label}, true, {})
            RageUI.Button("Votre Rang: ", nil, {RightLabel = "~r~"..ESX.PlayerData.job2.grade_label}, true, {})

            
        end, function()
        end)

        RageUI.IsVisible(billingmenu, function()
            if #BillData ~= 0 then
                for i = 1, #BillData, 1 do
                    RageUI.Button(BillData[i].label, nil, {RightLabel = '$' .. ESX.Math.GroupDigits(BillData[i].amount)}, true, {
                        onSelected = function()
                        ESX.TriggerServerCallback('esx_billing:payBill', function()
                            RageUI.GoBack()
                        end, BillData[i].id)
                    end})
                end
            else
                RageUI.Separator('~r~')
                RageUI.Separator('~r~Vous n\'avez pas de facture')
                RageUI.Separator('~r~')
            end
        end, function()
        end)
        
        RageUI.IsVisible(gestionlicense, function()

            RageUI.Separator("~r~↓ Carte D'identité ↓")
            
            RageUI.Button("> Montrer sa carte d'identité", nil, {RightLabel = '→→→'}, true, {
                onActive = function()
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                    if closestDistance ~= -1 and closestDistance <= 3 then
                        PlayerMakrer(closestPlayer)
                    end
                end,
                onSelected = function()
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                    if closestDistance ~= -1 and closestDistance <= 3.0 then
                        TriggerServerEvent("jsfour-idcard:open", GetPlayerServerId(PlayerId()), GetPlayerServerId(closestPlayer))
                    else
                        ESX.ShowNotification("Aucun joueurs aux alentours")
                    end
                end
            })

            RageUI.Button("> Regarder sa carte d'identité", nil, {RightLabel = "→→→"}, true, {
                onSelected = function()
                    TriggerServerEvent("jsfour-idcard:open", GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()))
                end
            })

            RageUI.Separator("~r~↓ Permis de conduire ↓")

            RageUI.Button("> Montrer son permis de conduire", nil, {RightLabel = '→→→'}, true, {
                onActive = function()
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                    if closestDistance ~= -1 and closestDistance <= 3 then
                        PlayerMakrer(closestPlayer)
                    end
                end,
                onSelected = function()
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                    if closestDistance ~= -1 and closestDistance <= 3.0 then
                        TriggerServerEvent("jsfour-idcard:open", GetPlayerServerId(PlayerId()), GetPlayerServerId(closestPlayer), "driver")
                    else
                        ESX.ShowNotification("Aucun joueurs aux alentours")
                    end
                end
            })

            RageUI.Button("> Regarder son permis de conduire", nil, {RightLabel = "→→→"}, true, {
                onSelected = function()
                    TriggerServerEvent("jsfour-idcard:open", GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), "driver")
                end
            })

            RageUI.Separator("~r~↓ Permis de port d'armes ↓")

            RageUI.Button("> Montrer son permis de port d'armes", nil, {RightLabel = '→→→'}, true, {
                onActive = function()
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                    if closestDistance ~= -1 and closestDistance <= 3 then
                        PlayerMakrer(closestPlayer)
                    end
                end,
                onSelected = function()
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                    if closestDistance ~= -1 and closestDistance <= 3.0 then
                        TriggerServerEvent("jsfour-idcard:open", GetPlayerServerId(PlayerId()), GetPlayerServerId(closestPlayer), "weapon")
                    else
                        ESX.ShowNotification("Aucun joueurs aux alentours")
                    end
                end
            })

            RageUI.Button("> Regarder son permis de port d'armes", nil, {RightLabel = "→→→"}, true, {
                onSelected = function()
                    TriggerServerEvent("jsfour-idcard:open", GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), "weapon")
                end
            })
        
        end, function()
        end)
        if not RageUI.Visible(mainf5) and 
        not RageUI.Visible(invetory) and 
        not RageUI.Visible(portefeuille) and 
        not RageUI.Visible(vetmenu) and 
        not RageUI.Visible(vehicle) and
        not RageUI.Visible(radio) and
        not RageUI.Visible(diversmenu) and 

        not RageUI.Visible(actioninventory) and 
        not RageUI.Visible(infojob) and 
        not RageUI.Visible(infojob2) and 
        not RageUI.Visible(gestionjob) and
        not RageUI.Visible(gestionjob2) and 
        not RageUI.Visible(billingmenu) and 

        not RageUI.Visible(weapons) and
        not RageUI.Visible(gestionaccesories) and
        not RageUI.Visible(actionweapon) and 
        not RageUI.Visible(gestionlicense) then 
            mainf5 = RMenu:DeleteType("mainf5")
        end
    end
end


Keys.Register("F5", "Menu_Interacion", "Menu F5", function()
    if not PlayerIsDead then 
        openMenuF5()
    end
end)

Citizen.CreateThread(function()
    while true do 
        Wait(5000)
        TriggerEvent("skinchanger:getSkin", function(skin)
            if skin.bags_1 == 0 then
                if ESX.PlayerData.maxWeight ~= 40 then 
                    TriggerServerEvent('ewen:ChangeWeightInventory', 40)
                end
            else
                if ESX.PlayerData.maxWeight ~= 60 then 
                    TriggerServerEvent('ewen:ChangeWeightInventory', 60)
                end
            end
        end)
        if GetCurrentWeight() > ESX.PlayerData.maxWeight then
            DrawMissionText('~r~Vous êtes trop lourd, Vous ne pouver plus courrir', 5000)
            DisableControlAction(0, 22, true)
            DisableControlAction(0, 21, true)
        end
    end
end)

local NoCourir = false
Citizen.CreateThread(function()
    while true do 
        Wait(5000)
        TriggerEvent("skinchanger:getSkin", function(skin)
            if skin.bags_1 == 0 then
                if ESX.PlayerData.maxWeight ~= 40 then 
                    TriggerServerEvent('ewen:ChangeWeightInventory', 40)
                end
            else
                if ESX.PlayerData.maxWeight ~= 60 then 
                    TriggerServerEvent('ewen:ChangeWeightInventory', 60)
                end
            end
        end)
        if GetCurrentWeight() > ESX.PlayerData.maxWeight then
            DrawMissionText('~r~Vous êtes trop lourd, Vous ne pouver plus courrir', 5000)
            NoCourir = true
        else 
            NoCourir = false
        end
    end
end)

Citizen.CreateThread(function()
	while true do
		if NoCourir then
			Citizen.Wait(10)
		else
			Wait(5000)
		end

		if NoCourir then
			DisableControlAction(0, 21, true) -- INPUT_SPRINT
			DisableControlAction(0, 22, true) -- INPUT_JUMP
			DisableControlAction(0, 24, true) -- INPUT_ATTACK
			DisableControlAction(0, 44, true) -- INPUT_COVER
			DisableControlAction(0, 45, true) -- INPUT_RELOAD
			DisableControlAction(0, 140, true) -- INPUT_MELEE_ATTACK_LIGHT
			DisableControlAction(0, 141, true) -- INPUT_MELEE_ATTACK_HEAVY
			DisableControlAction(0, 142, true) -- INPUT_MELEE_ATTACK_ALTERNATE
			DisableControlAction(0, 143, true) -- INPUT_MELEE_BLOCK
			DisableControlAction(0, 144, true) -- PARACHUTE DEPLOY
			DisableControlAction(0, 145, true) -- PARACHUTE DETACH
			DisableControlAction(0, 243, true) -- INPUT_ENTER_CHEAT_CODE
			DisableControlAction(0, 257, true) -- INPUT_ATTACK2
			DisableControlAction(0, 263, true) -- INPUT_MELEE_ATTACK1
			DisableControlAction(0, 264, true) -- INPUT_MELEE_ATTACK2
			DisableControlAction(0, 73, true) -- INPUT_X
		end
	end
end)