CoffreGangList = {
    IndexMoney = 1,
    IndexDirtyCash = 1,
    IndexStockView = 1,
    IndexDepositStock = 1,
    AccedStockItem = true,
    AccedStockWeapon = true
}

CoffreLoad = false
OpenCoffreGang = function(job)
    maincoffre = RageUI.CreateMenu("Coffre de gang", "Voici les actions disponibles")
    accedstock = RageUI.CreateSubMenu(maincoffre, "Voici le stock ", "Voici les actions disponible")
    depositstock = RageUI.CreateSubMenu(maincoffre, "Voici votre inventaire ", "Voici les actions disponible")
    TriggerServerEvent("ronflex:recievegangcoffre", job)
    ESX.PlayerData = ESX.GetPlayerData()
    RageUI.Visible(maincoffre, not RageUI.Visible(maincoffre))

    while maincoffre do
        Wait(0)

        RageUI.IsVisible(maincoffre, function()

            
            if CoffreLoad then 
                    
                RageUI.Separator(CoffreGang.label)

                RageUI.List("→ ~g~Argent Propre", {"Retirer", "Déposer"}, CoffreGangList.IndexMoney, "Vous permet de retirer ou de déposer de l'argent propre", {RightLabel = "  "..CoffreGang.data['accounts'].cash}, true, {
                    onSelected = function(index)
                        if index == 1 then 
                            if ConfigGangBuilder.AutorizeRemoveMoney[ESX.PlayerData.job2.grade_name] == true then 
                                local amount = KeyboardInput("Indiquer le montant a retirer", "Indiquer le montant a retirer", "", 5)
                                TriggerServerEvent("ronflex:actionsmoneygang", "remove", amount, "cash", CoffreGang.id)
                            else
                                ESX.ShowNotification("Vous n'avez pas les permissions pour faire cette action", flash, saveToBrief, hudColorIndex)
                            end
                        elseif index == 2 then 
                            local amount = KeyboardInput("Indiquer le montant a deposer", "Indiquer le montant a deposer", "", 5)
                            TriggerServerEvent("ronflex:actionsmoneygang", "deposit", amount, "cash", CoffreGang.id)
                        end               
                    end,

                    onListChange = function(index)
                        CoffreGangList.IndexMoney = index 
                    end
                })

                RageUI.List("→ ~r~Argent Sale", {"Retirer", "Déposer"}, CoffreGangList.IndexDirtyCash, "Vous permet de retirer ou de déposer de l'argent propre", {RightLabel =  "  "..CoffreGang.data['accounts'].dirtycash}, true, {
                    onSelected = function(index)
                        if index == 1 then 
                            if ConfigGangBuilder.AutorizeRemoveMoney[ESX.PlayerData.job2.grade_name] == true then 
                                local amount = KeyboardInput("Indiquer le montant a retirer", "Indiquer le montant a retirer", "", 5)
                                TriggerServerEvent("ronflex:actionsmoneygang", "remove", amount, "dirtycash", CoffreGang.id)
                            else
                                ESX.ShowNotification("Vous n'avez pas les permissions pour faire cette action", flash, saveToBrief, hudColorIndex)
                            end
                        elseif index == 2 then 
                            local amount = KeyboardInput("Indiquer le montant a deposer", "Indiquer le montant a deposer", "", 5)
                            TriggerServerEvent("ronflex:actionsmoneygang", "deposit", amount, "dirtycash", CoffreGang.id)
                        end
                    end,
                    onListChange = function(index)
                        CoffreGangList.IndexDirtyCash = index
                    end
                })

                RageUI.Button("→ Accéder au stock", "Vous permet d'accéder au stock", {RightLabel = "→→→"}, true, {}, accedstock)
                RageUI.Button("→ Déposer du stock", "Vous permet de déposer du stock", {RightLabel = "→→→"}, true, {}, depositstock)

            else
                RageUI.Separator('Récupération de données')
            end
        
        end, function()
        end)

        RageUI.IsVisible(accedstock, function()

            RageUI.List("Filtre", {"Indéfini", "Items", "Armes"}, CoffreGangList.IndexStockView, nil, {RightLabel = ""}, true, {
                onSelected = function(index)
                    CoffreGangList.IndexStockView = index
                end, 
                onListChange = function(index)
                    CoffreGangList.IndexStockView = index
                    if index == 1 then 
                        CoffreGangList.AccedStockItem, CoffreGangList.AccedStockWeapon = true, true
                    elseif index == 2 then 
                        CoffreGangList.AccedStockItem, CoffreGangList.AccedStockWeapon = true, false
                    elseif index == 3 then 
                        CoffreGangList.AccedStockItem, CoffreGangList.AccedStockWeapon = false, true
                    end
                end
            })

            if CoffreGangList.AccedStockItem then   
        
                if json.encode(CoffreGang.data['items']) ~= "[]" then 
                    RageUI.Separator('↓ Items ↓')

                    for k, v in pairs(CoffreGang.data['items']) do 
                        RageUI.Button("→ "..v.label.." ["..v.count.."]", nil, {RightLabel = "→→→"}, true, {
                            onSelected = function()
                                local check, amount = CheckQuantity(KeyboardInput("Indiquer le montant a retirer", "Indiquer le montant a retirer","", 6))
                                if check then 
                                    TriggerServerEvent("ronflex:actionitemgang", v.name, amount, "remove", CoffreGang.id)
                                else
                                    ESX.ShowNotification("Veuillez entrer des chiffer")
                                end
                            end
                        })

                    end
                else
                    RageUI.Separator("")
                    RageUI.Separator("~r~Aucun Items")
                    RageUI.Separator("")

                end
            end

            if CoffreGangList.AccedStockWeapon then 

                if json.encode(CoffreGang.data['weapons']) ~= "[]" then 
                    RageUI.Separator('↓ Armes ↓')

                    for k, v in pairs(CoffreGang.data['weapons']) do 
                        RageUI.Button("→ "..v.label.." ["..v.count.."]", nil, {RightLabel = "→→→"}, true, {
                            onSelected = function()
                                TriggerServerEvent("ronflex:actionweapongang", v.name, "remove", nil, nil, CoffreGang.id)
                            end
                        })
                    end

                else
                    RageUI.Separator("")
                    RageUI.Separator("~r~Aucune Armes")
                    RageUI.Separator("")

                end
                
            end
    
        end, function()
        end )


        RageUI.IsVisible(depositstock, function()

            ESX.PlayerData = ESX.GetPlayerData()
            
            RageUI.List("Filtre", {"Indéfini", "Items", "Armes"}, CoffreGangList.IndexDepositStock, nil, {RightLabel = ""}, true, {
                onSelected = function(index)
                    CoffreGangList.IndexDepositStock = index
                end, 
                onListChange = function(index)
                    CoffreGangList.IndexDepositStock = index
                    if index == 1 then 
                        CoffreGangList.AccedStockItem, CoffreGangList.AccedStockWeapon = true, true
                    elseif index == 2 then 
                        CoffreGangList.AccedStockItem, CoffreGangList.AccedStockWeapon = true, false
                    elseif index == 3 then 
                        CoffreGangList.AccedStockItem, CoffreGangList.AccedStockWeapon = false, true
                    end
                end
            })


            if CoffreGangList.AccedStockItem then 
                for k, v in pairs(ESX.PlayerData.inventory) do 
                    if v.count > 0 then 
                        RageUI.Button("→ "..v.label.." ["..v.count..']', nil, {RightLabel = "→→→"}, true, {
                            onSelected = function()
                                local check, amount = CheckQuantity(KeyboardInput("Indiquer le montant a deposer", "Indiquer le montant a deposer","", 6))
                                if check then 
                                    TriggerServerEvent("ronflex:actionitemgang", v.name, amount, "deposit",  CoffreGang.id)
                                    ESX.PlayerData = ESX.GetPlayerData()
                                else
                                    ESX.ShowNotification("Veuillez entrer des chiffer")
                                end
                            end
                        })
                    end

                end
            end

            if CoffreGangList.AccedStockWeapon then 

                if #Player.WeaponData > 0 then 
                    RageUI.Separator("↓ Armes ↓")
                    for i = 1, #Player.WeaponData, 1 do
                        if HasPedGotWeapon(PlayerPedId(), Player.WeaponData[i].hash, false) then
                            local ammo = GetAmmoInPedWeapon(PlayerPedId(), Player.WeaponData[i].hash)
                            RageUI.Button("> "..Player.WeaponData[i].label, nil, { RightLabel = "Munition(s) : ~r~x"..ammo }, true, {
                                onSelected = function()
                                    TriggerServerEvent("ronflex:actionweapongang", Player.WeaponData[i].name, "deposit", Player.WeaponData[i].label, ammo,  CoffreGang.id)
                                end
                            })
                        end
                    end
                else
                    RageUI.Separator("~r~Aucune Armes")
                end                
            end
        
        end)

        if not RageUI.Visible(maincoffre) and 
        not RageUI.Visible(accedstock) and
        not RageUI.Visible(depositstock) then 
            maincoffre = RMenu:DeleteType("maincoffre")
            accedstock = RMenu:DeleteType("accedstock")
            depositstock = RMenu:DeleteType("depositstock")
        end
    end

end
