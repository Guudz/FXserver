local active = false

LystyLife.netRegisterAndHandle("Core:AfficheBilling", function(sender, amount, society)
    ESX.ShowNotification("~r~Facture\n~s~Vous avez reçu une facture de ~r~"..amount.."$~s~ du ~r~mécanicien ~s~.")
    ESX.ShowNotification("~r~Y~s~ : Accepter\n~r~N~s~ : Refuser")

    local amount = tonumber(amount)
    local time = 0
    active = true

    while active do 
        time = time + 1
        if IsControlJustPressed(0, 246) then -- Accept
            LystyLifeClientUtils.toServer("Core:PayeBilling", "paye", sender, amount, society)
            active = false
            break
        end
        if IsControlJustPressed(0, 306) then -- Decline
            LystyLifeClientUtils.toServer("Core:PayeBilling", "decline", sender, amount, society)
            active = false
            break
        end
        if time == 7000 then -- Time passed
            LystyLifeClientUtils.toServer("Core:PayeBilling", "passed", sender, amount, society)
            active = false
            break
        end
        Wait(1)
    end
end)

RegisterCommand("billing", function(source, args)
    local Montant = args[1]
    LystyLifeClientUtils.toServer("Core:AddBilling", 2, tonumber(Montant), ESX.PlayerData.job.name)
end, false)