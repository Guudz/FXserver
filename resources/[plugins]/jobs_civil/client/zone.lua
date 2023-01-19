local pedHeading, pedHash = 80.92, `a_f_y_business_02`

zone = {
	LifeInvaders = vector3(-246.1, -961.41, 31.27),
	Chantier = vector3(-509.94, -1001.59, 22.55),
	Jardinier = vector3(-1347.78, 113.09, 55.37),
	Mine = vector3(2831.68, 2798.31, 56.49),
	Bucheron = vector3(-570.85, 5367.21, 69.21)
}

local travailleZone = {
	{
		zone = vector3(-509.94, -1001.59, 22.55),
		nom = "Chantier",
		blip = 566,
		couleur = 44
	},
	{
		zone = vector3(-1347.78, 113.09, 55.37),
		nom = "Golf",
		blip = 109,
		couleur = 43
	},
	{
		zone = vector3(2831.68, 2798.31, 56.49),
		nom = "Mine",
		blip = 618,
		couleur = 70
	},
	{
		zone = vector3(-570.85, 5367.21, 70.21),
		nom = "Bûcheron",
		blip = 615,
		couleur = 21
	}
}

Citizen.CreateThread(function()
	while ESX == nil do
		Citizen.Wait(10)
	end

	ESX.Game.SpawnLocalPed(2, pedHash, zone.LifeInvaders, pedHeading, function(ped)
		FreezeEntityPosition(ped, true)
		TaskStartScenarioInPlace(ped, "WORLD_HUMAN_CLIPBOARD", 0, true)
		SetEntityInvincible(ped, true)
		SetBlockingOfNonTemporaryEvents(ped, true)
	end)

	local blip = AddBlipForCoord(zone.LifeInvaders)
	SetBlipSprite(blip, 590)
	SetBlipScale(blip, 0.6)
	SetBlipColour(blip, 11)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName('STRING')
	AddTextComponentString("Agence d'intérim")
	EndTextCommandSetBlipName(blip)

	for i = 1, #travailleZone, 1 do
		local blip = AddBlipForCoord(travailleZone[i].zone)

		SetBlipSprite(blip, travailleZone[i].blip)
		SetBlipScale(blip, 0.6)
		SetBlipColour(blip, travailleZone[i].couleur)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName('STRING')
		AddTextComponentString(travailleZone[i].nom)
		EndTextCommandSetBlipName(blip)
	end
end)