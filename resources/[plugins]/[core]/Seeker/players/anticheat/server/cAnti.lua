LystyLife.newThread(function()
	while true do 
		Wait(60000)
		local vehicles = GetAllVehicles()
		for k,v in pairs(vehicles) do
			if GetVehicleBodyHealth(v) <= 0 then
				DeleteEntity(v)
			end
		end
	end
end)