local History = {}

function OpenHistoryMenu()
    local BoutiqueSub = RageUI.CreateMenu('', "Que-voulez vous faire ?")
    ESX.TriggerServerCallback('ewen:getHistory', function(result)
        History = result;
    end)
    RageUI.Visible(BoutiqueSub, not RageUI.Visible(BoutiqueSub))
    while BoutiqueSub do
        Citizen.Wait(0)
        RageUI.IsVisible(BoutiqueSub, function()
            for k,v in pairs(History) do 
                if tonumber(v.price) ~= 0 then
                    RageUI.Button(v.transaction .. ' ['..v.points..'] -> LystyLifeCoins', nil, {RightLabel = v.price..'€'}, true, {
                        onSelected = function()
                        end
                    })
                else
                    RageUI.Button(v.transaction, nil, {RightLabel = v.points..' LystyLifeCoins'}, true, {
                        onSelected = function()
                        end
                    })
                end
            end
        end, function()
        end)

        if not RageUI.Visible(BoutiqueSub) then
            OpenBoutique()
            BoutiqueSub = RMenu:DeleteType('BoutiqueSub', true)
        end
    end
end

local HistoryLoaded = false

RegisterNetEvent('ewen:retrieveHistoryClient')
AddEventHandler('ewen:retrieveHistoryClient', function(Table)
    history = Table
    HistoryLoaded = true
    oepnHistoryTebex()
end)

function oepnHistoryTebex()
    local menu = RageUI.CreateMenu('', "Historique du Joueur")
    RageUI.Visible(menu, not RageUI.Visible(menu))
    while menu do
        Citizen.Wait(0)
        RageUI.IsVisible(menu, function()
            for k,v in pairs(history) do
                
                if tonumber(v.price) ~= 0 then
                    RageUI.Button(v.transaction .. ' ['..v.points..'] -> LystyLifeCoins', nil, {RightLabel = v.price..'€'}, true, {
                        onSelected = function()
                        end
                    })
                else
                    RageUI.Button(v.transaction, nil, {RightLabel = v.points..' LystyLifeCoins'}, true, {
                        onSelected = function()
                        end
                    })
                end
            end
        end, function()
        end)

        if not RageUI.Visible(menu) then
            menu = RMenu:DeleteType('menu', true)
        end
    end
end