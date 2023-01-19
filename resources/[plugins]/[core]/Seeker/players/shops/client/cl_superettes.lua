LTDItem = {
    {name = 'bread', label = 'Sandwich', price = 50},
    {name = 'water', label = 'Eau de source', price = 50},
    {name = 'radio', label = 'Radio', price = 150},
    {name = 'phone', label = 'Téléphone', price = 150},
}

LTDItemGold = {
    {name = 'cafe', label = 'Café - VIP ~y~Gold', price = 40},
    {name = 'donut', label = 'Donut - VIP ~y~Gold', price = 40},
}

LTDItemDiamond = {
    {name = 'jusleechi', label = 'Jus de Leechi - VIP ~r~Diamond', price = 40},
    {name = 'hotdog', label = 'Hot-dog - VIP ~r~Diamond', price = 40},
}

function OpenMenuLtd()
    local menu = RageUI.CreateMenu("Superette", "Articles disponibles :")

    RageUI.Visible(menu, not RageUI.Visible(menu))

    while menu do
        Wait(0)
        RageUI.IsVisible(menu, function()

        for k,v in pairs(LTDItem) do
            RageUI.Button(v.label, nil, {RightLabel = "~g~".. v.price.."$"}, true, {
                onSelected = function()
                    OpenMenuPaiement(v.name, v.price)
                end
            })
        end
        for k,v in pairs(LTDItemGold) do
            RageUI.Button(v.label, nil, {RightLabel = "~g~".. v.price.."$"}, true, {
                onSelected = function()
                    local vip = GetVIP()
                    if vip ~= 0 then
                        OpenMenuPaiement(v.name, v.price)
                    else
                        ESX.ShowNotification('~r~LystyLife~w~~n~Vous devez être minimum VIP ~y~Gold')
                    end
                end
            })
        end
        for k,v in pairs(LTDItemDiamond) do
            RageUI.Button(v.label, nil, {RightLabel = "~g~".. v.price.."$"}, true, {
                onSelected = function()
                    local vip = GetVIP()
                    if vip == 2 then
                        OpenMenuPaiement(v.name, v.price)
                    else
                        ESX.ShowNotification('~r~LystyLife~w~~n~Vous devez être minimum VIP ~r~Diamond')
                    end
                end
            })
        end
        end, function()
        end)

        if not RageUI.Visible(menu) then
            menu = RMenu:DeleteType('menu', true)
        end
    end
end

function OpenMenuPaiement(item, price)
    local menu = RageUI.CreateMenu("Magasin", "Comment voulez vous payer ?")

    RageUI.Visible(menu, not RageUI.Visible(menu))

    while menu do
        Wait(0)
        RageUI.IsVisible(menu, function()

        RageUI.Button('Payer en Liquide', nil, {}, true, {
            onSelected = function()
                RageUI.CloseAll()
                TriggerServerEvent('core:achat', item, price, 1)
            end
        })
        RageUI.Button('Payer par Carte Bancaire', nil, {}, true, {
            onSelected = function()
                RageUI.CloseAll()
                TriggerServerEvent('core:achat', item, price, 2)
            end
        })

        end, function()
        end)

        if not RageUI.Visible(menu) then
            menu = RMenu:DeleteType('menu', true)
        end
    end
end