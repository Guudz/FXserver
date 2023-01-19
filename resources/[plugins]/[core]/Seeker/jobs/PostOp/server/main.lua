local InPostOp = {}
local VehiclePostOp = {}

LystyLife.netRegisterAndHandle('StartLivraison', function(arguments, IsNord)
	local xPlayer = ESX.GetPlayerFromId(source)
    if IsNord then
        eUtils.GetDistance(xPlayer.source, vector3(-421.5523, 6137.094, 31.8773), 100, 'StartLivraison', true, function() 
            xPlayer.showNotification("~r~LystyLife~w~~n~Suis l'adresse sur ton GPS avec le camion et livre les colis. (~r~+ ~w~"..arguments.." colis)")
            if not InPostOp[xPlayer.source] then
                InPostOp[xPlayer.source] = {}
                InPostOp[xPlayer.source] = true
            else
                InPostOp[xPlayer.source] = {}
                InPostOp[xPlayer.source] = true
            end
            if not VehiclePostOp[source] then
                VehiclePostOp[source] = {}
                VehiclePostOp[source] = CreateVehicle('boxville4', vector3(-434.0488, 6136.447, 31.478), 222.727, true, false)
            else
                VehiclePostOp[source] = CreateVehicle('boxville4', vector3(-434.0488, 6136.447, 31.478), 222.727, true, false)
            end
            LystyLifeServerUtils.toClient('SetTenueAndPoint-North', xPlayer.source, arguments)
        end, function() 
        end)
    else
        eUtils.GetDistance(xPlayer.source, vector3(-424.3003, -2789.837, 6.529), 100, 'StartLivraison', true, function() 
            xPlayer.showNotification("~r~LystyLife~w~~n~Suis l'adresse sur ton GPS avec le camion et livre les colis. (~r~+ ~w~"..arguments.." colis)")
            if not InPostOp[xPlayer.source] then
                InPostOp[xPlayer.source] = {}
                InPostOp[xPlayer.source] = true
            else
                InPostOp[xPlayer.source] = {}
                InPostOp[xPlayer.source] = true
            end
            if not VehiclePostOp[source] then
                VehiclePostOp[source] = {}
                VehiclePostOp[source] = CreateVehicle('boxville4', vector3(-410.1679, -2791.451, 6.000), 311.327, true, false)
            else
                VehiclePostOp[source] = CreateVehicle('boxville4', vector3(-410.1679, -2791.451, 6.000), 311.327, true, false)
            end
            LystyLifeServerUtils.toClient('SetTenueAndPoint-Sud', xPlayer.source, arguments)
        end, function() 
        end)
    end
end)

LystyLife.netRegisterAndHandle('FinishLivraison', function(arguments)
	local xPlayer = ESX.GetPlayerFromId(source)
    local money = math.random(150,300)
    local Percentage = math .random(1,100)
    if Percentage >= 75 then
        local Pourboire = math.random(75,500)
        xPlayer.showNotification('~r~LystyLife ~w~~n~Félicitation pour ta livraison ~r~+ ~w~'.. money..'$~w~~n~Merci, Tien un petit pouboire ~r~+ ~w~'..Pourboire..'')
        xPlayer.addAccountMoney('cash', money+Pourboire)
    else
        xPlayer.showNotification('~r~LystyLife ~w~~n~Félicitation pour ta livraison ~r~+ ~w~'.. money..'$')
        xPlayer.addAccountMoney('cash', money)
    end
end)

LystyLife.netRegisterAndHandle('PostOpDeleteVeh', function()
    DeleteEntity(VehiclePostOp[source])
end)