ShopIllegaltem = {
    {name = 'basic_cuff', label = 'Menotte Basique', price = 15000},
    {name = 'basic_key', label = 'Clé Menotte Basique', price = 15000},
    {name = 'piluleoubli', label = 'Pillule D\'Oublie', price = 10000},
    {name = 'bankcard', label = 'Clé USB ( Braquage )', price = 25000},
    {name = 'drill', label = 'Perceuse ( Braquage )', price = 25000},
}

function OpenMenuIllegal()
    local menu = RageUI.CreateMenu("Illegal", "Articles disponibles :")

    RageUI.Visible(menu, not RageUI.Visible(menu))

    while menu do
            Wait(0)
            RageUI.IsVisible(menu, function()

            for k,v in pairs(ShopIllegaltem) do
                RageUI.Button(v.label, nil, {RightLabel = "~g~".. v.price.."$"}, true, {
                    onSelected = function()
                        OpenMenuPaiement3(v.name, v.price)
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

function OpenMenuPaiement3(item, price)
    local menu = RageUI.CreateMenu("Magasin", "Comment voulez vous payer ?")

    RageUI.Visible(menu, not RageUI.Visible(menu))

    while menu do
        Wait(0)
        RageUI.IsVisible(menu, function()

        RageUI.Button('Payer en Liquide', nil, {}, true, {
            onSelected = function()
                RageUI.CloseAll()
                TriggerServerEvent('core:achat', item, price, 1)
                ExecuteCommand("me viens d'acheter un objet dans le marchand illégal")
            end
        })
        RageUI.Button('Payer en Argent Sale', nil, {}, true, {
            onSelected = function()
                RageUI.CloseAll()
                TriggerServerEvent('core:achat', item, price, 3)
                ExecuteCommand("me viens d'acheter un objet dans le marchand illégal")
            end
        })

        end, function()
        end)

        if not RageUI.Visible(menu) then
            menu = RMenu:DeleteType('menu', true)
        end
    end
end