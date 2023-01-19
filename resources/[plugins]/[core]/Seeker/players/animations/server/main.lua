LystyLife.netRegisterAndHandle("ServerEmoteRequest", function(target, emoteanim, emotename)
	LystyLifeServerUtils.toClient("ClientEmoteRequestReceive", target, emoteanim, emotename)
end)

LystyLife.netRegisterAndHandle("ServerValidEmote", function(target, requestedemote)
	LystyLifeServerUtils.toClient("SyncPlayEmote", source, requestedemote, true)
	LystyLifeServerUtils.toClient("SyncPlayEmote", target, requestedemote, false)
end)