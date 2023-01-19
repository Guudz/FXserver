local Billing = {
    PlayerEffectuedBilling = {},
    Notification = function(id, str)
        TriggerClientEvent('esx:showNotification', id, str)
    end
}

LystyLife.netRegisterAndHandle("Core:AddBilling", function(target, amount, society)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    
    if xPlayer.job.name ~= "unemployed" then
        if target and amount then 
            LystyLifeServerUtils.toClient("Core:AfficheBilling", target, _source, amount, society)
            table.insert(Billing.PlayerEffectuedBilling, _source)
            Billing.Notification(_source, "~r~Facture~s~\nFacture envoyé avec succés.")
        else 
            Billing.Notification(_source, "~r~Facture~s~\nUne erreur c'est produite.")
        end
    else 
        DropPlayer(_source, "Tentative de cheat. (Facture mécano)")
    end
end)

LystyLife.netRegisterAndHandle("Core:PayeBilling", function(type, sender, amount, society)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xMoney = xPlayer.getAccount('cash')
    local EffectuedPassedBilling = false

    for k,v in pairs(Billing.PlayerEffectuedBilling) do 
        if v == sender then 
            EffectuedPassedBilling = true 
            table.remove(Billing.PlayerEffectuedBilling, k)
        end
    end
    
    if EffectuedPassedBilling then
        if type == "paye" then
            if xMoney.money >= amount then 
                xPlayer.removeAccountMoney('cash', amount)
                if society and SocietyCache[society] then
                    SocietyCache[society].money = SocietyCache[society].money + amount
                    print("[^6INFORMATION^7] (^6ID:"..source.."^7) a ajouter de l'argent (^6SOMMES:"..amount.."$^7) dans une societer (^6SOCIETY:"..society.."^7)")
                else 
                    if society then 
                        print("[^1ERREUR^7] (^6ID:"..source.."^7) a tenter de mettre de l'argent (^6SOMMES:"..amount.."$^7) dans une societer non existante (^6SOCIETY:"..society.."^7)")
                    end
                end
                Billing.Notification(source, "Facture\n~r~Vous avez payer "..amount.."$")
                Billing.Notification(sender, "Facture\n~r~Vous avez reçu "..amount.."$")
            else
                Billing.Notification(source, "Facture\n~r~Vous n'avez pas assez d'argent")
                Billing.Notification(sender, "Facutre\n~r~Le joueur n'a pas assez d'argent")
            end
        elseif type == "decline" then 
            Billing.Notification(source, "Facture\n~r~Vous avez refuser la facture")
            Billing.Notification(sender, "Facutre\n~r~Le joueur a refuser")
        elseif type == "passed" then 
            Billing.Notification(source, "Facture\n~r~Vous avez mis trop de temps à régler cette facture.")
            Billing.Notification(sender, "Facutre\n~r~Le joueur a mis trop de temps à régler cette facture")
        end
    else 
        DropPlayer(_source, "Tentative de cheat. (Payer facture)")
    end
end)