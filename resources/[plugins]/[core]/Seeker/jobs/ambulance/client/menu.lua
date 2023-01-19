local EntrepriseMecanoList = {}
local EntrepriseLoad = false

LystyLife.netRegisterAndHandle('ewen:receiveMecano', function(Table)
    EntrepriseMecanoList = Table
    EntrepriseLoad = true
end)

RegisterCommand("f6", function()
    for k,v in pairs(EntrepriseMecanoList) do
        LystyLife.EntrepriseMecanoList = v
        if not ESX.PlayerData.job.name == 'ambulance' then 
            return
        elseif not ESX.PlayerData.job.name == LystyLife.EntrepriseMecanoList.name then
            return
        elseif ESX.PlayerData.job.name == LystyLife.EntrepriseMecanoList.name then
            LystyLife.Mecano.openMecano()
        elseif ESX.PlayerData.job.name == 'ambulance' then
            if IsInServiceEMS then
                LystyLife.Ambulance.OpenAmbulanceMenu()
            else
                ESX.ShowNotification('~r~LystyLife~w~~n~Vous n\'êtes pas en service')
            end
        end
    end
end, false)
RegisterKeyMapping('f6', 'Menu Entreprise', 'keyboard', 'F6')

RegisterCommand("interactionems", function()

    if not ESX.PlayerData.job.name == 'ambulance' then 
        return

    else
            if IsInServiceEMS then
                OpenReportListEms()
            else
                ESX.ShowNotification('~r~LystyLife~w~~n~Vous n\'êtes pas en service')
            end
        end
end, false)
RegisterKeyMapping('interactionems', 'Menu Appels EMS', 'keyboard', 'F7')
