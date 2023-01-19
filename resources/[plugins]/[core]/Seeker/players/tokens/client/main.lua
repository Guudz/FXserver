token = nil

RegisterNetEvent('LystyLife:RetrieveToken')
AddEventHandler('LystyLife:RetrieveToken', function(TokenReceive)
    token = TokenReceive
end)

RegisterNetEvent('eToken:esx:vehiclespawndelete')
AddEventHandler('eToken:esx:vehiclespawndelete', function(vehicle, token)
    DeleteEntity(vehicle)
end)