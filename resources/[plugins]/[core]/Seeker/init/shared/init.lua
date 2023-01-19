LystyLife = {}
LystyLife.newThread = Citizen.CreateThread
LystyLife.newWaitingThread = Citizen.SetTimeout
--Citizen.CreateThread, CreateThread, Citizen.SetTimeout, SetTimeout, InvokeNative = nil, nil, nil, nil, nil

Job = nil
Jobs = {}
Jobs.list = {}

LystyLifePrefixes = {
    zones = "^1ZONE",
    err = "^1ERREUR",
    blips = "^1BLIPS",
    npcs = "^1NPCS",
    dev = "^6INFOS",
    sync = "^6SYNC",
    jobs = "^6JOBS",
    succes = "^2SUCCÈS"
}

LystyLife.hash = function(notHashedModel)
    return GetHashKey(notHashedModel)
end

LystyLife.prefix = function(title, message)
    return ("[^5LystyLife^0] (%s^0) %s" .. "^0"):format(title, message)
end

local registredEvents = {}
local function isEventRegistred(eventName)
    for k,v in pairs(registredEvents) do
        if v == eventName then return true end
    end
    return false
end

LystyLife.netRegisterAndHandle = function(eventName, handler)
    print('REGISTER DE l\'EVENT '..eventName)
    local event = "LystyLife:" .. LystyLife.hash(eventName)
    if not isEventRegistred(event) then
        RegisterNetEvent(event)
        table.insert(registredEvents, event)
    end
    AddEventHandler(event, handler)
end


LystyLife.netRegister = function(eventName)
    local event = "LystyLife:" .. LystyLife.hash(eventName)
    RegisterNetEvent(event)
end


LystyLife.netHandle = function(eventName, handler)
    local event = "LystyLife:" .. LystyLife.hash(eventName)
    AddEventHandler(event, handler)
end


LystyLife.netHandleBasic = function(eventName, handler)
    AddEventHandler(eventName, handler)
end

LystyLife.second = function(from)
    return from*1000
end

LystyLife.toInternal = function(eventName, ...)
    TriggerEvent("LystyLife:" .. LystyLife.hash(eventName), ...)
end