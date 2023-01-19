OpenVestiaireGang = function()
    
    local mainvestiairegang = RageUI.CreateMenu("Vestiaire", "Voici les tenus disponibles")

    RageUI.Visible(mainvestiairegang, not RageUI.Visible(mainvestiairegang))


    while mainvestiairegang do 

        Wait(0)

        RageUI.IsVisible(mainvestiairegang, function()

            RageUI.Button("→ Reprendre sa tenue", "Vous permet de récupérer vos affaires", {RightLabel = "→→→"}, true, {
                onSelected = function()
                    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                        TriggerEvent('skinchanger:loadSkin', skin)
                        SetPedArmour(PlayerPedId(), 0)
                    end)
                end
            })

            RageUI.Button("→ Tenue de service", "Prendre votre tenue de service", {RightLabel = "→→→"}, true, {
                onSelected = function()
                    TriggerEvent('skinchanger:getSkin', function(skin)
                        if skin.sex == 0 then 
                            TriggerEvent('skinchanger:loadClothes', skin, Vestiaire[ESX.PlayerData.job2.name][ESX.PlayerData.job2.grade_name].male)

                        else
                            TriggerEvent('skinchanger:loadClothes', skin, Vestiaire[ESX.PlayerData.job2.name][ESX.PlayerData.job2.grade_name].female)
                        end
                    end)
                end
            })
        
        end)

        if not RageUI.Visible(mainvestiairegang) then 
            mainvestiairegang = RMenu:DeleteType('mainvestiairegang')
        end
    end

end