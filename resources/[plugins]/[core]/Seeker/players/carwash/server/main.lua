LystyLife.netRegisterAndHandle('framework:carwash', function(deposit)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getAccount('bank').money >= 20 then
      xPlayer.removeAccountMoney('bank', 20)
      xPlayer.showNotification('~r~LystyLife ~w~~n~Vous avez néttoyé votre véhicule')
      LystyLifeServerUtils.toClient('framework:cleanvehicle', source)
    else
      xPlayer.showNotification('~r~LystyLife ~w~~n~Vous n\'avez pas suffisement d\'argent')
    end
  end)