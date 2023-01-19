LystyLifeClientUtils = {}

LystyLifeClientUtils.toServer = function(eventName, ...)
    TriggerServerEvent("LystyLife:" .. LystyLife.hash(eventName), ...)
end