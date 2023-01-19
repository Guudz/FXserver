QuaincaillerieItem = {
    {name = 'weapon_hammer', label = 'Marteau', price = 150000},
    {name = 'weapon_crowbar', label = 'Pied de Biche', price = 175000},
    {name = 'weapon_wrench', label = 'Clé Anglaise', price = 200000},
    {name = 'weapon_golfclub', label = 'Club de Golf', price = 225000},
}

function Quancaillerie()
    if GetLevel() >= 5 then
        local menu = RageUI.CreateMenu("Quincaillerie", "Articles disponibles :")

        RageUI.Visible(menu, not RageUI.Visible(menu))

        while menu do
            Wait(0)
            RageUI.IsVisible(menu, function()

            for k,v in pairs(QuaincaillerieItem) do
                RageUI.Button(v.label, nil, {RightLabel = "~g~".. v.price.."$"}, true, {
                    onSelected = function()
                        OpenMenuPaiement(v.name, v.price)
                    end
                })
            end
            end, function()
            end)

            if not RageUI.Visible(menu) then
                menu = RMenu:DeleteType('menu', true)
            end
        end
    else
        ESX.ShowNotification('~r~LystyLife~w~~n~Vous devez être niveau 3 afin d\'acceder à l\'armurerie')
    end
end