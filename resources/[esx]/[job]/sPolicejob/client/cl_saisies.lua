Stock = {}
local IndexargentSalepolice= 1
local MenuLoad = false 
OpenSaisiePolice = function()
    local mainsaisies = RageUI.CreateMenu("", "Voici les actions disponibles")
    local accedstockitem = RageUI.CreateSubMenu(mainsaisies, "", "Voici les items disponibles")
    local accedstockarmes = RageUI.CreateSubMenu(mainsaisies, "", "Voici les armes disponibles")
    local deposititem = RageUI.CreateSubMenu(mainsaisies, "", "Voici votre inventaire")
    local depositiarme = RageUI.CreateSubMenu(mainsaisies, "", "Voici votre inventaire")
    RageUI.Visible(mainsaisies, not RageUI.Visible(mainsaisies))
    TriggerServerEvent("ronflex:recievesaisieslspd")
    while not MenuLoad do 
        Wait(1)
    end
    while mainsaisies do 
        Wait(0)

        RageUI.IsVisible(mainsaisies, function()

            RageUI.List("→ Argent Sale", {"Déposer", "Retirer"}, IndexargentSalepolice, nil, {RightLabel = "~r~"..tostring(Stock.data["accounts"].dirtycash)}, true, {
                onListChange = function(index)
                    IndexargentSalepolice = index
                end, 
                onSelected = function(index)
                    if index == 1 then 
                        local verif, amount = CheckQuantity(KeyboardInput("Combien voulez vous deposer","Combien voulez vous deposer","", 20))
                        if verif then 
                            TriggerServerEvent("ronflex:saisiespoliceamount", 'deposit', amount)
                        else
                            ESX.ShowNotification("Veuillez rendre une valeur décimale")
                        end
                    elseif index == 2 then 
                        if ConfigPoliceJob.GradeAutorizeToRemoveMoney[ESX.PlayerData.job.grade_name] == true then 
                            local verif, amount = CheckQuantity(KeyboardInput("Combien voulez vous deposer","Combien voulez vous deposer","", 20))
                            if verif then 
                                TriggerServerEvent("ronflex:saisiespoliceamount", 'remove', amount)
                            else
                                ESX.ShowNotification("Veuillez rendre une valeur décimale")
                            end
                        else
                            ESX.ShowNotification("Vous n'avez pas le permission pour retirer de l'argent")
                        end
                     
                    end

                end
            })
            
            RageUI.Button("→ Accéder au stock d'item", nil, {RightLabel = "→→→"}, true, {}, accedstockitem)
            RageUI.Button("→ Accéder au stock d'armes", nil, {RightLabel = "→→→"}, true, {}, accedstockarmes)

            RageUI.Button("→ Déposer des items", nil, {RightLabel = "→→→"}, true, {}, deposititem)
            RageUI.Button("→ Déposer des armes", nil, {RightLabel = "→→→"}, true, {}, depositiarme)            
        
        end, function()
        end)

        RageUI.IsVisible(accedstockitem, function()

            for k, v in pairs(Stock.data["items"]) do 
                RageUI.Button("→ "..v.label.." ["..v.count.."]", nil, {RightLabel = "→→→"}, true, {
                    onSelected = function()
                        local verif, count = CheckQuantity(KeyboardInput("Combien voulez vous en deposer", "Combien voulez vous en deposer", "", 20))
                        if verif then 
                            TriggerServerEvent("ronflex:saisiespoliceitem", "remove", v.name, count)
                        end
                    end
                })
            end
        end, function()
        end)

        RageUI.IsVisible(accedstockarmes, function()

            for k, v in pairs(Stock.data["weapons"]) do 
                RageUI.Button("→ "..v.label.." ["..v.count.."]", nil, {RightLabel = "→→→"}, true, {
                    onSelected = function()
                        TriggerServerEvent("ronflex:saisiespoliceweapon", "remove", v.name, count)
                    end
                })
            end

        end, function()
        end)

        RageUI.IsVisible(deposititem, function()
            ESX.PlayerData = ESX.GetPlayerData()

            for k, v in pairs(ESX.PlayerData.inventory) do 
                RageUI.Button("→ "..v.label.." ["..v.count.."]", nil, {RightLabel = "→→→"}, true, {
                    onSelected = function()
                        local verif, count = CheckQuantity(KeyboardInput("Combien voulez vous en deposer", "Combien voulez vous en deposer", "", 20))
                        if verif then 
                            TriggerServerEvent("ronflex:saisiespoliceitem", "deposit", v.name, count)
                        end
                    end
                })
            end
        
        end, function()
        end)

        RageUI.IsVisible(depositiarme, function()

            ESX.PlayerData = ESX.GetPlayerData()
            for k, v in pairs(Player.WeaponData) do 
                if HasPedGotWeapon(PlayerPedId(), v.hash, false) then
                    local ammo = GetAmmoInPedWeapon(PlayerPedId(), v.hash)
                    RageUI.Button("> "..v.label, nil, { RightLabel = "Munition(s) : ~r~x"..ammo }, true, {
                        onSelected = function()
                            TriggerServerEvent("ronflex:saisiespoliceweapon", "deposit", v.name, v.label)
                        end
                    })
                end
            end

        end, function()
        end)


        if not RageUI.Visible(mainsaisies) and 
        not RageUI.Visible(accedstockitem) and 
        not RageUI.Visible(accedstockarmes) and 
        not RageUI.Visible(deposititem) and
        not RageUI.Visible(depositiarme) then 
            mainsaisies = RMenu:DeleteType('mainsaisies')
        end

    end

end


RegisterNetEvent("ronflex:recievesaisieslspdclientside")
AddEventHandler("ronflex:recievesaisieslspdclientside", function(infossociety)
    Stock = infossociety
    MenuLoad = true 
    print(Stock.data["accounts"].dirtycash)

end)