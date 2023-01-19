local listeItem = {
    ['phone'] = {name = 'phone', label = 'Téléphone', price = 150, category = 'Superette'},
    ['radio'] = {name = 'radio', label = 'Radio', price = 150, category = 'Superette'},
    ['bread'] = {name = 'bread', label = 'Sandwich', price = 50, category = 'Superette'},
    ['water'] = {name = 'water', label = 'Eau de source', price = 50, category = 'Superette'},
    ['weapon_hammer'] = {name = 'weapon_hammer', label = 'Marteau', price = 150000, category = 'Quincaillerie'},
    ['weapon_crowbar'] = {name = 'weapon_crowbar', label = 'Pied de Biche', price = 175000, category = 'Quincaillerie'},
    ['weapon_wrench'] = {name = 'weapon_wrench', label = 'Clé Anglaise', price = 200000, category = 'Quincaillerie'},
    ['weapon_golfclub'] = {name = 'weapon_golfclub', label = 'Club de Golf', price = 225000, category = 'Quincaillerie'},
    ['weapon_poolcue'] = {name = 'weapon_poolcue', label = 'Queue de Billard', price = 15000, category = 'Ammu-Nation'},
    ['weapon_knuckle'] = {name = 'weapon_knuckle', label = 'Poing Américain', price = 15000, category = 'Ammu-Nation'},
    ['weapon_knife'] = {name = 'weapon_knife', label = 'Couteau - Vip ~y~Gold', price = 15000, category = 'Ammu-Nation'},
    ['weapon_battleaxe'] = {name = 'weapon_battleaxe', label = 'Hache de Combat - Vip ~y~Gold', price = 15000, category = 'Ammu-Nation'},
    ['weapon_poolcue'] = {name = 'weapon_poolcue', label = 'Queue de billard - Vip ~y~Gold', price = 15000, category = 'Ammu-Nation'},
    ['weapon_snspistol'] = {name = 'weapon_snspistol', label = 'Pistolet SNS', price = 320000, category = 'Ammu-Nation'},
    ['weapon_pistol'] = {name = 'weapon_pistol', label = 'Berreta - Vip ~y~Gold', price = 380000, category = 'Ammu-Nation'},
    ['weapon_revolver'] = {name = 'weapon_revolver', label = 'Revolver - VIP ~y~Diamond', price = 450000, category = 'Ammu-Nation'},
    ['clip'] = {name = 'clip', label = 'Boite de Munitions', price = 100, category = 'Ammu-Nation1'},
    ['cafe'] = {name = 'cafe', label = 'Café - VIP ~y~Gold', price = 50, category = 'Superette'},
    ['donut'] = {name = 'donut', label = 'Donut - VIP ~y~Gold', price = 50, category = 'Superette'},
    ['jusleechi'] = {name = 'jusleechi', label = 'Jus de Leechi - VIP ~y~Diamond', price = 50, category = 'Superette'},
    ['hotdog'] = {name = 'hotdog', label = 'Hot-dog - VIP ~y~Diamond', price = 50, category = 'Superette'},
    ['basic_cuff'] = {name = 'basic_cuff', label = 'Menotte Basique', price = 15000, category = 'ShopIllegaltem'},
    ['basic_key'] = {name = 'basic_key', label = 'Clé Menotte Basique', price = 15000, category = 'ShopIllegaltem'},
    ['piluleoubli'] = {name = 'piluleoubli', label = 'Pillule D\'Oublie', price = 10000, category = 'ShopIllegaltem'},
    ['bankcard'] = {name = 'bankcard', label = 'Clé USB ( Braquage )', price = 25000, category = 'ShopIllegaltem'},
    ['drill'] = {name = 'drill', label = 'Perceuse ( Braquage )', price = 25000, category = 'ShopIllegaltem'},
}

RegisterServerEvent('core:achat')
AddEventHandler('core:achat', function(item, price, type)
    local xPlayer = ESX.GetPlayerFromId(source)

    if listeItem[item] == nil then
        DropPlayer(source, 'Utilisation d\'un Trigger ( LTD )'.. item, price, type)
    else
        if listeItem[item].name == item and listeItem[item].price == tonumber(price) then
                if type == 1 then
                    if xPlayer.getAccount('cash').money >= listeItem[item].price then
                        xPlayer.removeAccountMoney('cash', price)
                        if listeItem[item].category == "Ammu-Nation" or listeItem[item].category == "Quincaillerie" then
                            xPlayer.addWeapon(listeItem[item].name, 25)
                        else
                            xPlayer.addInventoryItem(listeItem[item].name, 1)
                        end
                        TriggerClientEvent('esx:showNotification', xPlayer.source, '~g~'.. listeItem[item].category.. '~n~~w~Vous avez acheté ~r~'.. listeItem[item].label .. '~w~ pour : '.. listeItem[item].price .. '$')
                        TriggerClientEvent('esx:showNotification', xPlayer.source, '~r~Type de paiement : ~w~Liquide') 
                    else
                        TriggerClientEvent('esx:showNotification', xPlayer.source, '~g~'.. listeItem[item].category ..'~n~~w~Vous n\'avez pas l\'argent nécéssaire')
                    end
                elseif type == 2 then
                    if tonumber(xPlayer.getAccount('bank').money) >= price then
                        xPlayer.removeAccountMoney('bank', price)
                        if listeItem[item].category == "Ammu-Nation" or listeItem[item].category == "Quincaillerie" then
                            xPlayer.addWeapon(listeItem[item].name, 25)
                        else
                            xPlayer.addInventoryItem(listeItem[item].name, 1)
                        end
                        TriggerClientEvent('esx:showNotification', xPlayer.source, '~g~'.. listeItem[item].category.. ' ~n~~w~Vous avez acheté ~r~'.. listeItem[item].label .. '~w~ pour : '.. listeItem[item].price .. '$')
                        TriggerClientEvent('esx:showNotification', xPlayer.source, '~r~Type de paiement : ~w~Carte Bancaire')
                    else
                        TriggerClientEvent('esx:showNotification', xPlayer.source, '~g~'.. listeItem[item].category ..'~n~~w~Vous n\'avez pas l\'argent nécéssaire')
                    end
                elseif type == 3 then
                    if tonumber(xPlayer.getAccount('dirtycash').money) >= price then
                        xPlayer.removeAccountMoney('dirtycash', price)
                        if listeItem[item].category == "ShopIllegaltem" then
                            xPlayer.addInventoryItem(listeItem[item].name, 1)
                        else
                            DropPlayer(source, "Mais alors toi !")
                        end
                        TriggerClientEvent('esx:showNotification', xPlayer.source, '~g~'.. listeItem[item].category.. ' ~n~~w~Vous avez acheté '.. listeItem[item].label .. '~w~ pour : '.. listeItem[item].price .. ' ~r~$')
                        TriggerClientEvent('esx:showNotification', xPlayer.source, '~r~Type de paiement : ~r~Argent Sale')
                else
                    TriggerClientEvent('esx:showNotification', xPlayer.source, '~g~'.. listeItem[item].category ..'~n~~w~Vous n\'avez pas d\'Argent Sale sur vous')
                end
            else 
                DropPlayer(source, 'Utilisation d\'un Trigger ( LTD )'.. item, price, type)
            end
        end
    end
end)

LystyLife.netRegisterAndHandle("ewen:buyTintWeapon", function(result)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getAccount('cash').money >= result.price then
        xPlayer.removeAccountMoney('cash', result.price)
        LystyLifeServerUtils.toClient('eCustom:ChangeWeaponTint', source, result.value)
        xPlayer.showNotification('~r~LystyLife ~w~~n~Vous avez mis une couleur sur votre arme')
    elseif xPlayer.getAccount('bank').money >= result.price then
        xPlayer.removeAccountMoney('bank', result.price)
        LystyLifeServerUtils.toClient('eCustom:ChangeWeaponTint', source, result.value)
        xPlayer.showNotification('~r~LystyLife ~w~~n~Vous avez mis une couleur sur votre arme')
    else
        xPlayer.showNotification('~r~LystyLife ~w~~n~Vous n\'avez pas l\'argent nécéssaire')
    end
end)

RegisterServerEvent('capsule:removeClip')
AddEventHandler('capsule:removeClip', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('clip', 1)
end)

ESX.RegisterUsableItem('clip', function(source)
	TriggerClientEvent('capsule:useClip', source)
end)