local inLivraison = false
local blip = nil
local RateLimit = false
function OpenBureauPostOp(north)
	local menu = RageUI.CreateMenu('Post-Op', "Choisis une mission")

    RageUI.Visible(menu, not RageUI.Visible(menu))

	while menu do
		Citizen.Wait(0)
        RageUI.IsVisible(menu, function()
            if not inLivraison then
                RageUI.Button('Petite Mission ( 5 livraisons )', nil, {}, true, {
                    onSelected = function()  
                        if not inLivraison then           
                            inLivraison = true
                            LystyLifeClientUtils.toServer('StartLivraison', 5, north)
                        end
                    end
                })
                RageUI.Button('Mission Normal ( 15 livraisons )', nil, {}, true, {
                    onSelected = function() 
                        if not inLivraison then
                            inLivraison = true
                            LystyLifeClientUtils.toServer('StartLivraison', 15, north)
                        else
                            ESX.ShowNotification('~r~LystyLife ~w~~n~Vous avez déjà une livraison en cours !')
                        end
                    end
                })
                if not north then
                    RageUI.Button('Grosse Mission ( 30 livraisons )', nil, {}, true, {
                        onSelected = function() 
                            if not inLivraison then
                                inLivraison = true
                                LystyLifeClientUtils.toServer('StartLivraison', 30, north)
                            else
                                ESX.ShowNotification('~r~LystyLife ~w~~n~Vous avez déjà une livraison en cours !')
                            end
                        end
                    })
                end
            else
                RageUI.Separator('')
                RageUI.Separator('Vous êtes déjà dans cette activité')
                RageUI.Separator('')
                RageUI.Button('Arrêter l\'activiter', nil, {}, true, {
                    onSelected = function() 
                        if inLivraison then
                            if not RateLimit then 
                                RateLimit = true
                                RemoveBlip(blip)
                                defaultPoint = 0
                                inLivraison = false
                                LystyLifeClientUtils.toServer('PostOpDeleteVeh')
                                ESX.ShowNotification('~r~LystyLife ~w~~n~Tu as arrêter l\'activité PostOp')
                                Citizen.SetTimeout(5000, function()
                                    RateLimit = false
                                end)
                            else
                                ESX.ShowNotification('~r~LystyLife ~w~~n~Vous allez trop vite pour le serveur')
                            end
                        else
                            ESX.ShowNotification('~r~LystyLife ~w~~n~Vous n\'etes pas entrain de faire cette activité')
                        end
                    end
                })
                RageUI.Separator('')
                RageUI.Separator('Vous êtes déjà dans cette activité')
                RageUI.Separator('')
            end
        end)
        
        if not RageUI.Visible(menu) then
            menu = RMenu:DeleteType('menu', true)
        end
    end
end

local PostOpBlipsNorth = {
    [5] = {
       [1] = vector3(-372.3629, 6181.357, 31.496),
       [2] = vector3(-266.7997, 6249.383, 31.476),
       [3] = vector3(-20.662, 6490.471, 31.500),
       [4] = vector3(28.828, 6653.421, 31.398),
       [5] = vector3(-360.459, 6320.413, 29.755),
    },
    [15] = {
        [1] = vector3(-372.3629, 6181.357, 31.496),
        [2] = vector3(-266.7997, 6249.383, 31.476),
        [3] = vector3(-20.662, 6490.471, 31.500),
        [4] = vector3(28.828, 6653.421, 31.398),
        [5] = vector3(-360.459, 6320.413, 29.755),
        [6] = vector3(-417.817, 6255.2, 30.508),
        [7] = vector3(-423.9019, 6024.749, 31.484),
        [8] = vector3(-773.965, 5597.635, 33.6078),
        [9] = vector3(-695.5931, 5802.124, 17.330),
        [10] = vector3(416.2063, 6520.761, 27.728),
        [11] = vector3(1585.876, 6450.916, 23.317),
        [12] = vector3(1510.096, 6326.203, 24.607),
        [13] = vector3(93.164, 6358.315, 31.375),
        [14] = vector3(-341.7093, 6066.412, 31.485),
        [15] = vector3(-2179.426, 4282.249, 49.11207),
    },
    [30] = {
        [1] = vector3(-372.3629, 6181.357, 31.496),
        [2] = vector3(-266.7997, 6249.383, 31.476),
        [3] = vector3(-20.662, 6490.471, 31.500),
        [4] = vector3(28.828, 6653.421, 31.398),
        [5] = vector3(-360.459, 6320.413, 29.755),
        [6] = vector3(-417.817, 6255.2, 30.508),
        [7] = vector3(-423.9019, 6024.749, 31.484),
        [8] = vector3(-773.965, 5597.635, 33.6078),
        [9] = vector3(-695.5931, 5802.124, 17.330),
        [10] = vector3(416.2063, 6520.761, 27.728),
        [11] = vector3(1585.876, 6450.916, 23.317),
        [12] = vector3(1510.096, 6326.203, 24.607),
        [13] = vector3(93.164, 6358.315, 31.375),
        [14] = vector3(-341.7093, 6066.412, 31.485),
        [15] = vector3(-2179.426, 4282.249, 49.11207),
    }
}

local PostOpBlipsSud = {
    [5] = {
        [1] = vector3(94.638, -2676.372, 6.004),
        [2] = vector3(136.951, -2472.815, 5.999),
        [3] = vector3(370.518, -2452.364, 6.696),
        [4] = vector3(373.8599, -2420.05, 6.041),
        [5] = vector3(441.7953, -2080.807, 22.242),
    },
    [15] = {
        [1] = vector3(94.638, -2676.372, 6.004),
        [2] = vector3(136.951, -2472.815, 5.999),
        [3] = vector3(370.518, -2452.364, 6.696),
        [4] = vector3(373.8599, -2420.05, 6.041),
        [5] = vector3(441.7953, -2080.807, 22.242),
        [6] = vector3(450.3149, -1981.342, 24.401),
        [7] = vector3(273.3671, -1824.753, 26.890),
        [8] = vector3(194.2513, -1770.531, 29.165),
        [9] = vector3(125.720, -1704.808, 29.291),
        [10] = vector3(4.399, -1611.433, 29.292),
        [11] = vector3(51.888, -1486.591, 29.2676),
        [12] = vector3(224.9143, -1511.28, 29.291),
        [13] = vector3(379.4511, -1781.262, 29.447),
        [14] = vector3(463.765, -1851.783, 27.810),
        [15] = vector3(964.3348, -1780.063, 31.235),
    },
    [30] = {
        [1] = vector3(94.638, -2676.372, 6.004),
        [2] = vector3(136.951, -2472.815, 5.999),
        [3] = vector3(370.518, -2452.364, 6.696),
        [4] = vector3(373.8599, -2420.05, 6.041),
        [5] = vector3(441.7953, -2080.807, 22.242),
        [6] = vector3(450.3149, -1981.342, 24.401),
        [7] = vector3(273.3671, -1824.753, 26.890),
        [8] = vector3(194.2513, -1770.531, 29.165),
        [9] = vector3(125.720, -1704.808, 29.291),
        [10] = vector3(4.399, -1611.433, 29.292),
        [11] = vector3(51.888, -1486.591, 29.2676),
        [12] = vector3(224.9143, -1511.28, 29.291),
        [13] = vector3(379.4511, -1781.262, 29.447),
        [14] = vector3(463.765, -1851.783, 27.810),
        [15] = vector3(964.3348, -1780.063, 31.235),
        [16] = vector3(94.638, -2676.372, 6.004),
        [17] = vector3(463.765, -1851.783, 27.810),
        [18] = vector3(379.4511, -1781.262, 29.447),
        [19] = vector3(224.9143, -1511.28, 29.291),
        [20] = vector3(51.888, -1486.591, 29.2676),
        [21] = vector3(4.399, -1611.433, 29.292),
        [22] = vector3(125.720, -1704.808, 29.291),
        [23] = vector3(194.2513, -1770.531, 29.165),
        [24] = vector3(273.3671, -1824.753, 26.890),
        [25] = vector3(450.3149, -1981.342, 24.401),
        [26] = vector3(441.7953, -2080.807, 22.242),
        [27] = vector3(373.8599, -2420.05, 6.041),
        [28] = vector3(370.518, -2452.364, 6.696),
        [29] = vector3(136.951, -2472.815, 5.999),
        [30] = vector3(94.638, -2676.372, 6.004),
    }
}

LystyLife.netRegisterAndHandle('SetTenueAndPoint-North', function(arguments)
    local defaultPoint = 1

    blip = AddBlipForCoord(PostOpBlipsNorth[arguments][defaultPoint])
    SetBlipColour(blip, 60)
    SetBlipRoute(blip, true)
    while true do
        local isProche = false
        for k,v in pairs(ZonesListe) do
            if v.Public or ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == v.Job or ESX.PlayerData.job2.name == v.Job2 then
                local dist = Vdist2(GetEntityCoords(PlayerPedId(), false), PostOpBlipsNorth[arguments][defaultPoint])

                if dist < 250 then
                    isProche = true
                    DrawMarker(25, PostOpBlipsNorth[arguments][defaultPoint].x, PostOpBlipsNorth[arguments][defaultPoint].y, PostOpBlipsNorth[arguments][defaultPoint].z-0.98, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.55, 0.55, 0.55, 104, 0, 214, 255, false, false, 2, false, false, false, false)
                end
                if dist < 10 then
                    ESX.ShowHelpNotification("~r~LystyLife Roleplay\n~r~Appuyez sur ~INPUT_CONTEXT~ pour intéragir")
                    if IsControlJustPressed(1,51) then
                        if IsPedSittingInAnyVehicle(PlayerPedId()) then
                            ESX.ShowNotification('~r~LystyLife~w~~n~Vous devez déscendre du véhicule')
                        else
                            defaultPoint = defaultPoint +1
                            LystyLifeClientUtils.toServer('FinishLivraison')
                            RemoveBlip(blip)
                            if defaultPoint > arguments then
                                defaultPoint = 0
                                inLivraison = false
                                break
                            else
                                blip = AddBlipForCoord(PostOpBlipsNorth[arguments][defaultPoint])
                                SetBlipColour(blip, 60)
                                SetBlipRoute(blip, true)
                            end
                            Wait(1000)
                        end
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

LystyLife.netRegisterAndHandle('SetTenueAndPoint-Sud', function(arguments)
    local defaultPoint = 1

    blip = AddBlipForCoord(PostOpBlipsSud[arguments][defaultPoint])
    SetBlipColour(blip, 60)
    SetBlipRoute(blip, true)
    while true do
        local isProche = false
        for k,v in pairs(ZonesListe) do
            if v.Public or ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == v.Job or ESX.PlayerData.job2.name == v.Job2 then
                local dist = Vdist2(GetEntityCoords(PlayerPedId(), false), PostOpBlipsSud[arguments][defaultPoint])

                if dist < 250 then
                    isProche = true
                    DrawMarker(25, PostOpBlipsSud[arguments][defaultPoint].x, PostOpBlipsSud[arguments][defaultPoint].y, PostOpBlipsSud[arguments][defaultPoint].z-0.98, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.55, 0.55, 0.55, 104, 0, 214, 255, false, false, 2, false, false, false, false)
                end
                if dist < 10 then
                    ESX.ShowHelpNotification("~r~LystyLife Roleplay\n~r~Appuyez sur ~INPUT_CONTEXT~ pour intéragir")
                    if IsControlJustPressed(1,51) then
                        if IsPedSittingInAnyVehicle(PlayerPedId()) then
                            ESX.ShowNotification('~r~LystyLife~w~~n~Vous devez déscendre du véhicule')
                        else
                            defaultPoint = defaultPoint +1
                            LystyLifeClientUtils.toServer('FinishLivraison')
                            RemoveBlip(blip)
                            if defaultPoint > arguments then
                                defaultPoint = 0
                                inLivraison = false
                                break
                            else
                                blip = AddBlipForCoord(PostOpBlipsSud[arguments][defaultPoint])
                                SetBlipColour(blip, 60)
                                SetBlipRoute(blip, true)
                            end
                            Wait(1000)
                        end
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

RegisterCommand('heading', function()
    print(GetEntityHeading(PlayerPedId()))
end)