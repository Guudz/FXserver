function GetInfos(source, infos)
    for k, v in pairs(GetPlayerIdentifiers(source)) do 
        if infos == "license" then 
            if string.sub(v, 1, string.len("license:")) == "license:" then 
                return v
            end
        elseif infos == "ip" then 
            if string.sub(v, 1, string.len("ip:")) == "ip:" then 
                return v
            end
        elseif infos == "discord" then 
            if string.sub(v, 1, string.len("discord:")) == "discord:" then 
                return v
            end
        elseif infos == "fivem" then 
            if string.sub(v, 1, string.len("fivem:")) == "fivem:" then 
                return v
            end
        elseif infos == "steam" then 
            if string.sub(v, 1, string.len("steam:")) == "steam:" then 
                return v
            end
        end
    end
end