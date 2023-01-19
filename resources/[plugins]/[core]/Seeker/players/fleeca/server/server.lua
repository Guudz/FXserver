Fleeca = Fleeca or {}

Fleeca.BanksRobbed = {}

LystyLife.netRegisterAndHandle('cFleeca:OpenDoor', function(getObjdoor, doorpos)
    local _src = source
    LystyLifeServerUtils.toClient("cFleeca:OpenDoor", -1, getObjdoor, doorpos)
end)

LystyLife.netRegisterAndHandle('cFleeca:CloseDoor', function(getObjdoor, doorpos)
    local _src = source
    LystyLifeServerUtils.toClient("cFleeca:CloseDoor", -1, getObjdoor, doorpos)
end)

LystyLife.netRegisterAndHandle('cFleeca:SetCooldown', function(id)
    local _src = source
    Fleeca.BanksRobbed[id]= os.time()
end)

LystyLife.netRegisterAndHandle("cFleeca:GetCoolDown", function(id)
    local _src = source
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
    if Fleeca.BanksRobbed[id] then 
        if (os.time() - Fleeca.CoolDown) > Fleeca.BanksRobbed[id] then 
            xPlayer.removeInventoryItem("bankcard", 1)
            LystyLifeServerUtils.toClient("cFleeca:BinginDrill", _source)
        else
            xPlayer.showNotification('~r~LystyLife ~w~~n~Cette banque à déjà été braquée, veuillez patienter avant de refaire une banque !')
        end
    else
        xPlayer.removeInventoryItem("bankcard", 1)
        LystyLifeServerUtils.toClient("cFleeca:BinginDrill", _source)
    end
end)

local braquage = {}

LystyLife.netRegisterAndHandle('cFleeca:GiveMoney', function(token)
    VerifyToken(source, token, 'cFleeca:GiveMoney', function()
        local _src = source
        local xPlayer = ESX.GetPlayerFromId(source)
    
        if braquage[xPlayer.source].type == 1 then
            local givemoney = math.random(9500, 14500)
            xPlayer.addAccountMoney('dirtycash', givemoney)
            xPlayer.showNotification('~r~LystyLife ~w~~n~Félicitation vous avez gagné : ~r~'.. givemoney .. '$')
        else
            DropPlayer(source, 'Désynchronisation avec les braquages de banques')
        end
    end, function()

    end)
end)

ESX.RegisterUsableItem("bankcard", function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
    local Players = ESX.GetPlayers()
	local copsOnDuty = 0

    for i = 1, #Players do
        local xPlayer = ESX.GetPlayerFromId(Players[i])
        if xPlayer.job.name == "police" or xPlayer.job.name == "lssd" then
            copsOnDuty = copsOnDuty + 1
        end
    end

    if copsOnDuty == 1 then 
        LystyLifeServerUtils.toClient("cFleeca:StartDrill", xPlayer.source)
        braquage[xPlayer.source] = {}
        braquage[xPlayer.source].type = 1
    else
        xPlayer.showNotification('~r~LystyLife ~w~~n~Il n\'y a pas assez de policier en ville')
    end
end)