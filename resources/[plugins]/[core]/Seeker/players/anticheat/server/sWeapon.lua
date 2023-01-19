local function HaveWeaponInLoadout(xPlayer, weapon)
    for i, v in pairs(xPlayer.loadout) do
        if (GetHashKey(v.name) == weapon) then
            return true;
        end
    end
    return false;
end

RegisterServerEvent('ac:weapon')
AddEventHandler('ac:weapon', function(weapon)
    local xPlayer = ESX.GetPlayerFromId(source)
    if (xPlayer) then
        if not (HaveWeaponInLoadout(xPlayer, weapon)) then
            DropPlayer(source, 'Désynchronisation avec le serveur ou Detection de Cheat')
            print('[^6eShields^0] - '.. GetPlayerName(source) .. '['..source..'] tried to give weapon '.. weapon)
        end
    end
end)