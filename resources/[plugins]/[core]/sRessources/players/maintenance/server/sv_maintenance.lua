local Maintenance = false 

local AutorizedToJoin = {
    ["license:530e8f6fcc28a8a26f48f8256964516def1e30de"] = true 
}


AddEventHandler('playerConnecting', function(name, setReason)
    local license = GetInfos(source, "license")
    if Maintenance then 
        if not AutorizedToJoin[license] then 
            print("ban autorié")
        else
            print("Autorisé")
        end

    end
end)





RegisterCommand("testronflex", function(source)
    print(GetInfos(source, "license"))
    print(GetInfos(source, "ip"))
    print(GetInfos(source, "discord"))
    print(GetInfos(source, "fivem"))
    print(GetInfos(source, "steam"))

end)

