AddEventHandler('rconCommand', function(commandName, args)
    if commandName == 'setlevel' then
        if (tonumber(args[1]) ~= nil and tonumber(args[1]) >= 0) and (tonumber(args[2]) ~= nil and tonumber(args[2]) >= 0) then
            local xPlayer = ESX.GetPlayerFromId(tonumber(args[1]))

            if xPlayer == nil then
                RconPrint("Player not ingame\n")
                CancelEvent()
                return
            end

            TriggerEvent('esx:customDiscordLog', "CONSOLE a modifié le niveau de permission de " .. xPlayer.name .. " [" .. xPlayer.source .. "] (" .. xPlayer.identifier .. ") - Ancien : " .. xPlayer.getLevel() .. " / Nouveau : " .. tostring(args[2]))
            xPlayer.setLevel(tonumber(args[2]))
        else
            RconPrint("Usage: setlevel [user-id] [level]\n")
            CancelEvent()
            return
        end

        CancelEvent()
    elseif commandName == 'setgroup' then
        if (tonumber(args[1]) ~= nil and tonumber(args[1]) >= 0) and (tostring(args[2]) ~= nil) then
            local xPlayer = ESX.GetPlayerFromId(tonumber(args[1]))

            if xPlayer == nil then
                RconPrint("Player not ingame\n")
                CancelEvent()
                return
            end

            TriggerEvent('esx:customDiscordLog', "CONSOLE a modifié le groupe de permission de " .. xPlayer.name .. " [" .. xPlayer.source .. "] (" .. xPlayer.identifier .. ") - Ancien : " .. xPlayer.getGroup() .. " / Nouveau : " .. tostring(args[2]))
            xPlayer.setGroup(tostring(args[2]))
        else
            RconPrint("Usage: setgroup [user-id] [group]\n")
            CancelEvent()
            return
        end

        CancelEvent()
    end
end)

ESX.AddGroupCommand('announce', "superadmin", function(source, args, user)
	TriggerClientEvent('chatMessage', -1, "ANNONCE", {255, 0, 0}, table.concat(args, " "))
end, {help = "Announce a message to the entire server", params = { {name = "announcement", help = "The message to announce"} }})

ESX.AddGroupCommand('kick', "admin", function(source, args, user)
    if args[1] then
        if GetPlayerName(tonumber(args[1])) then
            local target = tonumber(args[1])
            local reason = args
            table.remove(reason, 1)

            if #reason == 0 then
                reason = "[ 📡 LystyLife-Kick : ]"
            else
                reason = "[ 📡 LystyLife-Kick : "..table.concat(reason).."]"
            end

            TriggerClientEvent('chatMessage', source, "SYSTEME", {255, 0, 0}, "Player ^2" .. GetPlayerName(target) .. "^0 has been kicked (^2" .. reason .. "^0)")
            DropPlayer(target, reason)
        else
            TriggerClientEvent('chatMessage', source, "SYSTEME", {255, 0, 0}, "Incorrect player ID!")
        end
    else
        TriggerClientEvent('chatMessage', source, "SYSTEME", {255, 0, 0}, "Incorrect player ID!")
    end
end, {help = "La raison du kick", params = { {name = "userid", help = "The ID of the player"}, {name = "reason", help = "The reason as to why you kick this player"} }})