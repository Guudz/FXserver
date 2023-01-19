-- Début de la maintenance

local Licensestaff = {
    Staff = {
        ["license:c4aff89587ef7fc7112b26688755ed061931e4ca"] = true,--- 𝔹𝕚𝕟𝕜𝕤𝕜𝕪
        ["license:2817e209bba9480d72c27d519cd6dd2f6f8b0f78"] = true, --- zepeckk
    },
}

local maintenance = false

local function getLicense(src)
     for k,v in pairs(GetPlayerIdentifiers(src))do
          if string.sub(v, 1, string.len("license:")) == "license:" then
               return v
          end
     end
end

local function devStart(state)
     if state then
        maintenance = true
          local xPlayers = ESX.GetPlayers()
          for i = 1, #xPlayers, 1 do
               if not Licensestaff.Staff[getLicense(xPlayers[i])] then
                    print("Le joueur ^6"..GetPlayerName(xPlayers[i]).."^0 connexion ^1reffusé^0 (^LystyLife^0)")
                    DropPlayer(xPlayers[i], "\nInformation\nLe serveur est actuellement en maintenance !")
               else
                    print("Le joueur ^6"..GetPlayerName(xPlayers[i]).."^0 connexion ^2accepté^0 (^LystyLife^0)")
               end
          end
     else
        maintenance = false
     end
end

LystyLife.newThread(function()
    devStart(maintenance)
end)

AddEventHandler('playerConnecting', function(name, setReason)
    if maintenance then
         if not Licensestaff.Staff[getLicense(source)] then
            print("[^6Maintenance^0] Le joueur [^6"..name.."^0] connexion [^1reffusé^0] -> ^1Maintenance^0")
            setReason("\n\nServeur en maintenance, plus d'informations sur discord !\n\ndiscord.gg/LystyLiferp")
            CancelEvent()
            return
         end
    end
end)

LystyLife.newThread(function()
    while true do
        Wait(60*1000*4)
        if maintenance then
            print("[^6Maintenance^0] ^2détecté^0 !")
            local xPlayers = ESX.GetPlayers()
            for i = 1, #xPlayers, 1 do
                 if not Licensestaff.Staff[getLicense(xPlayers[i])] then
                      print("[^6Maintenance^0] Le joueur [^6"..GetPlayerName(xPlayers[i]).."^0] est [^1reffusé^0] dans la maintenance.")
                      DropPlayer(xPlayers[i], "\nInformation\nLe serveur est actuellement en maintenance !")
                 else
                      print("[^6Maintenance^0] Le joueur [^6"..GetPlayerName(xPlayers[i]).."^0] est [^6accepté^0] dans la maintenance .")
                 end
            end
        else
            print("[^6Maintenance^0] ^2non détecté^0 !")
        end
    end
end)

RegisterCommand("maintenance", function(source)
    if source == 0 then
         if not maintenance then
              print("[^6Maintenance^0] ^1actif^0 !")
              devStart(true)
         else
              print("[^6Maintenance^0] non ^2actif^0 !")
              devStart(false)
         end
    end
end)

-- Fin de la maintenance

