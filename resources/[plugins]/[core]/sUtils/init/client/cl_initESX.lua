ESXLoaded = false
ESX = nil
Player = {
    WeaponData = {}
}

RegisterCommand("reload", function()
	LoadESX()
end)

function LoadESX()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end    
    
	ESX.PlayerData = ESX.GetPlayerData()
	Player.WeaponData = ESX.GetWeaponList()

	while ESX.PlayerData == nil do 
		print("player data nil")
		Wait(1)
	end

	for i = 1, #Player.WeaponData, 1 do
		if Player.WeaponData[i].name == 'WEAPON_UNARMED' then
			Player.WeaponData[i] = nil
		else
			Player.WeaponData[i].hash = GetHashKey(Player.WeaponData[i].name)
		end
    end
	Wait(500)
	if ESX.PlayerData.job.grade_name == 'boss' then
        ESX.TriggerServerCallback('esx_society:getSocietyMoney', function(money)
            societymoney = ESX.Math.GroupDigits(money)
        end, ESX.PlayerData.job.name)
    end

    if ESX.PlayerData.job2.grade_name == 'boss' then
        ESX.TriggerServerCallback('esx_society:getSocietyMoney', function(money)
            gangmoney = ESX.Math.GroupDigits(money)
        end, ESX.PlayerData.job2.name)
    end
    ESXLoaded = true
--	ReplaceHudColourWithRgba(255, 255, 241, 47, 85)
    print('ESX Loaded')
end

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	LoadESX()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
	ESX.PlayerData.job.name = ESX.PlayerData.job.name
	ESX.PlayerData.job.label = ESX.PlayerData.job.label
	ESX.PlayerData.job.grade_name = ESX.PlayerData.job.grade_name
end)

RegisterNetEvent('esx:setJob2')
AddEventHandler('esx:setJob2', function(job2)
	ESX.PlayerData.job2 = job2
	ESX.PlayerData.job2.name = ESX.PlayerData.job2.name
	ESX.PlayerData.job2.label = ESX.PlayerData.job2.label
	ESX.PlayerData.job2.grade_name = ESX.PlayerData.job2.grade_name
end)

RegisterNetEvent('esx:setMaxWeight')
AddEventHandler('esx:setMaxWeight', function(newMaxWeight)
	ESX.PlayerData.maxWeight = newMaxWeight
end)

RegisterNetEvent('esx_addonaccount:setMoney')
AddEventHandler('esx_addonaccount:setMoney', function(society, money)
	if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.grade_name == 'boss' and 'society_' .. ESX.PlayerData.job.name == society then
		societymoney = ESX.Math.GroupDigits(money)
	end

	if ESX.PlayerData.job2 ~= nil and ESX.PlayerData.job2.grade_name == 'boss' and 'society_' .. ESX.PlayerData.job2.name == society then
		gangmoney = ESX.Math.GroupDigits(money)
	end
end)



RegisterNetEvent('esx:setAccountMoney')
AddEventHandler('esx:setAccountMoney', function(account)
	for i = 1, #ESX.PlayerData.accounts, 1 do
		if ESX.PlayerData.accounts[i].name == account.name then
			ESX.PlayerData.accounts[i] = account
			break
		end
	end
end)