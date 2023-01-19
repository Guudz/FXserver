local AfkTime = {}

RegisterNetEvent("requteInvestTime", function()
    local xPlayer = ESX.GetPlayerFromId(source)
    MySQL.Async.fetchAll('SELECT * FROM `modern_invest` WHERE `license` = @license', {
        ['@license'] = xPlayer.identifier
    }, function(result)
        if result[1] then
            if not AfkTime[xPlayer.source] then
                AfkTime[xPlayer.source] = {}
                AfkTime[xPlayer.source].time = result[1].time
                AfkTime[xPlayer.source].type = result[1].type
                TriggerClientEvent("requestClientAfkTime", xPlayer.source, AfkTime[xPlayer.source].time)
                if #(GetEntityCoords(GetPlayerPed(xPlayer.source)) - vector3(482.998, 4812.112, -58.384)) < 150 then
                    trace('Le joueur ^2'..GetPlayerName(xPlayer.source)..' avait déconnecter en Invest.', 'Investissement')
                    SetEntityCoords(GetPlayerPed(xPlayer.source), vector3(239.6025, -763.1501, 30.826))
                    xPlayer.showNotification('~r~LystyLife~w~~n~Vous avez déconnecter dans la Zone Investissement.')
                end
                xPlayer.showNotification('~r~LystyLife ~w~~n~Vous avez un investissement en cours.\nIl vous reste ~r~'..result[1].time..' ~w~minutes pour le finir.')
            end
        else
            AfkTime[xPlayer.source] = {}
            AfkTime[xPlayer.source].time = 0
            AfkTime[xPlayer.source].type = 0
            eUtils.GetDistance(xPlayer.source, vector3(482.998, 4812.112, -58.384), 100, 'requteInvestTime', false, function()
               xPlayer.showNotification('~r~LystyLife ~w~~n~Vous êtes dans la zone Investissement alors que vous n\'avez pas d\'investissement.')
               SetEntityCoords(GetPlayerPed(xPlayer.source), vector3(239.6025, -763.1501, 30.826))
            end, function()
                
            end)
        end
    end)
end)

local InvestReward = {
    [1] = {reward = 15000, invest = 0, heures = 1},
    [2] = {reward = 45000, invest = 15000, heures = 2},
    [3] = {reward = 95000, invest = 45000, heures = 4},
    [4] = {reward = 200000, invest = 95000, heures = 8},
    [5] = {reward = 425000, invest = 200000, heures = 12},
    [6] = {reward = 875000, invest = 425000, heures = 24},
    [7] = {reward = 1750000, invest = 875000, heures = 48},
}

RegisterNetEvent("GoInvest", function(type)
    local xPlayer = ESX.GetPlayerFromId(source)
    local time = InvestReward[type].heures 
    
    if xPlayer.getAccount('cash').money >= InvestReward[type].invest then 
        xPlayer.removeAccountMoney('cash', InvestReward[type].invest)
        AfkTime[xPlayer.source].time = InvestReward[type].heures*60
        AfkTime[xPlayer.source].type = type
        SetEntityCoords(GetPlayerPed(xPlayer.source), vector3(482.998, 4812.112, -58.384))
        TriggerClientEvent("requestClientAfkTime", xPlayer.source, AfkTime[xPlayer.source].time)
        xPlayer.showNotification('~r~LystyLife ~w~~n~Tu as lancer un investissement pour gagner ~r~'..InvestReward[type].reward..' ~w~pour ~r~'..InvestReward[type].heures..' ~w~heurs')
    elseif xPlayer.getAccount('bank').money >= InvestReward[type].invest then
        xPlayer.removeAccountMoney('bank', InvestReward[type].invest)
        AfkTime[xPlayer.source].time = InvestReward[type].heures*60
        AfkTime[xPlayer.source].type = type
        SetEntityCoords(GetPlayerPed(xPlayer.source), vector3(482.998, 4812.112, -58.384))
        TriggerClientEvent("requestClientAfkTime", xPlayer.source, AfkTime[xPlayer.source].time)
        xPlayer.showNotification('~r~LystyLife ~w~~n~Tu as lancer un investissement pour gagner ~r~'..InvestReward[type].reward..' ~w~pour ~r~'..InvestReward[type].heures..' ~w~heurs')
    else
        xPlayer.showNotification('~r~LystyLife ~w~~n~Vous n\'avez pas l\'argent nécéssaire')
    end
end)

RegisterNetEvent("UpdateAfkTick", function(NewAfkTime)
    local xPlayer = ESX.GetPlayerFromId(source)
    if AfkTime[xPlayer.source].time-1 == NewAfkTime then
        AfkTime[xPlayer.source].time = NewAfkTime
        ExecuteCommand('heal '..source)
        if AfkTime[xPlayer.source].time == 0 then
            xPlayer.showNotification('~r~LystyLife ~w~~n~Vous avez terminé votre investissement félication !\nVous avez gagner ~r~'..InvestReward[AfkTime[xPlayer.source].type].reward..'~w~$\n~r~/invest ~w~pour relancer un investissement')
            xPlayer.addAccountMoney('cash', InvestReward[AfkTime[xPlayer.source].type].reward)
            MySQL.Async.execute('DELETE FROM modern_invest WHERE `license` = @license', {
                ['@license'] = xPlayer.identifier
            })
            AfkTime[xPlayer.source] = {}
            TriggerClientEvent("requestClientAfkTime", xPlayer.source, 0)
            SetEntityCoords(GetPlayerPed(xPlayer.source), vector3(239.6025, -763.1501, 30.826))
        end
    else
        DropPlayer(source, 'Désynchronisation avec le serveur ou detection de Cheat')
    end
end)

AddEventHandler('playerDropped', function (reason)
    local xPlayer = ESX.GetPlayerFromId(source)
    if (xPlayer) then
        if AfkTime[xPlayer.source] ~= nil then
            if AfkTime[xPlayer.source].time >= 1 then
                MySQL.Async.fetchAll('SELECT * FROM `modern_invest` WHERE `license` = @license', {
                    ['@license'] = xPlayer.identifier
                }, function(result)
                    if result[1] then
                        MySQL.Async.execute('UPDATE modern_invest SET time = @time, type = @type WHERE license = @license',{
                            ['@license'] = xPlayer.identifier,
                            ['@time'] = AfkTime[xPlayer.source].time,
                            ['@type'] = AfkTime[xPlayer.source].type,
                        })
                    else
                        MySQL.Async.execute('INSERT INTO modern_invest (license, time, type) VALUES (@license, @time, @type)', {
                            ['@license'] = xPlayer.identifier,
                            ['@time'] = AfkTime[xPlayer.source].time,
                            ['@type'] = AfkTime[xPlayer.source].type,
                        }, function()
                        end)
                    end
                end)
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Wait(60000*90)
        TriggerClientEvent('esx:showAdvancedNotification', -1, 'LystyLife', '~r~Investissement', 'Investis ton argent en restant AFK !\nVia la commande ~r~Invest\n~w~Bon jeu a vous sur ~r~LystyLife ~w~!', 'CHAR_LystyLife', 7)
    end
end)