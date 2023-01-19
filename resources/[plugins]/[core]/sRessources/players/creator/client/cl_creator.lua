
Identity = {}
Creator = {
    Indexsexe = 1,
    Motherindex = 1,
    DadIndex = 1,
    PeauCoulour = 5,
    PeauCoulour2 = 0.5;
    Ressemblance = 5,
    Ressemblance2 = 0.5,

    Hairindex = 1,
    Beardindex = 1,
    Indexeyebow = 1,
    EyexIndex = 1,
    NoseoneIndex = 1,

    Hairlist = {},
    BeardList = {},
    EyebowList = {},
    EyesColorList = {},
    NosoneList = {},

    ColorHair = {
        primary = {1, 1},
        secondary = {1, 1},
    },

    ColorBeard = {
        primary = {1, 1},
        secondary = {1, 1},
    },

    ColorEyebow = {
        primary = {1, 1},
        secondary = {1, 1},
    },

    OpaPercent = 0,
    OpePercentEyebow = 0,
    PercentLargenose = 0,
    PercentHauteurnose = 0,
    PercentCrochuNose = 0,
    PercentJoueHauteur = 0,
    PercentJoueCreux = 0,
    PercentJoueCreuxx = 0,
    PercentMacoire1 = 0,
    PercentMacoire2 = 0,
    PercentMentonHauteur = 0,
    PercentMentonLargeur = 0,
    DadList = {"Benjamin", "Daniel", "Joshua", "Noah", "Andrew", "Juan", "Alex", "Isaac", "Evan", "Ethan", "Vincent", "Angel", "Diego", "Adrian", "Gabriel", "Michael", "Santiago", "Kevin", "Louis", "Samuel", "Anthony", "Pierre", "Niko"},
    MotherList = {"Adelyn", "Emily", "Abigail", "Beverly", "Kristen", "Hailey", "June", "Daisy", "Elizabeth", "Addison", "Ava", "Cameron", "Samantha", "Madison", "Amber", "Heather", "Hillary", "Courtney", "Ashley", "Alyssa", "Mia", "Brittany"},
}


Citizen.CreateThread(function()
    for i = 1, 73 do
        table.insert(Creator.Hairlist, i)
    end
    for i = 1, 74 do 
        table.insert(Creator.BeardList, i)
    end
    for i = 1, 73 do 
        table.insert(Creator.EyebowList, i)
    end
    for i = 1, 31 do
        table.insert(Creator.EyesColorList, i)
    end
end)

local introcam = nil
local sexcam = nil
local facecam = nil
local pilocam = nil
local tenuecam = nil 

RegisterCommand("register", function()
    TriggerEvent("ronflex:creator")
end)



RegisterNetEvent("ronflex:creator")
AddEventHandler("ronflex:creator", function(player)

    DisplayRadar(false)
    SetPlayerControl(PlayerId(), false, 12)
    SetEntityCoords(PlayerPedId(), -785.44970703125,343.31680297852,216.85179138184)
    SetEntityHeading(PlayerPedId(), 185.0)
    Wait(1000)
    TriggerServerEvent("ronflex:bucket", true)
    sexcam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 0)
    SetCamCoord(sexcam, -785.37609863281,340.000,217.850)
    SetCamActive(sexcam, true)
    RenderScriptCams(true, true, 2000, true, false)
    PointCamAtEntity(sexcam, PlayerPedId())
    SetCamParams(sexcam, -785.37609863281,340.000,217.850, 4.0, 0.0, 0.215, 42.2442, 0, 1, 1, 2)

    local main = RageUI.CreateMenu("Choix du sexe", "Choix de votre sexe")
    local apparence = RageUI.CreateSubMenu(main, "Apparence", "Voici ce qui est disponibles")
    local pillosite = RageUI.CreateSubMenu(apparence, "Pillosité", "Choissisez votre pillosité")
    local tenue = RageUI.CreateSubMenu(pillosite, "Tenus", "Veuillez choisir votre tenues")
    apparence.EnableMouse = true 
    pillosite.EnableMouse = true 
    main.Closable = false

    RageUI.Visible(main, not RageUI.Visible(main))

    while main do
        Wait(0)

        RageUI.IsVisible(main, function()

            RageUI.Button('→ Prénom', nil, {RightLabel = prenom}, true, {
                onSelected = function() 
                    local string = KeyboardInput('Exemple : Mike', ('Exemple : Mike'), '', 999)
					if string ~= "" then
						prenom = string 
					end
                end
            })
            RageUI.Button('→ Nom', nil, {RightLabel = lastname}, true, {
                onSelected = function() 
                    local string = KeyboardInput('Entrer vos informations', ('Exemple : Tyson'), '', 999)
					if string ~= "" then
						lastname = string 
					end
                end
            })
            RageUI.Button('→ Naissance', nil, {RightLabel = naissance}, true, {
                onSelected = function() 
                    local string = KeyboardInput('Entrer vos informations', ('Exemple 07/12/1997'), '', 999)
					if string ~= "" then
						naissance = string 
					end
                end
            })
            RageUI.Button('→ Taille', nil, {RightLabel = cm}, true, {
                onSelected = function() 
                    local string = KeyboardInput('Entrer vos informations', ('Exemple : 187'), '', 999)
					if string ~= "" then
						cm = string 
					end
                end
            })
            if cm then
                        RageUI.Info('Création LystyLife', {'Prénom : ~r~'..prenom..'~w~', "Nom : ~r~"..lastname.."~w~", "Naissance : ~r~"..naissance.."~w~", "Taille : ~r~"..cm.."~w~"}, {})
                        end

            RageUI.List("→ Choix du sexe", {"Homme","Femme"}, Creator.Indexsexe, nil, {}, true, {
                onListChange = function(index)
                    Creator.Indexsexe = index
                end,
                onSelected = function(index)
                    if index == 1 then
                        Validesex = true 
                        sexe = "m"
                        TriggerEvent("skinchanger:change", "sex", 0)
                    elseif index == 2 then
                        TriggerEvent("skinchanger:change", "sex", 1)
                        Validesex = true 
                        sexe = "f"
                    end
                end
            })

            RageUI.Button("→ Valider votre sexe", nil, {RightLabel = "→→→"}, Validesex, {
                onSelected = function()
                    if not Validesex then 
                        ESX.ShowNotification("Veuillez complétez tout les informations au dessus")
                    else
                        TriggerServerEvent("ronflex:identity", {firstname = prenom, lastname = lastname, age = naissance, taille = cm, sex = sexe})
                        destorycam(sexcam)
                        facecam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 0)
                        SetCamCoord(facecam, -785.36511230469,342.24826049805,217.15214233398)
                        SetCamActive(facecam, true)
                        RenderScriptCams(true, true, 2000, true, false)
                        SetCamParams(facecam, -785.46511230469, 342.5826049805, 217.52, 00.0 --[[ inclinaison haut pas ]], 00.0 --[[ rotation y  float]], 0.215, 42.2442, 0, 1, 1, 2)
                    end
                end
            }, apparence)

        end, function()
        end)

        RageUI.IsVisible(apparence, function()

            RageUI.Window.Heritage(Creator.Motherindex, Creator.DadIndex)

            RageUI.List("→ Père", Creator.DadList, Creator.DadIndex, nil, {}, true, {
                onListChange = function(index)
                    Creator.DadIndex = index
                    TriggerEvent("skinchanger:change", "dad", index)
                end
            })

            RageUI.List("→ Mère", Creator.MotherList, Creator.Motherindex, nil, {}, true, {
                onListChange = function(index)
                    Creator.Motherindex = index
                    TriggerEvent("skinchanger:change", "mom", index)
                end
            })

            RageUI.UISliderHeritage("→ Couleur de peau", Creator.PeauCoulour, nil, {
                onSliderChange = function(Float, Index)
                    Creator.PeauCoulour = Index 
                    Creator.PeauCoulour2 = Index*10 
                    TriggerEvent("skinchanger:change", "skin_md_weight", Creator.PeauCoulour2)
                end
            })

            RageUI.UISliderHeritage("→ Ressemblance", Creator.Ressemblance, nil, {
                onSliderChange = function(Float, Index)
                    Creator.Ressemblance = Index 
                    Creator.Ressemblance2 = Index*10 
                    TriggerEvent("skinchanger:change", "face_md_weight", Creator.Ressemblance2)
                end
            })

            RageUI.Button("→ Nez", nil, {RightLabel = "<→"}, true, {})
            RageUI.Button("→ Joue", nil, {RightLabel = "<→"}, true, {})
            RageUI.Button("→ Mâchoires", nil, {RightLabel = "<→"}, true, {})
            RageUI.Button("→ Menton", nil, {RightLabel = "<→"}, true, {})

            RageUI.Button("→ Valider son héritage", nil, {RightLabel = "→→→"}, true, {
                onSelected = function ()
                    DoScreenFadeOut(500)
                    Wait(1000)
                    destorycam(facecam)
                    SetEntityCoordsNoOffset(PlayerPedId(), vector3(-805.62152099609,332.31878662109,220.93844604492))
                    SetEntityHeading(PlayerPedId(), 3.5)
                    pilocam  = CreateCameraWithParams('DEFAULT_SCRIPTED_CAMERA', -805.61324462891,333.69589233398,221.33392334, 0.422939, 0.0, -185.3886, 43.0557, false, 2)
                    SetCamActive(pilocam, true)
                    RenderScriptCams(true, false, 3000, true, false, false)
                    Wait(1000)
                    DoScreenFadeIn(500)
                end
            }, pillosite)

        end, function()
            RageUI.PercentagePanel(Creator.PercentLargenose, 'Largeur', '0%', '100%', {
                onProgressChange = function(Percentage)
                    Creator.PercentLargenose = Percentage
                    TriggerEvent('skinchanger:change', 'nose_1', Percentage*10)
                end
            }, 5) 

            RageUI.PercentagePanel(Creator.PercentHauteurnose, 'Hauteur', '0%', '100%', {
                onProgressChange = function(Percentage)
                    Creator.PercentHauteurnose = Percentage
                    TriggerEvent('skinchanger:change', 'nose_2', Percentage*10)
                end
            }, 5) 
            
            RageUI.PercentagePanel(Creator.PercentCrochuNose, 'Crochu', '0%', '100%', {
                onProgressChange = function(Percentage)
                    Creator.PercentCrochuNose = Percentage
                    TriggerEvent('skinchanger:change', 'nose_5', Percentage*10)
                end
            }, 5) 

            RageUI.PercentagePanel(Creator.PercentJoueHauteur, 'Hauteur  des paumettes', '0%', '100%', {
                onProgressChange = function(Percentage)
                    Creator.PercentJoueHauteur = Percentage
                    TriggerEvent('skinchanger:change', 'cheeks_1', Percentage*10)
                end
            }, 6) 

            RageUI.PercentagePanel(Creator.PercentJoueCreux, 'Creux des paumettes', '0%', '100%', {
                onProgressChange = function(Percentage)
                    Creator.PercentJoueCreux = Percentage
                    TriggerEvent('skinchanger:change', 'cheeks_2', Percentage*10)
                end
            }, 6) 

            
            RageUI.PercentagePanel(Creator.PercentJoueCreuxx, 'Creux des joues', '0%', '100%', {
                onProgressChange = function(Percentage)
                    Creator.PercentJoueCreuxx = Percentage
                    TriggerEvent('skinchanger:change', 'cheeks_3', Percentage*10)
                end
            }, 6)

            --Panel pour la mâchoire
            RageUI.PercentagePanel(Creator.PercentMacoire1, 'Largeur de la Mâchoire', '0%', '100%', {
                onProgressChange = function(Percentage)
                    Creator.PercentMacoire1 = Percentage
                    TriggerEvent('skinchanger:change', 'jaw_1', Percentage*10)
                end
            }, 7) 
            
            RageUI.PercentagePanel(Creator.PercentMacoire2, 'Epaisseur de la Mâchoire', '0%', '100%', {
                onProgressChange = function(Percentage)
                    Creator.PercentMacoire2 = Percentage
                    TriggerEvent('skinchanger:change', 'jaw_2', Percentage*10)
                end
            }, 7) 

            --Panels pour le menton
            RageUI.PercentagePanel(Creator.PercentMentonHauteur, 'Hauteur du menton', '0%', '100%', {
                onProgressChange = function(Percentage)
                    Creator.PercentMentonHauteur = Percentage
                    TriggerEvent('skinchanger:change', 'chin_1', Percentage*10)
                end
            }, 8) 

            RageUI.PercentagePanel(Creator.PercentMentonLargeur, 'Largeur du menton', '0%', '100%', {
                onProgressChange = function(Percentage)
                    Creator.PercentMentonLargeur = Percentage
                    TriggerEvent('skinchanger:change', 'chin_3', Percentage*10)
                end
            }, 8) 
        end)

        RageUI.IsVisible(pillosite, function()
            
            RageUI.List("→ Cheveux", Creator.Hairlist, Creator.Hairindex, nil, {}, true, {
                onListChange = function(index)
                    Creator.Hairindex = index
                    TriggerEvent("skinchanger:change", "hair_1", index)
                end
            })

            RageUI.List("→ Barbe", Creator.BeardList, Creator.Beardindex, nil, {}, true, {
                onListChange = function(index)
                    Creator.Beardindex = index 
                    TriggerEvent("skinchanger:change", "beard_1", Creator.Beardindex)
                end
            })

            RageUI.List("→ Sourcil", Creator.EyebowList, Creator.Indexeyebow, nil, {}, true, {
                onListChange = function (index)
                    Creator.Indexeyebow = index 
                    TriggerEvent("skinchanger:change", "eyebrows_1", Creator.Indexeyebow)

                end
            })

            RageUI.List("→ Couleur des yeux", Creator.EyesColorList, Creator.EyexIndex, nil, {}, true, {
                onListChange = function (index)
                    Creator.EyexIndex = index
                    TriggerEvent("skinchanger:change", "eye_color", Creator.EyexIndex)
                end
            })

            RageUI.Button("→ Valider son visage", nil, {RightLabel = "→→→"}, true, {
                onSelected = function ()  
                    DoScreenFadeOut(500)
                    Wait(2000)
                    destorycam(pilocam) 
                    DoScreenFadeIn(500)
                    SetEntityCoordsNoOffset(PlayerPedId(), -797.69, 327.93, 220.4)
                    SetEntityHeading(PlayerPedId(), 0.39)
                    tenuecam  = CreateCameraWithParams('DEFAULT_SCRIPTED_CAMERA', -797.63, 330.63, 221.43, 0.422939, 0.0, -187.3886, 43.0557, false, 2)
                    SetCamActive(tenuecam, true)
                    PointCamAtEntity(tenuecam, PlayerPedId())
                    RenderScriptCams(true, false, 3000, true, false, false)
                end
            }, tenue)

        end, function()
            RageUI.ColourPanel("Couleur Principale", RageUI.PanelColour.HairCut, Creator.ColorHair.primary[1], Creator.ColorHair.primary[2], {
                onColorChange = function(MinimumIndex, CurrentIndex)
                    Creator.ColorHair.primary[1] = MinimumIndex
                    Creator.ColorHair.primary[2] = CurrentIndex
                    TriggerEvent("skinchanger:change", "hair_color_1" ,Creator.ColorHair.primary[2])
                end
            }, 1)

            RageUI.ColourPanel("Couleur secondaire", RageUI.PanelColour.HairCut, Creator.ColorHair.secondary[1], Creator.ColorHair.secondary[2], {
                onColorChange = function(MinimumIndex, CurrentIndex)
                    Creator.ColorHair.secondary[1] = MinimumIndex
                    Creator.ColorHair.secondary[2] = CurrentIndex
                    TriggerEvent("skinchanger:change", "hair_color_2", Creator.ColorHair.secondary[2])
                end
            }, 1)

            RageUI.PercentagePanel(Creator.OpaPercent, 'Opacité', '0%', '100%', {
                onProgressChange = function(Percentage)
                    Creator.OpaPercent = Percentage
                    TriggerEvent('skinchanger:change', 'beard_2', Percentage*10)
                end
            }, 2) 

            RageUI.ColourPanel("Couleur de la barbe", RageUI.PanelColour.HairCut, Creator.ColorBeard.secondary[1], Creator.ColorBeard.secondary[2], {
                onColorChange = function(MinimumIndex, CurrentIndex)
                    Creator.ColorBeard.secondary[1] = MinimumIndex
                    Creator.ColorBeard.secondary[2] = CurrentIndex
                    TriggerEvent("skinchanger:change", "beard_3", Creator.ColorBeard.secondary[2])
                end
            }, 2)

            RageUI.PercentagePanel(Creator.OpePercentEyebow, 'Opacité', '0%', '100%', {
                onProgressChange = function(Percentage)
                    Creator.OpePercentEyebow = Percentage
                    TriggerEvent('skinchanger:change', 'eyebrows_2', Percentage*10)
                end
            }, 3) 

            RageUI.ColourPanel("Couleur des sourcils", RageUI.PanelColour.HairCut, Creator.ColorEyebow.secondary[1], Creator.ColorEyebow.secondary[2], {
                onColorChange = function(MinimumIndex, CurrentIndex)
                    Creator.ColorEyebow.secondary[1] = MinimumIndex
                    Creator.ColorEyebow.secondary[2] = CurrentIndex
                    TriggerEvent("skinchanger:change", "eyebrows_3", Creator.ColorEyebow.secondary[2])
                end
            }, 3)
        end)

        RageUI.IsVisible(tenue, function()

            RageUI.Button('→ Tenue Stylé', nil, {}, true, {
                onSelected = function ()
                    tville()
                end
            })

            RageUI.Button('→ Tenue Décontracté', nil, {}, true, {
                onSelected = function ()
                    tete()
                end
            })

            RageUI.Button('→ Tenue Sport', nil, {}, true, {
                onSelected = function ()
                    tsport()
                end
            })

            RageUI.Button("Valider votre entrée en ville", nil, {RightLabel = "→→→"}, true, {
                onSelected = function()
                    SetPlayerControl(PlayerId(), true, 12)
                    TriggerEvent('skinchanger:getSkin', function(skin)
                        TriggerServerEvent('esx_skin:save', skin)
                    end)
                    SetEntityCoordsNoOffset(PlayerPedId(), 152.41542053223,-1001.9299926758,-99.000007629395)
                    SetEntityHeading(PlayerPedId(), 181.0)
                    TriggerEvent("creator:marker")
                    destorycam(tenuecam)
                    RageUI.CloseAll()
                end
            })
        
        end, function()
        end)
    end
end)

function destorycam(camera)
    RenderScriptCams(false, false, 0, 1, 0)
    DestroyCam(camera, false)
end

RegisterNetEvent("creator:marker")
AddEventHandler("creator:marker", function()
    TriggerServerEvent("ronflex:bucket", false)
    CreateThread(function()
        while true do 
            Wait(0)
            local dist = Vdist2(GetEntityCoords(PlayerPedId(), false), vector3(151.43418884277,-1007.9061889648,-99.000007629395))

            if dist < 250 then
                isProche = true
                DrawMarker(25, 151.43418884277,-1007.9061889648,-99.000007629395-0.98, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.55, 0.55, 0.55, 248,165,10, 255, false, false, 2, false, false, false, false)
            end
            if dist < 5 then
                ESX.ShowHelpNotification("~r~LystyLife\n~w~Appuyez sur ~INPUT_CONTEXT~ pour sortir")
                if IsControlJustPressed(1,51) then
                    SetEntityCoordsNoOffset(PlayerPedId(), 468.3497,-231.1667,53.78835)
                    SetEntityHeading(PlayerPedId(), 116.69)
                    TriggerServerEvent("ronflex:bucket", false)
                    ESX.ShowAdvancedNotification("~r~LystyLife", "Création d'identité", "Bienvenue sur LystyLife\nProfitez bien de votre aventure !")
                    DisplayRadar(true)
                    break
                end
            end
        end
    end)
end)

function tville()
    local model = GetEntityModel(GetPlayerPed(-1))
    TriggerEvent('skinchanger:getSkin', function(skin)
        if model == GetHashKey("mp_m_freemode_01")then
            clothesSkin = {
                ['bags_1'] = 0, ['bags_2'] = 0,
                ['tshirt_1'] = 15, ['tshirt_2'] = 0,
                ['torso_1'] = 86, ['torso_2'] = 2,
                ['arms'] = 1,
                ['pants_1'] = 9, ['pants_2'] = 7,
                ['shoes_1'] =7, ['shoes_2'] = 0,
                ['mask_1'] = 0, ['mask_2'] = 0,
                ['bproof_1'] = 0,
                ['chain_1'] = 0,
                ['helmet_1'] = -1, ['helmet_2'] = 0,
            }
        else
            clothesSkin = {
                ['bags_1'] = 0, ['bags_2'] = 0,
                ['tshirt_1'] = 14,['tshirt_2'] = 0,
                ['torso_1'] = 75, ['torso_2'] = 2,
                ['arms'] = 9, ['arms_2'] = 0,
                ['pants_1'] = 27, ['pants_2'] = 0,
                ['shoes_1'] = 3, ['shoes_2'] = 9,
                ['mask_1'] = 0, ['mask_2'] = 0,
                ['bproof_1'] = 0,
                ['chain_1'] = 0,
                ['helmet_1'] = -1, ['helmet_2'] = 0,
            }
        end
        TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
    end)
end

function tete()
    local model = GetEntityModel(GetPlayerPed(-1))
    TriggerEvent('skinchanger:getSkin', function(skin)
        if model == GetHashKey("mp_m_freemode_01")then
            clothesSkin = {
                ['bags_1'] = 0, ['bags_2'] = 0,
                ['tshirt_1'] = 111, ['tshirt_2'] = 0,
                ['torso_1'] = 5, ['torso_2'] = 2,
                ['arms'] = 5,
                ['pants_1'] = 12, ['pants_2'] = 0,
                ['shoes_1'] =5, ['shoes_2'] = 0,
                ['mask_1'] = 0, ['mask_2'] = 0,
                ['bproof_1'] = 0,
                ['chain_1'] = 0,
                ['helmet_1'] = -1, ['helmet_2'] = 0,
            }
        else
            clothesSkin = {
                ['bags_1'] = 0, ['bags_2'] = 0,
                ['tshirt_1'] = 8,['tshirt_2'] = 0,
                ['torso_1'] = 74, ['torso_2'] = 0,
                ['arms'] = 15, ['arms_2'] = 0,
                ['pants_1'] = 44, ['pants_2'] = 0,
                ['shoes_1'] = 3, ['shoes_2'] = 0,
                ['mask_1'] = 0, ['mask_2'] = 0,
                ['bproof_1'] = 0,
                ['chain_1'] = 0,
                ['helmet_1'] = -1, ['helmet_2'] = 0,
            }
        end
        TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
    end)
end

function tsport()
    local model = GetEntityModel(GetPlayerPed(-1))
    TriggerEvent('skinchanger:getSkin', function(skin)
        if model == GetHashKey("mp_m_freemode_01")then
            clothesSkin = {
                ['bags_1'] = 0, ['bags_2'] = 0,
                ['tshirt_1'] = 1, ['tshirt_2'] = 4,
                ['torso_1'] = 7, ['torso_2'] = 2,
                ['arms'] = 1,
                ['pants_1'] = 5, ['pants_2'] = 1,
                ['shoes_1'] =8, ['shoes_2'] = 0,
                ['mask_1'] = 0, ['mask_2'] = 0,
                ['bproof_1'] = 0,
                ['chain_1'] = 0,
                ['helmet_1'] = -1, ['helmet_2'] = 0,
            }
        else
            clothesSkin = {
                ['bags_1'] = 0, ['bags_2'] = 0,
                ['tshirt_1'] = 5, ['tshirt_2'] = 9,
                ['torso_1'] = 10, ['torso_2'] = 10,
                ['arms'] = 15,
                ['pants_1'] = 14, ['pants_2'] = 8,
                ['shoes_1'] = 4, ['shoes_2'] = 2,
                ['mask_1'] = 0, ['mask_2'] = 0,
                ['bproof_1'] = 0,
                ['chain_1'] = 0,
                ['helmet_1'] = -1, ['helmet_2'] = 0,
            }
        end
        TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
    end)
end