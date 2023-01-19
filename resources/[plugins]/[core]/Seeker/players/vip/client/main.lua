local vipRank = 0

LystyLife.netRegisterAndHandle('LystyLifeVIP:updateVip', function(rank)
    vipRank = rank
end)

LystyLife.newThread(function()
    while not ESXLoaded do
        Wait(1)
    end
    ESX.TriggerServerCallback("LystyLifeVIP:getVip", function(vip) 
        vipRank = vip
    end)
end)

function GetVIP()
    return vipRank
end