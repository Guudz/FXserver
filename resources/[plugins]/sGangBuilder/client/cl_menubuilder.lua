GangBuilder = {
    Builder = {
        Blips = {}
    },
    
    NameGang = "~r~Indéfini",
    LabelGang = "~r~Indéfini",
    PositionPatron = "~r~Indéfini",
    PositionGarage = "~r~Indéfini",
    PositionGarageDelete = "~r~Indéfini",
    PositionSpawnVeh = "~r~Indéfini",
    PositionVestiaire = "~r~Indéfini",
    NameBlips = "~r~Indéfini",
    IDBlips = "~r~Indéfini",
    ColourBlips = "~r~Indéfini",
    ScaleBlips = "~r~Indéfini",
    GiveMoney = "~r~Indéfini",

    LabelGangKey = false,
    PositionPatronKey = false,
    PositionGarageKey = false,
    PositionGarageDeleteKey = false,
    PositionSpawnVehKey = false,
    PositionVestiaireKey = false,
    NameBlipsKey = false,
    IDBlipsKey = false,
    ColourBlipsKey = false,
    ScaleBlipsKey = false,
    GiveMoneyKey = false,
    ValideKey = false,

    GangActionsBuilder = 1,
    InformationsTpGang = 1
}


RegisterNetEvent("ronflex:opengangbuilder")
AddEventHandler("ronflex:opengangbuilder", function(gang)
    AllGangs = gang
    local mainbuilder = RageUI.CreateMenu('rGangBuilder', "Voici les actions disponibles")


    RageUI.Visible(mainbuilder, not RageUI.Visible(mainbuilder))

    while mainbuilder do 
        Wait(0)

        RageUI.IsVisible(mainbuilder, function()

            RageUI.Separator("↓ Création de gang ↓")
            RageUI.Button("→ Créer un gang", "Vous permet de créer un gang", {RightLabel = "→→→"}, true, {
                onSelected = function()
                    GangBuilder.OpenBuilderGang()
                end
            })

            RageUI.Separator('↓ Modification de gang ↓')
            RageUI.Button("→ Modifier un gang", "Vous permet de modifier un gang existant", {RightLabel = "→→→"}, true, {
                onSelected = function()
                    GangBuilder.OpenEditGang()
                end
            })
        
        end)

        if not RageUI.Visible(mainbuilder) then 
            mainbuilder = RMenu:DeleteType("mainbuilder")
        end

    end

end)


GangBuilder.OpenBuilderGang = function()

    local buildergang = RageUI.CreateMenu("Création de gang", "Voici les actions disponibles")

    RageUI.Visible(buildergang, not RageUI.Visible(mainbuilder))

    while buildergang do 
        Wait(0)

        RageUI.IsVisible(buildergang, function()

            RageUI.Separator('↓ Information sur le gang ↓')

            RageUI.Button("→ Nom du gang", "Indiquer le nom du gang en Base de donnée", {RightLabel = GangBuilder.NameGang}, true, {
                onSelected = function()
                    local namegang = KeyboardInput("Indiquer le nom du gang", "Indiquer le nom du gang", "", 15)
                    GangBuilder.NameGang = namegang
                    GangBuilder.Builder.name = namegang
                    GangBuilder.LabelGangKey = true

                end
            })

            RageUI.Button("→ Label du gang", "Indiquer le label du gang en jeu", {RightLabel = GangBuilder.LabelGang}, GangBuilder.LabelGangKey, {
                onSelected = function()
                    local labelgang = KeyboardInput("Indiquer le label du gang", "Indiquer le label du gang", "", 15)
                    GangBuilder.LabelGang = labelgang
                    GangBuilder.Builder.label = labelgang
                    GangBuilder.PositionPatronKey = true
                end
            })

            RageUI.Separator("↓ Positions ↓")

            RageUI.Button("→ Postion Coffre", "Indiquer la position du coffre", {RightLabel = GangBuilder.PositionPatron}, GangBuilder.PositionPatronKey, {
                onSelected = function()
                    GangBuilder.PositionPatron = "~g~Défini"
                    GangBuilder.Builder.pospatron = json.encode(GetEntityCoords(PlayerPedId()))
                    GangBuilder.PositionGarageKey = true
                end
            })

            RageUI.Button("→ Postion Garage", "Indiquer la position du garage", {RightLabel = GangBuilder.PositionGarage}, GangBuilder.PositionGarageKey, {
                onSelected = function()
                    GangBuilder.PositionGarage = "~g~Défini"
                    GangBuilder.Builder.posgarage = json.encode(GetEntityCoords(PlayerPedId()))
                    GangBuilder.PositionGarageDeleteKey = true
                end
            })

            RageUI.Button("→ Postion Suppression véhicule", "Indiquer la position pour ranger le véhicule", {RightLabel = GangBuilder.PositionGarageDelete}, GangBuilder.PositionGarageDeleteKey, {
                onSelected = function()
                    GangBuilder.PositionGarageDelete = "~g~Défini"
                    GangBuilder.Builder.posgaragedelete = json.encode(GetEntityCoords(PlayerPedId()))
                    GangBuilder.PositionSpawnVehKey = true
                end
            })

            RageUI.Button("→ Position spawn véhicule", "Indiquer la position de spawn pour le véhicule", {RightLabel = GangBuilder.PositionSpawnVeh}, GangBuilder.PositionSpawnVehKey, {
                onSelected = function()
                    GangBuilder.PositionSpawnVeh = "~g~Défini"
                    GangBuilder.Builder.posgaragespawn = GetEntityCoords(PlayerPedId())
                    GangBuilder.Builder.posgaragespawnheading = GetEntityHeading(PlayerPedId())
                    GangBuilder.PositionVestiaireKey = true
                end
            })

            RageUI.Button("→ Postion Vestiaire", "Indiquer la position des vestiaires", {RightLabel = GangBuilder.PositionVestiaire}, GangBuilder.PositionVestiaireKey, {
                onSelected = function()
                    GangBuilder.PositionVestiaire = "~g~Défini"
                    GangBuilder.Builder.posvestiaire = json.encode(GetEntityCoords(PlayerPedId()))
                    GangBuilder.GiveMoneyKey = true
                    GangBuilder.NameBlipsKey = true
                end
            })

            RageUI.Separator("↓ Blips ↓")

            RageUI.Button("→ Nom du blips", "Indiquer le nom du blips", {RightLabel = GangBuilder.NameBlips}, GangBuilder.NameBlipsKey, {
                onSelected = function()
                    local nameblips = KeyboardInput("Nom du blips", "Nom du blips", "", 15)
                    GangBuilder.NameBlips = "~g~Défini"
                    GangBuilder.Builder.Blips.name = nameblips
                    GangBuilder.IDBlipsKey = true
                end
            })

            RageUI.Button("→ ID du blips", "Indiquer l'id du blips", {RightLabel = GangBuilder.IDBlips}, GangBuilder.IDBlipsKey, {
                onSelected = function()
                    local spriteblips = KeyboardInput("Nom du blips", "Nom du blips", "", 15)
                    GangBuilder.IDBlips = "~g~Défini"
                    GangBuilder.Builder.Blips.id = tonumber(spriteblips)
                    GangBuilder.ColourBlipsKey = true
                end
            })

            RageUI.Button("→ Couleur du blips", "Indiquer l'id du blips", {RightLabel = GangBuilder.ColourBlips}, GangBuilder.ColourBlipsKey, {
                onSelected = function()
                    local coulourblips = KeyboardInput("Couleur du blips", "Couleur du blips", "", 15)
                    GangBuilder.ColourBlips = "~g~Défini"
                    GangBuilder.Builder.Blips.colour = tonumber(coulourblips)
                    GangBuilder.ColourBlipsKey = true
                end
            })

            RageUI.Button("→ Taille du blips", "Indiquer la taille du blips (entre 0 et 1)", {RightLabel = GangBuilder.ScaleBlips}, GangBuilder.ColourBlipsKey, {
                onSelected = function()
                    local scaleblips = KeyboardInput("Taille du blips", "Taille du blips", "", 15)
                    GangBuilder.ScaleBlips = "~g~Défini"
                    GangBuilder.Builder.Blips.scale = tonumber(scaleblips)
                    GangBuilder.ScaleBlipsKey = true
                    GangBuilder.ValideKey = true 
                end
            })

            RageUI.Separator("↓ Options supplémentaire ↓")

            RageUI.Button("→ Définir une somme de départ", "Vous permet de mettre de l'argent dans le coffre pour la création", {RightLabel = GangBuilder.GiveMoney}, GangBuilder.GiveMoneyKey, {
                onSelected = function()
                    local ammount = KeyboardInput("Indiquer le montant à give", "Indiquer le montant à give", "", 15)
                    GangBuilder.GiveMoney = ammount 
                    GangBuilder.Builder.amount = ammount
                end
            })

            RageUI.Button("~g~Valider la création", "Vous permet de créer le gang", {RightLabel = "→→→"}, GangBuilder.ValideKey, {
                onSelected = function()
                    TriggerServerEvent("ronflex:creategang", GangBuilder.Builder)
                end
            })       
        
        end)

        if not RageUI.Visible(buildergang) then 
            buildergang = RMenu:DeleteType("buildergang")
            TriggerEvent("ronflex:opengangbuilder")
        end

    end


end


GangBuilder.OpenEditGang = function()

    local etditgang = RageUI.CreateMenu("Modification de gang", "Voici les actions disponibles")
    
    RageUI.Visible(etditgang, not RageUI.Visible(etditgang))

    while etditgang do 
        Wait(0)

        RageUI.IsVisible(etditgang, function()

            RageUI.Separator("↓ Gangs Actifs ↓")

            for k, v in pairs(AllGangs) do 

                RageUI.List("→ Gang ~b~"..v.label, {"~b~Modifier~s~", "~g~Informations~s~", "~r~Supprimmer~s~"}, GangBuilder.GangActionsBuilder, nil, {}, true, {
                    onListChange = function(index)
                        GangBuilder.GangActionsBuilder = index 
                    end,
                    onSelected = function(index)
                        if index == 1 then 
                            GangBuilder.OpenModifcationGang(v.name)
                        elseif index == 2 then 
                            GangBuilder.OpenInformationsGang(AllGangs[v.name])
                        elseif index == 3 then 
                            TriggerServerEvent("ronflex:actionsgangmodif", "delete", v.name)
                        end
                    end
                })

            end
        end)

        if not RageUI.Visible(etditgang) then 
            etditgang = RMenu:DeleteType("etditgang")
            TriggerEvent("ronflex:opengangbuilder")
        end

    end

end



GangBuilder.OpenInformationsGang = function(gang)
    InfosGangAction = gang

    local informationsgang = RageUI.CreateMenu("Information du gang ", "Voici les actions disponibles")
    
    RageUI.Visible(informationsgang, not RageUI.Visible(informationsgang))

    while informationsgang do 
        Wait(0)

        RageUI.IsVisible(informationsgang, function()   
            print(InfosGangAction.blips.id)

            RageUI.Separator('ID Unique: ~b~'..InfosGangAction.id)
            RageUI.Separator('Nom du gang: ~b~'..InfosGangAction.name)
            RageUI.Separator('Label du gang: ~b~'..InfosGangAction.label)
            RageUI.Separator('ID du blips: ~b~'..InfosGangAction.blips.id)
            RageUI.Separator('Nom du blips: ~b~'..InfosGangAction.blips.name)

            RageUI.Separator("Argent propre: ~g~"..InfosGangAction.data['accounts'].cash.." $")
            RageUI.Separator("Argent Sale: ~r~"..InfosGangAction.data['accounts'].dirtycash.." $")

            RageUI.List("→ Se TP à", {"Vestiaire", "Coffre", "Garage"}, GangBuilder.InformationsTpGang, nil, {}, true, {
                onListChange = function(index)
                    GangBuilder.InformationsTpGang = index 
                end,
                onSelected = function(index)
                    if index == 1 then 
                        TriggerServerEvent("ronflex:actionsgangmodif", "tpvestiaire", InfosGangAction.name)
                    elseif index == 2 then 
                        TriggerServerEvent("ronflex:actionsgangmodif", "tpcoffre", InfosGangAction.name)
                    elseif index == 3 then 
                        TriggerServerEvent("ronflex:actionsgangmodif", "tpgarage", InfosGangAction.name)

                    end
                end
            })

            
        end)

        if not RageUI.Visible(informationsgang) then 
            informationsgang = RMenu:DeleteType("informationsgang")
            GangBuilder.OpenEditGang()
        end

    end

end


GangBuilder.OpenModifcationGang = function(name)
    GangName = name
    
    local modificationgang = RageUI.CreateMenu("Modification de gang", "Voici les actions disponibles")
    
    RageUI.Visible(modificationgang, not RageUI.Visible(modificationgang))

    while modificationgang do 
        Wait(0)

        RageUI.IsVisible(modificationgang, function()   

            RageUI.Separator("↓ Positions ↓")
            
            RageUI.Button("→ Changer la position du coffre", nil, {RightLabel = "→→→"}, true, {
                onSelected = function()
                    TriggerServerEvent("ronflex:actionsgangmodif", "modifposcoffre", GangName)
                end
            })

            RageUI.Button("→ Changer la position du vestiaire", nil, {RightLabel = "→→→"}, true, {
                onSelected = function()
                    TriggerServerEvent("ronflex:actionsgangmodif", "modifposvestiaire", GangName)
                end
            })

            RageUI.Button("→ Changer la position du garage", nil, {RightLabel = "→→→"}, true, {
                onSelected = function()
                    TriggerServerEvent("ronflex:actionsgangmodif", "modifposgarage", GangName)
                end
            })

            RageUI.Button("→ Changer la position du point delete", nil, {RightLabel = "→→→"}, true, {
                onSelected = function()
                    TriggerServerEvent("ronflex:actionsgangmodif", "modifposgaragedelete", GangName)
                end
            })

            RageUI.Separator("↓ Blips ↓")

            RageUI.Button("→ Changer le sprite du blips", "Vous permet de changer le sprite du blips", {RightLabel = "→→→"}, true, {
                onSelected = function()
                    local newblips = KeyboardInput("Indiquer le nouveau sprite", "Indiquer le nouveau sprite", "", 5)
                    TriggerServerEvent("ronflex:actionsgangmodif", "modifspriteblips", GangName, newblips)

                end
            })
            
        end)

        if not RageUI.Visible(modificationgang) then 
            modificationgang = RMenu:DeleteType("modificationgang")
            GangBuilder.OpenEditGang()
        end

    end

end

