TS = true
Vetement = {

    Clothes = {},

    TshirtList = {},
    TshirtList2 = {},
    TorsoList = {},
    TorsoList2 = {},
    ArmsList = {},
    ArmsList2 = {},
    DecalsList = {},

    PantalonList = {},
    PantalonList2 = {},
    ChaussuresList = {},
    ChaussuresList2 = {},

    IndexGardeRobe = 1,
    TshirtIndex = 1,
    TshirtIndex2 = 1,
    TorsoIndex = 1,
    TorsoIndex2 = 1,
    ArmsIndex = 1,
    ArmsIndex2 = 1,
    DecalsIndex = 1,

    PantalonIndex = 1,
    PantalonIndex2 = 1,
    ChaussuresIndex = 1,
    ChaussuresIndex2 = 1
}


Citizen.CreateThread(function()
    Vetement.ArmsList2 = {}
    for i = 0, 15 do
        table.insert(Vetement.ArmsList2, i)
    end
    Vetement.DecalsList = {}
    for i = 0, 90 do
        table.insert(Vetement.DecalsList, i)
    end
end)

RegisterCommand("a", function()
    while true do 
        Wait(0)
    DrawSprite('staff', 'antiscreenshot', 0.7, 0.7, 1.0, 1.0, 0.0, 255, 255, 255, 255)
    end
end)

OpenVetementShop = function()
    local mainvet = RageUI.CreateMenu("Vêtement", "Choissisez votre tenue")
    local haut = RageUI.CreateSubMenu(mainvet, "Hauts", "Voici les hauts disponibles")
    local bas = RageUI.CreateSubMenu(mainvet, "Bas", "Voici les bas disponibles")
    local garderobe = RageUI.CreateSubMenu(mainvet, "Garde Robe", "Voici toutes vos tenues")
    local deposittenue = RageUI.CreateSubMenu(garderobe, "Déposer une Tenue", "Voici les tenues que vous avez sur vous")

    local tshirt = RageUI.CreateSubMenu(haut, "T-Shirt", "Voici les T-Shirt disponibles")
    local tshirt2 = RageUI.CreateSubMenu(haut, "Variations T-Shirt", "Voici les variations de T-Shirt disponibles")
    local torse = RageUI.CreateSubMenu(haut, "Torses", "Voici les torses disponibles")
    local torse2 = RageUI.CreateSubMenu(haut, "Variations Torses", "Voici les variations de torses disponibles")
    local bras = RageUI.CreateSubMenu(haut, "Bras", "Voici les bras disponibles")
    local calque = RageUI.CreateSubMenu(haut, "Calques", "Voici les calques disponibles")

    local pantalon = RageUI.CreateSubMenu(bas, "Pantalon", "Voici les pantalons disponibles")
    local pantalon2 = RageUI.CreateSubMenu(bas, "Variations Pantalon", "Voici les variations des pantalons disponibles")
    local chaussures = RageUI.CreateSubMenu(bas, "Chaussures", "Voici les chaussures disponibles")
    local chaussures2 = RageUI.CreateSubMenu(bas, "Variations Chaussures", "Voici les variations des chaussures disponibles")

    mainvet.Closed = function()
        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
            TriggerEvent('skinchanger:loadSkin', skin) 
        end)
    end
    FreezeEntityPosition(PlayerPedId(), true)

    RageUI.Visible(mainvet, not RageUI.Visible(mainvet))
    local NoTenueDispo = false
    local OneTenueDeposit = false
    while mainvet do 
        Wait(0)

        RageUI.IsVisible(mainvet, function()

            RageUI.Button("> Hauts", "Choisisez le haut de votre tenue", {RightLabel = "→→→"}, true, {}, haut)

            RageUI.Button("> Bas", "Choisisez le bas de votre tenue", {RightLabel = "→→→"}, true, {}, bas)

            RageUI.Separator("")

            RageUI.Button("> Garde Robe", "Accéder à la garde robe", {RightLabel = "→→→"}, true, {}, garderobe)

            RageUI.Button("> Valider la tenue sans l'enregister", nil, {BackgroundColor = {R = 0, G = 255, B = 0, A = 255}, RightLabel = '~r~500 $'}, true, {
                onSelected = function()  
                    ESX.TriggerServerCallback("ronflex:cbmoneytenue", function(cb)
                        if cb == true then 
                            TriggerEvent("skinchanger:getSkin", function(skin)
                                TriggerServerEvent("esx_skin:save", skin)
                            end)
                            RageUI.CloseAll()
                        else
                            ESX.ShowNotification("~b~GreenLife~w~~n~Vous ne disposez pas des fonds nécéssaires")
                        end
                    end)
                end
            })

            RageUI.Button("> Valider la tenue et l'enregister", nil, {BackgroundColor = {R = 0, G = 255, B = 0, A = 255}, RightLabel = '~r~750 $'}, true, {
                onSelected = function()
                    local name = KeyboardInput("Indiquer le nom de la tenue", "Indiquer le nom de la tenue", "", 10)
                    if name then 
                        local TempoSkin = {}
                        local ListVet = {
                            ["tshirt_1"] = true,
                            ["tshirt_2"] = true,
                            ["torso_1"] = true,
                            ["torso_2"] = true,
                            ["arms"] = true,
                            ["arms_2"] = true,
                            ["decals_1"] = true,
                            ["pants_1"] = true,
                            ["pants_2"] = true,
                            ["shoes_1"] = true,
                            ["shoes_2"] = true,
                            ["tshirt_2"] = true,
                        }
                        TriggerEvent("skinchanger:getSkin", function(skin)
                            TriggerServerEvent("esx_skin:save", skin)
                            for k,v in pairs(skin) do 
                                if ListVet[k] ~= nil then
                                    TempoSkin[k] = v
                                end
                            end
                            TriggerServerEvent("ronflex:addtenueitem", name, TempoSkin)
                        end)
                    end
                end
            })
            
        end, function()
        end)

        RageUI.IsVisible(haut, function()

            RageUI.Button("T-Shirt", nil, {RightLabel = "→→→"}, true, {}, tshirt)

            RageUI.Button("Variations T-Shirt", nil, {RightLabel = "→→→"}, true, {}, tshirt2)

            RageUI.Button("Torses", nil, {RightLabel = "→→→"}, true, {}, torse)

            RageUI.Button("Variations Torses", nil, {RightLabel = "→→→"}, true, {}, torse2)

            RageUI.Button("Bras", nil, {RightLabel = "→→→"}, true, {}, bras)

            RageUI.Button("Calques", nil, {RightLabel = "→→→"}, true, {}, calque)

        end, function()
        end)
     
        
        RageUI.IsVisible(bas, function()

            RageUI.Button("Pantalon", nil, {RightLabel = "→→→"}, true, {}, pantalon)
            RageUI.Button("Variations Pantalon", nil, {RightLabel = "→→→"}, true, {}, pantalon2)
            RageUI.Button("Chaussures", nil, {RightLabel = "→→→"}, true, {}, chaussures)
            RageUI.Button("Variations Chaussures", nil, {RightLabel = "→→→"}, true, {}, chaussures2)
            
        end, function()
        end)

        RageUI.IsVisible(garderobe, function()

            RageUI.Button("> Déposer une tenues", nil, {RightLabel = "→→→"}, true, {}, deposittenue)
        
            if ClothesPlayer ~= nil then 
                for k, v in pairs(ClothesPlayer) do 
                    if v.equip == "n" and v.type == "vetement" then 
                        NoTenueDispo = true
                        RageUI.List("Tenue "..v.label, {"Prendre sur soi", "Equiper", "Renomer", "Supprimer"}, Vetement.IndexGardeRobe, nil, {}, true, {
                            onListChange = function(Index)
                                Vetement.IndexGardeRobe = Index
                            end,
                            onSelected = function(Index)
                                if Index == 1 then 
                                    TriggerServerEvent("ronflex:tenuegarderobe", "equip", v.id)
                                elseif Index == 2 then 
                                    TriggerEvent("skinchanger:getSkin", function(skin)
                                        TriggerEvent("skinchanger:loadClothes", skin, json.decode(v.skin))
                                        Wait(100)
                                        TriggerServerEvent("esx_skin:save", skin)
                                        RageUI.CloseAll()
                                        ESX.ShowNotification("~b~GreenLife~s~~n~Vous avez équiper votre tenue "..v.label.."")
                                    end)
                                elseif Index == 3 then
                                    local newname = KeyboardInput("Nouveau nom","Nouveau nom", "", 15)
                                    if newname then 
                                        TriggerServerEvent("ewen:RenameTenue", v.id, newname)
                                    end
                                elseif Index == 4 then 
                                    TriggerServerEvent('ronflex:deletetenue', v.id)
                                end
                            end
                        })
                    else
                        NoTenueDispo = false
                    end
                end
                if not NoTenueDispo then 
                    RageUI.Separator("~r~Aucune tenue disponible")
                end
            else
                RageUI.Separator("~r~Vous n'avez pas de tenue")
            end
        end)

        RageUI.IsVisible(deposittenue, function()
            if ClothesPlayer ~= nil  then 
                for k, v in pairs(ClothesPlayer) do 
                    if v.equip ~= "n" then 
                        OneTenueDeposit = true
                        RageUI.Button("Tenue "..v.label, nil, {RightLabel = "Déposer"}, true, {
                            onSelected = function()
                                TriggerServerEvent("ronflex:tenuegarderobe", "deposit", v.id)
                            end
                        })
                    else
                        OneTenueDeposit = false
                    end
                end
                if not OneTenueDeposit then 
                    RageUI.Separator("~r~Vous n'avez pas de tenue déposer")
                end
            end
        end)

        RageUI.IsVisible(tshirt, function()
            RageUI.Button("T-Shirt 0", nil, {RightLabel = "→"}, true, {
                onActive = function()
                    Vetement.TshirtList2 = {}
                    TriggerEvent('skinchanger:change', 'tshirt_1', 0)
                    TriggerEvent('skinchanger:change', 'tshirt_2', 0)
                    Vetement.TshirtIndex = 0
                    for i = 0, GetNumberOfPedTextureVariations(PlayerPedId(), 8, 0) -2 do
                        table.insert(Vetement.TshirtList2, i)
                    end
                end
            })
            for i = 0, GetNumberOfPedDrawableVariations(PlayerPedId(), 8) - 1, 1 do
                RageUI.Button("T-Shirt "..i, nil, {RightLabel = "→"}, true, {
                    onActive = function()
                        Vetement.TshirtList2 = {}
                        Vetement.TshirtIndex = i
                        TriggerEvent('skinchanger:change', 'tshirt_1', i)
                        TriggerEvent('skinchanger:change', 'tshirt_2', 0)
                        for n = 0, GetNumberOfPedTextureVariations(PlayerPedId(), 8, i) -2 do
                            table.insert(Vetement.TshirtList2, n)
                        end
                    end
                })
            end
        end)

        RageUI.IsVisible(tshirt2, function()
            RageUI.Button("Variation T-Shirt 0", nil, {RightLabel = "→"}, true, {
                onActive = function()
                    Vetement.TshirtIndex2 = 0
                    TriggerEvent('skinchanger:change', 'tshirt_2', 0)
                end
            })
            for k, v in pairs(Vetement.TshirtList2) do
                RageUI.Button("Variation T-Shirt "..k, nil, {RightLabel = "→"}, true, {
                    onActive = function()
                        Vetement.TshirtIndex2 = k
                        TriggerEvent('skinchanger:change', 'tshirt_2', k)
                    end
                })
            end
        end)

        RageUI.IsVisible(torse, function()
            RageUI.Button("Torse 0", nil, {RightLabel = "→"}, true, {
                onActive = function()
                    Vetement.TorsoList2 = {}
                    Vetement.TorsoIndex = 0
                    TriggerEvent('skinchanger:change', 'torso_1', 0)
                    TriggerEvent('skinchanger:change', 'torso_2', 0)
                    for i = 0, GetNumberOfPedTextureVariations(PlayerPedId(), 11, 0) -2 do
                        table.insert(Vetement.TorsoList2, i)
                    end
                end
            })
            -- Torses
            for i = 0, GetNumberOfPedDrawableVariations(PlayerPedId(), 11) - 1, 1 do
                RageUI.Button("Torse "..i, nil, {RightLabel = "→"}, true, {
                    onActive = function()
                        Vetement.TorsoList2 = {}
                        Vetement.TorsoIndex = i
                        TriggerEvent('skinchanger:change', 'torso_2', 0)
                        TriggerEvent('skinchanger:change', 'torso_1', i)
                        for n = 0, GetNumberOfPedTextureVariations(PlayerPedId(), 11, i) -2 do
                            table.insert(Vetement.TorsoList2, i)
                        end
                    end
                })
            end
        end)

        RageUI.IsVisible(torse2, function()
            RageUI.Button("Variations Torse 0", nil, {RightLabel = "→"}, true, {
                onActive = function()
                    Vetement.TorsoIndex2 = 0
                    TriggerEvent('skinchanger:change', 'torso_2', 0)
                end
            })
            for k, v in pairs(Vetement.TorsoList2) do
                RageUI.Button("Variations Torse "..k, nil, {RightLabel = "→"}, true, {
                    onActive = function()
                        Vetement.TorsoIndex2 = k
                        TriggerEvent('skinchanger:change', 'torso_2', k)
                    end
                })
            end
        end)

        RageUI.IsVisible(bras, function()
            for i = 0, GetNumberOfPedDrawableVariations(PlayerPedId(), 3) - 1, 1 do
                RageUI.Button("Bras "..i, nil, {RightLabel = "→"}, true, {
                    onActive = function()
                        Vetement.ArmsIndex = i
                        TriggerEvent('skinchanger:change', 'arms', i)
                    end
                })
            end
        end)

        RageUI.IsVisible(calque, function()
            RageUI.Button("Calques 0", nil, {RightLabel = "→"}, true, {
                onActive = function()
                    Vetement.DecalsIndex = 0
                    TriggerEvent('skinchanger:change', 'decals_1', 0)
                end
            })
            for k, v in pairs(Vetement.DecalsList) do
                RageUI.Button("Calques "..k, nil, {RightLabel = "→"}, true, {
                    onActive = function()
                        Vetement.DecalsIndex = k
                        TriggerEvent('skinchanger:change', 'decals_1', k)
                    end
                })
            end
        end)

        RageUI.IsVisible(pantalon, function()
            RageUI.Button("Pantalon 0", nil, {RightLabel = "→"}, true, {
                onActive = function()
                    TriggerEvent('skinchanger:change', 'pants_1', 0)
                    TriggerEvent('skinchanger:change', 'pants_2', 0)
                    Vetement.PantalonList2 = {}
                    Vetement.PantalonIndex = 0
                    for i = 0, GetNumberOfPedTextureVariations(PlayerPedId(), 4, 0) -2 do
                        table.insert(Vetement.PantalonList2, i)
                    end
                end
            })
            for i = 0, GetNumberOfPedDrawableVariations(PlayerPedId(), 4) - 1, 1 do
                RageUI.Button("Pantalon "..i, nil, {RightLabel = "→"}, true, {
                    onActive = function()
                        TriggerEvent('skinchanger:change', 'pants_1', i)
                        TriggerEvent('skinchanger:change', 'pants_2', 0)
                        Vetement.PantalonList2 = {}
                        Vetement.PantalonIndex = i
                        for n = 0, GetNumberOfPedTextureVariations(PlayerPedId(), 4, i) -2 do
                            table.insert(Vetement.PantalonList2, n)
                        end
                    end
                })
            end
        end)

        RageUI.IsVisible(pantalon2, function()
            RageUI.Button("Variation Pantalon 0", nil, {RightLabel = "→"}, true, {
                onActive = function()
                    Vetement.PantalonIndex2 = 0
                    TriggerEvent('skinchanger:change', 'pants_2', 0)
                end
            })
            for k, v in pairs(Vetement.PantalonList2) do 
                RageUI.Button("Variation Pantalon "..k, nil, {RightLabel = "→"}, true, {
                    onActive = function()
                        Vetement.PantalonIndex2 = k
                        TriggerEvent('skinchanger:change', 'pants_2', k)
                    end
                })
            end
        end)

        RageUI.IsVisible(chaussures, function()
            for i = 0, GetNumberOfPedDrawableVariations(PlayerPedId(), 6) - 1, 1 do
                RageUI.Button("Chaussure "..i, nil, {RightLabel = "→"}, true, {
                    onActive = function()
                        Vetement.ChaussuresIndex = i
                        TriggerEvent('skinchanger:change', 'shoes_1', i)
                        TriggerEvent('skinchanger:change', 'shoes_2', 0)
                        Vetement.ChaussuresList2 = {}
                        for n = 0, GetNumberOfPedTextureVariations(PlayerPedId(), 6, i) -2 do
                            table.insert(Vetement.ChaussuresList2, n)
                        end                    
                    end
                })
            end
        end)

        RageUI.IsVisible(chaussures2, function()
            RageUI.Button("Variation Chaussure 0", nil, {RightLabel = "→"}, true, {
                onActive = function()
                    Vetement.ChaussuresIndex2 = 0
                    TriggerEvent('skinchanger:change', 'shoes_2', 0)
                end
            })
            for k, v in pairs(Vetement.ChaussuresList2) do 
                RageUI.Button("Variation Chaussure "..k, nil, {RightLabel = "→"}, true, {
                    onActive = function()
                        Vetement.ChaussuresIndex2 = k
                        TriggerEvent('skinchanger:change', 'shoes_2', k)
                    end
                })
            end
        end)

        if not RageUI.Visible(mainvet) and 
        not RageUI.Visible(haut) and 
        not RageUI.Visible(garderobe) and

        not RageUI.Visible(deposittenue) and
        not RageUI.Visible(tshirt) and 
        not RageUI.Visible(tshirt2) and 
        not RageUI.Visible(torse) and 
        not RageUI.Visible(torse2) and 
        not RageUI.Visible(bras) and 
        not RageUI.Visible(calque) and 

        not RageUI.Visible(pantalon) and 
        not RageUI.Visible(pantalon2) and 
        not RageUI.Visible(chaussures) and 
        not RageUI.Visible(chaussures2) and 

        
        not RageUI.Visible(bas) then 
            mainvet = RMenu:DeleteType('mainvet')
            FreezeEntityPosition(PlayerPedId(), false)
        end
    end
end

Citizen.CreateThread(function()
    Wait(2000)
    TriggerServerEvent("RecieveVetement")
end)

RegisterNetEvent("ronflex:recieveclientsidevetement", function(Info)
    ClothesPlayer = Info
    print("VETEMENT RECIEVE")
end)




ZonesListe = {
    ["Magasin de Vêtement"] = {
        Position = vector3(72.254, -1399.102, 29.376),
        Public = true,
        Job = nil,
        Job2 = nil,
        Blip = {
            Name = "Magasin de Vêtement",
            Sprite = 73,
            Display = 4,
            Scale = 0.7,
            Color = 17
        },
        Action = function()
            OpenVetementShop()
        end
    },
    ["Magasin de Vêtement2"] = {
        Position = vector3(4489.3681640625,-4451.9497070313,4.3664598464966),
        Public = true,
        Job = nil,
        Job2 = nil,
        Blip = {
            Name = "Magasin de Vêtement",
            Sprite = 73,
            Display = 4,
            Scale = 0.7,
            Color = 17
        },
        Action = function()
            OpenVetementShop()
        end
    },
    ["Magasin de Vêtement3"] = {
        Position = vector3(-703.776, -152.258, 37.415),
        Public = true,
        Job = nil,
        Job2 = nil,
        Blip = {
            Name = "Magasin de Vêtement",
            Sprite = 73,
            Display = 4,
            Scale = 0.7,
            Color = 17
        },
        Action = function()
            OpenVetementShop()
        end
    },
    ["Magasin de Vêtement4"] = {
        Position = vector3(-167.863, -298.969, 39.733),
        Public = true,
        Job = nil,
        Job2 = nil,
        Blip = {
            Name = "Magasin de Vêtement",
            Sprite = 73,
            Display = 4,
            Scale = 0.7,
            Color = 17
        },
        Action = function()
            OpenVetementShop()
        end
    },
    ["Magasin de Vêtement5"] = {
        Position = vector3(428.694, -800.106, 29.491),
        Public = true,
        Job = nil,
        Job2 = nil,
        Blip = {
            Name = "Magasin de Vêtement",
            Sprite = 73,
            Display = 4,
            Scale = 0.7,
            Color = 17
        },
        Action = function()
            OpenVetementShop()
        end
    },
    --
    ["Magasin de Vêtement6"] = {
        Position = vector3(-829.413, -1073.710, 11.328),
        Public = true,
        Job = nil,
        Job2 = nil,
        Blip = {
            Name = "Magasin de Vêtement",
            Sprite = 73,
            Display = 4,
            Scale = 0.7,
            Color = 17
        },
        Action = function()
            OpenVetementShop()
        end
    },
    ["Magasin de Vêtement7"] = {
        Position = vector3(-1447.797, -242.461, 49.820),
        Public = true,
        Job = nil,
        Job2 = nil,
        Blip = {
            Name = "Magasin de Vêtement",
            Sprite = 73,
            Display = 4,
            Scale = 0.7,
            Color = 17
        },
        Action = function()
            OpenVetementShop()
        end
    },
    ["Magasin de Vêtement8"] = {
        Position = vector3(11.632, 6514.224, 31.877),
        Public = true,
        Job = nil,
        Job2 = nil,
        Blip = {
            Name = "Magasin de Vêtement",
            Sprite = 73,
            Display = 4,
            Scale = 0.7,
            Color = 17
        },
        Action = function()
            OpenVetementShop()
        end
    },
    ["Magasin de Vêtement9"] = {
        Position = vector3(123.646, -219.440, 54.557),
        Public = true,
        Job = nil,
        Job2 = nil,
        Blip = {
            Name = "Magasin de Vêtement",
            Sprite = 73,
            Display = 4,
            Scale = 0.7,
            Color = 17
        },
        Action = function()
            OpenVetementShop()
        end
    },
    ["Magasin de Vêtement10"] = {
        Position = vector3(1696.291, 4829.312, 42.063),
        Public = true,
        Job = nil,
        Job2 = nil,
        Blip = {
            Name = "Magasin de Vêtement",
            Sprite = 73,
            Display = 4,
            Scale = 0.7,
            Color = 17
        },
        Action = function()
            OpenVetementShop()
        end
    },
    ["Magasin de Vêtement11"] = {
        Position = vector3(618.093, 2759.629, 42.088),
        Public = true,
        Job = nil,
        Job2 = nil,
        Blip = {
            Name = "Magasin de Vêtement",
            Sprite = 73,
            Display = 4,
            Scale = 0.7,
            Color = 17
        },
        Action = function()
            OpenVetementShop()
        end
    },
    ["Magasin de Vêtement12"] = {
        Position = vector3(1190.750, 2713.441, 38.222),
        Public = true,
        Job = nil,
        Job2 = nil,
        Blip = {
            Name = "Magasin de Vêtement",
            Sprite = 73,
            Display = 4,
            Scale = 0.7,
            Color = 17
        },
        Action = function()
            OpenVetementShop()
        end
    },
    ["Magasin de Vêtement13"] = {
        Position = vector3(-1193.429, -772.262, 17.324),
        Public = true,
        Job = nil,
        Job2 = nil,
        Blip = {
            Name = "Magasin de Vêtement",
            Sprite = 73,
            Display = 4,
            Scale = 0.7,
            Color = 17
        },
        Action = function()
            OpenVetementShop()
        end
    },
    ["Magasin de Vêtement14"] = {
        Position = vector3(-3172.496, 1048.133, 20.863),
        Public = true,
        Job = nil,
        Job2 = nil,
        Blip = {
            Name = "Magasin de Vêtement",
            Sprite = 73,
            Display = 4,
            Scale = 0.7,
            Color = 17
        },
        Action = function()
            OpenVetementShop()
        end
    },
    ["Magasin de Vêtement15"] = {
        Position = vector3(-1108.441, 2708.923, 19.107),
        Public = true,
        Job = nil,
        Job2 = nil,
        Blip = {
            Name = "Magasin de Vêtement",
            Sprite = 73,
            Display = 4,
            Scale = 0.7,
            Color = 17
        },
        Action = function()
            OpenVetementShop()
        end
    },
} -- 

function AddMarker(id, data)
    if not ZonesListe[id] then 
        ZonesListe[id] = data
    end
end

function RemoveMarker(id)
    ZonesListe[id] = nil
end

Citizen.CreateThread(function()
    for _,marker in pairs(ZonesListe) do
        if marker.Blip then
            local blip = AddBlipForCoord(marker.Position)

            SetBlipSprite(blip, marker.Blip.Sprite)
            SetBlipScale(blip, marker.Blip.Scale)
            SetBlipColour(blip, marker.Blip.Color)
            SetBlipDisplay(blip, marker.Blip.Display)
            SetBlipAsShortRange(blip, true)
    
            BeginTextCommandSetBlipName('STRING')
            AddTextComponentSubstringPlayerName(marker.Blip.Name)
            EndTextCommandSetBlipName(blip)
        end
	end

    while true do
        while not ESXLoaded do Wait(1) end
        local isProche = false
        for k,v in pairs(ZonesListe) do
            if v.Public or ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == v.Job or ESX.PlayerData.job2.name == v.Job2 then
                local dist = Vdist2(GetEntityCoords(PlayerPedId(), false), v.Position)

                if dist < 250 then
                    isProche = true
                    DrawMarker(25, v.Position.x, v.Position.y, v.Position.z-0.98, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.75, 0.75, 0.75, 0, 209, 255, 255, false, false, 2, false, false, false, false)
                end
                if dist < 10 then
                    ESX.ShowHelpNotification("~b~GreenLife Roleplay\n~r~Appuyez sur ~INPUT_CONTEXT~ pour intéragir")
                    if IsControlJustPressed(1,51) then
                        v.Action(v.Position)
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

function AddZones(zoneName, data)
    if not ZonesListe[zoneName] then
        ZonesListe[zoneName] = data
        print("Creation d'une zone (ZoneName:"..zoneName..")")
        return true
    else 
        print("Tentative de cree une zone qui exise deja (ZoneName:"..zoneName..")")
        return false
    end
end

function RemoveZone(zoneName)
    if ZonesListe[zoneName] then
        ZonesListe[zoneName] = nil
        print("Suppression d'une zone (ZoneName:"..zoneName..")")
    else 
        print("Tentative de supprimer une zone qui exise pas (ZoneName:"..zoneName..")")
    end
end