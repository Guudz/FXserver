RegisterServerEvent('ewen:retraitMoney')
AddEventHandler('ewen:retraitMoney', function(withdraw)
  local xPlayer = ESX.GetPlayerFromId(source)
  local money = tonumber(withdraw)
  if xPlayer.getAccount('bank').money >= money then
    xPlayer.removeAccountMoney('bank', money)
    xPlayer.addAccountMoney('cash', money)
    xPlayer.showNotification('~r~LystyLifeRôleplay ~n~~w~Tu as retiré : ~r~'.. money.. '$')
    sendtoBanque('LystyLife - LOGS', '[BANQUE] \n[' ..GetPlayerName(source).. '] viens de retirer de l\'argent\nCombien : ' ..money.. ' $', 3644644)
  else
    xPlayer.showNotification('~r~LystyLifeRôleplay ~n~~w~Ton solde n\'est pas suffisant !')
  end
end)

RegisterServerEvent('ewen:addMoney')
AddEventHandler('ewen:addMoney', function(deposit)
  local xPlayer = ESX.GetPlayerFromId(source)
  local money = tonumber(deposit)
  if xPlayer.getAccount('cash').money >= money then
    xPlayer.addAccountMoney('bank', money)
    xPlayer.removeAccountMoney('cash', money)
    xPlayer.showNotification('~r~LystyLifeRôleplay ~n~~w~Tu as déposé : ~r~'.. money.. '$')
    sendtoBanque('LystyLife - LOGS', '[BANQUE] \n[' ..GetPlayerName(source).. '] viens de déposer de l\'argent\nCombien : ' ..money.. ' $', 3644644)
  else
    xPlayer.showNotification('~r~LystyLifeRôleplay ~n~~w~Ton solde n\'est pas suffisant !')
  end
end)

function sendtoBanque (name,message,color)
  date_local1 = os.date('%H:%M:%S', os.time())
  local date_local = date_local1
  local DiscordWebHook = "https://discord.com/api/webhooks/914151686312955934/2_aXa1DQoI-jDv4W3KeCBkYHyXjidpmzd6J1hz9ZZq_EWmM5pJci3tyMI0-kGjl4ohgD"
  local embeds = {  
      {

          ["title"] = message,
          ["type"] = "rich",
          ["color"] = color,
          ["footer"] =  {
          ["text"] = "Heure: " ..date_local.. "",
      },
  }
}

  if message == nil or message == '' then return FALSE end
  PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end