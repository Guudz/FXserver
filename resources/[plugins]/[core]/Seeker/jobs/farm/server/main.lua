LystyLife.netRegisterAndHandle('ewen:CreateFarmEntreprise', function(namejob, labeljob, namerecolteitem, labelrecolteitem, PositionRecolte, nametraitementitem, labeltraitementitem, PositionTraitement, PositionVente, PositionCoffreEntreprise)
    local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.getGroup() == 'fondateur' then
        MySQL.Async.execute("INSERT INTO `jobs` (`name`, `label`, `whitelisted`) VALUES (@name, @label, @whitelisted) ", {
            ['@name'] = namejob,
            ['@label'] = labeljob,
            ['@whitelisted'] = 1
        })
        MySQL.Async.execute("INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES (@job_name, @grade, @name, @label, @salary, @skin_male, @skin_female)", {
            ['@job_name'] = namejob,
            ['@grade'] = 2,
            ['@name'] = "boss",
            ['@label'] = "PDG",
            ['@salary'] = 5000,
            ['@skin_male'] = "{}",
            ['@skin_female'] = "{}"
        })
        MySQL.Async.execute("INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES (@job_name, @grade, @name, @label, @salary, @skin_male, @skin_female)", {
            ['@job_name'] = namejob,
            ['@grade'] = 1,
            ['@name'] = "responsable",
            ['@label'] = "Responsable",
            ['@salary'] = 2500,
            ['@skin_male'] = "{}",
            ['@skin_female'] = "{}"
        })
        MySQL.Async.execute("INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES (@job_name, @grade, @name, @label, @salary, @skin_male, @skin_female)", {
            ['@job_name'] = namejob,
            ['@grade'] = 0,
            ['@name'] = "employer",
            ['@label'] = "Employer",
            ['@salary'] = 2500,
            ['@skin_male'] = "{}",
            ['@skin_female'] = "{}"
        })
        MySQL.Async.execute("INSERT INTO `entreprise` (`type`, `name`, `label`, `PosVestiaire`, `PosCustom`, `PosBoss`, `namerecolteitem`, `PosRecolte`, `nametraitementitem`, `PosTraitement`, `PosVente`) VALUES (@type, @name, @label, @PosVestiaire, @PosCustom, @PosBoss, @namerecolteitem, @PosRecolte, @nametraitementitem, @PosTraitement, @PosVente) ", {
            ['@type'] = 'Farm',
            ['@name'] = namejob,
            ['@label'] = labeljob,
            ['@PosVestiaire'] = nil,
            ['@PosCustom'] = nil,
            ['@PosBoss'] = json.encode(PositionCoffreEntreprise),
            ['@namerecolteitem'] = namerecolteitem,
            ['@PosRecolte'] = json.encode(PositionRecolte),
            ['@nametraitementitem'] = nametraitementitem,
            ['@PosTraitement'] = json.encode(PositionTraitement),
            ['@PosVente'] = json.encode(PositionVente)
        })
        MySQL.Async.execute("INSERT INTO `society` (`name`, `money`, `moneysale`, `data`) VALUES (@name, @money, @moneysale, @data) ", {
            ['@name'] = namejob,
            ['@money'] = 0,
            ['@moneysale'] = 0,
            ['@data'] = '[]'
        })
        MySQL.Async.execute("INSERT INTO `items` (`name`, `label`, `weight`) VALUES (@name, @label, @weight) ", {
            ['@name'] = namerecolteitem,
            ['@label'] = labelrecolteitem,
            ['@weight'] = 0
        })
        MySQL.Async.execute("INSERT INTO `items` (`name`, `label`, `weight`) VALUES (@name, @label, @weight) ", {
            ['@name'] = nametraitementitem,
            ['@label'] = labeltraitementitem,
            ['@weight'] = 0
        })
        TriggerClientEvent('esx:showNotification', source, '~r~LystyLife ~w~~n~Le Job à été crée avec succès, Attendez le prochain reboot.')
    end
end)

local EntrepriseFarmList = {}
local ListeItemRecolt = {}
local ListeItemTraitement = {}

Citizen.CreateThread(function()
    MySQL.Async.fetchAll('SELECT * FROM entreprise', {}, function(Entreprise)
        for i=1, #Entreprise, 1 do
            if Entreprise[i].type == 'Farm' then
                EntrepriseFarmList[Entreprise[i].name] = {}
                EntrepriseFarmList[Entreprise[i].name].type = Entreprise[i].type 
                EntrepriseFarmList[Entreprise[i].name].name = Entreprise[i].name
                EntrepriseFarmList[Entreprise[i].name].label = Entreprise[i].label
                EntrepriseFarmList[Entreprise[i].name].PosBoss = json.decode(Entreprise[i].PosBoss)
                EntrepriseFarmList[Entreprise[i].name].RecolteItem = Entreprise[i].namerecolteitem
                EntrepriseFarmList[Entreprise[i].name].PosRecolte = json.decode(Entreprise[i].PosRecolte)
                EntrepriseFarmList[Entreprise[i].name].TraitementItem = Entreprise[i].nametraitementitem
                EntrepriseFarmList[Entreprise[i].name].PosTraitement = json.decode(Entreprise[i].PosTraitement)
                EntrepriseFarmList[Entreprise[i].name].PosVente = json.decode(Entreprise[i].PosVente)

                -- SECURISATION RECOLTE
                ListeItemRecolt[Entreprise[i].namerecolteitem] = {}
                ListeItemRecolt[Entreprise[i].namerecolteitem].name = Entreprise[i].namerecolteitem
                -- SECURISATION TRAITEMENT
                ListeItemTraitement[Entreprise[i].nametraitementitem] = {}
                ListeItemTraitement[Entreprise[i].nametraitementitem].name = Entreprise[i].nametraitementitem
                print('[^5LOAD^0] L\'entreprise [^5'..Entreprise[i].name..'^0] à été load avec succès')
                print('[^5LOAD^0] L\'item [^5'..Entreprise[i].namerecolteitem..'^0] à été ajouté dans la Whitelist [^6ENTREPRISE-FARM^0]')
                print('[^5LOAD^0] L\'item [^5'..Entreprise[i].nametraitementitem..'^0] à été ajouté dans la Whitelist [^6ENTREPRISE-FARM^0]')
            end
        end
    end)
end)

LystyLife.netRegisterAndHandle('ewen:initFarmSociety', function()
    LystyLifeServerUtils.toClient('ewen:SendEntrepriseFarmList', source, EntrepriseFarmList)
end)

local Players = {}

local function Activity(source, itemRecolte, type, ItemTraitement, society)
	if Players[source] then
		local xPlayer  = ESX.GetPlayerFromId(source)
		if type == 1 then -- Recolte
			if ListeItemRecolt[itemRecolte] == nil then
				DropPlayer(source, 'Désynchronisation avec les Entreprises de farm')
			else
				if ListeItemRecolt[itemRecolte].name == itemRecolte then
					local Quantity = xPlayer.getInventoryItem(itemRecolte).count
					if Quantity >= 70 then
						xPlayer.showNotification('~r~Erreur ~w~~n~Vous êtes trop lourd pour faire ceci')
					else
						LystyLifeServerUtils.toClient('framework:farmanimation', source)
						Citizen.Wait(1500)
						xPlayer.addInventoryItem(itemRecolte, 1)
						Activity(source, itemRecolte, type, ItemTraitement, society)
					end
				else
					DropPlayer(source, 'Désynchronisation avec les Entreprises de farm')
				end
			end
		elseif type == 2 then -- Traitement
			if ListeItemRecolt[itemRecolte] == nil or ListeItemTraitement[ItemTraitement] == nil then
				DropPlayer(source, 'Désynchronisation avec les Entreprises de farm')
			else
				if ListeItemRecolt[itemRecolte] == itemRecolte or ListeItemTraitement[itemTraitement] == itemTraitement then
					local Quantity = xPlayer.getInventoryItem(itemRecolte).count
					local Quantity2 = xPlayer.getInventoryItem(ItemTraitement).count
					if Quantity <= 0 then
						xPlayer.showNotification('~r~Erreur ~w~~n~Vous n\'avez rien à traiter')
					elseif Quantity2 >= 70 then
						xPlayer.showNotification('~r~Erreur ~w~~n~Vous êtes trop lourd pour faire ceci')
					else					
						LystyLifeServerUtils.toClient('framework:farmanimation', source)
						Citizen.Wait(1500)
						xPlayer.removeInventoryItem(itemRecolte, 1)
						xPlayer.addInventoryItem(ItemTraitement, 1)
						Activity(source, itemRecolte, type, ItemTraitement, society)
					end
				else
					DropPlayer(source, 'Désynchronisation avec les Entreprises de farm')
				end
			end
		elseif type == 3 then -- Vente
			if ListeItemTraitement[ItemTraitement] == nil then
				DropPlayer(source, 'Désynchronisation avec les Entreprises de farm')
			else
				if ListeItemTraitement[itemTraitement] == itemTraitement then
					local Quantity = xPlayer.getInventoryItem(ItemTraitement).count
					if Quantity <= 0 then
						xPlayer.showNotification('~r~Erreur ~w~~n~Vous n\'avez rien à traiter')
					else					
						LystyLifeServerUtils.toClient('framework:farmanimation', source)
						Citizen.Wait(1500)
						xPlayer.removeInventoryItem(ItemTraitement, 1)
						SocietyCache[society].money = SocietyCache[society].money + 500
						Activity(source, itemRecolte, type, ItemTraitement, society)
					end
				else
					DropPlayer(source, 'Désynchronisation avec les Entreprises de farm')
				end
			end
		else
            DropPlayer(source, 'Désynchronisation avec les Entreprises de farm')
		end
	end
end

LystyLife.netRegisterAndHandle('framework:startActivity', function(position, itemRecolte, type, ItemTraitement, society)
	if #(GetEntityCoords(GetPlayerPed(source)) - vector3(position.x, position.y, position.z)) < 100 then
		Players[source] = true
		Activity(source, itemRecolte, type, ItemTraitement, society)
	else
		DropPlayer(source, 'Désynchronisation avec le serveur ou detection de Cheat')
	end
end)

LystyLife.netRegisterAndHandle('framework:stopActivity', function()
	Players[source] = false
end)

RegisterCommand('createentreprise', function(source,args)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.getGroup() == 'fondateur' then
		LystyLifeServerUtils.toClient('ewen:createEntreprise', source)
	end
end)