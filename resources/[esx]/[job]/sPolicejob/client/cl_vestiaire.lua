OpenVestiairePolice = function()

    local mainvestiaire = RageUI.CreateMenu("", "Voici les armes disponibles")
    RageUI.Visible(mainvestiaire, not RageUI.Visible(mainvestiaire))

    while mainvestiaire do 
        Wait(0)

        RageUI.IsVisible(mainvestiaire, function()
            RageUI.Separator("Votre Grade: ~r~"..ESX.PlayerData.job.grade_label)
            RageUI.Button("→ Reprendre sa tenue", "Vous permet de récupérer vos affaires", {RightLabel = "→→→"}, true, {
                onSelected = function()
                    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                        TriggerEvent('skinchanger:loadSkin', skin)
                        SetPedArmour(PlayerPedId(), 0)
                    end)
                end
            })

            RageUI.Button("→ Gilet par balle", "Prendre un gilet par balle", {RightLabel = "→→→"}, true, {
                onSelected = function()
                    TriggerEvent('skinchanger:getSkin', function(skin)
                        local newclothes = { ["bproof_1"] = 2, ["bproof_2"] = 0}
                        TriggerEvent('skinchanger:loadClothes', skin, newclothes)
                        SetPedArmour(PlayerPedId(), 100)

                    end)

                end
            })

            RageUI.Button("→ Tenue de service", "Prendre votre tenue de service", {RightLabel = "→→→"}, true, {
                onSelected = function()
                    TriggerEvent('skinchanger:getSkin', function(skin)
                        if skin.sex == 0 then 
                            TriggerEvent('skinchanger:loadClothes', skin, TenuePolice[ESX.PlayerData.job.grade_name].male)

                        else
                            TriggerEvent('skinchanger:loadClothes', skin, TenuePolice[ESX.PlayerData.job.grade_name].female)
                        end
                    end)
                end
            })

			RageUI.Button("→ Tenue de cérémonie", "Prendre votre tenue de cérémonie", {RightLabel = "→→→"}, true, {
                onSelected = function()
                    TriggerEvent('skinchanger:getSkin', function(skin)
                        if skin.sex == 0 then 
                            TriggerEvent('skinchanger:loadClothes', skin, TenuePolice.ceremony.male)

                        else
                            TriggerEvent('skinchanger:loadClothes', skin, TenuePolice.ceremony.female)
                        end
                    end)
                end
            })

			if ESX.PlayerData.job.grade_name ~= "recruit" then 
				RageUI.Button("→ Tenue SWATT", "Prendre votre tenue de SWATT", {RightLabel = "→→→"}, true, {
					onSelected = function()
						TriggerEvent('skinchanger:getSkin', function(skin)
							if skin.sex == 0 then 
								TriggerEvent('skinchanger:loadClothes', skin, TenuePolice.swatt.male)
	
							else
								TriggerEvent('skinchanger:loadClothes', skin, TenuePolice.swatt.female)
							end
						end)
					end
				})

			end

		
         
         
        end, function()
        end)

        if not RageUI.Visible(mainvestiaire) then
            mainvestiaire = RMenu:DeleteType("mainvestiaire")
        end
        
    end

end
