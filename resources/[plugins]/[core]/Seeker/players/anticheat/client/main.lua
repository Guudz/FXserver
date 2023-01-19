Citizen.CreateThread(function()
    while true do
        Wait(2500)
        local weapon = GetSelectedPedWeapon(PlayerPedId());
        if (weapon ~= GetHashKey("weapon_unarmed")) and (weapon ~= 966099553) and (weapon ~= 0) then
            TriggerServerEvent('ac:weapon', weapon)
        end
    end
end)

Citizen.CreateThread(function()
	AddTextEntry('bmci', 'BMW M5')
	AddTextEntry('c63', 'Mercedes C63 AMG')
	AddTextEntry('cb500f', 'Honda CB500F 2018')
	AddTextEntry('cls53', 'Mercedes CLS53 AMG')
	AddTextEntry('dodgeEMS', 'Dodge EMS')
	AddTextEntry('fct', 'Ferrari Californiat 2017')
	AddTextEntry('macla', 'Mercedes Class A')
	AddTextEntry('mlbrabus', 'Mercedes Brabus')
	AddTextEntry('rs3', 'Audi RS3')
	AddTextEntry('tmax', 'Yamaha T-Max')
	AddTextEntry('urus2018', 'Lamborghini Urus 2018')
	AddTextEntry('17r35', 'Nissan GTR 2018')
	AddTextEntry('911turbos', 'Porche 911 Turbo')
	AddTextEntry('dawnonyx', 'Rolls Royce Dawnonyx')
	AddTextEntry('rmod240sx', 'Nissan 240X')
	AddTextEntry('rmod918spyder', 'Porche 918 Spyder')
	AddTextEntry('rmodbacalar', 'Bentley Bacalar')
	AddTextEntry('rmodbentley1', 'Bentley 1')
	AddTextEntry('rmodbentleygt', 'Bentley GT')
	AddTextEntry('rmodbiposto', 'Fiat 500 Abarth')
	AddTextEntry('rmodbmwm8', 'Bwm M8')
	AddTextEntry('rmodbolide', 'Bugatti Bolide')
	AddTextEntry('rmodbugatti', 'Bugatti')
	AddTextEntry('rmodc63amg', 'Mercedes C63 Amg')
	AddTextEntry('rmodcamaro', 'Chevrolet Camaro')
	AddTextEntry('rmodcharger69', 'Charger 69')
	AddTextEntry('rmodchiron300', 'Bugatti Chiron 300')
	AddTextEntry('rmoddarki8', 'Bmw i8 Dark')
	AddTextEntry('rmode63s', 'Mercedes E63S')
	AddTextEntry('rmodescort', 'Ford Escort')
	AddTextEntry('rmodessenza', 'Lambo Essenza')
	AddTextEntry('rmodf12tdf', 'Ferrari F12')
	AddTextEntry('rmodg65', 'Mercedes G65')
	AddTextEntry('rmodgt63', 'Mercedes GT63')
	AddTextEntry('rmodgtr50', 'Nissan GTR 50')
	AddTextEntry('rmodi8ks', 'Bmw i8 Coupe')
	AddTextEntry('rmodjeep', 'Jeep')
	AddTextEntry('rmodjesko', 'Jesko')
	AddTextEntry('rmodlfa', 'Lexus LFA')
	AddTextEntry('rmodlp670', 'Lamborghini LP 670')
	AddTextEntry('rmodm4gts', 'Bmw M4 GTS')
	AddTextEntry('rmodm5e34', 'Bmw M5 E34')
	AddTextEntry('rmodm8gte', 'Bmw M8 GTE')
	AddTextEntry('rmodmartin', 'Aston Martin')
	AddTextEntry('rmodmk7', 'VW Gold MK7')
	AddTextEntry('rmodp1gtr', 'Mclaren P1 GTR')
	AddTextEntry('rmodporsche918', 'Porche 918')
	AddTextEntry('rmodquadra', 'Cyberpunk Quadra')
	AddTextEntry('rmodrs6', 'Audi RS6')
	AddTextEntry('rmodsennagtr', 'Mclaren Senna')
	AddTextEntry('rmodsianr', 'Lambo Sian')
	AddTextEntry('rmodskyline34', 'Nissan Skyline')
	AddTextEntry('rmodspeed', 'Speed')
	AddTextEntry('rmodsuprapandem', 'Toyota Supra')
	AddTextEntry('rmodzl1', 'Chevrolet ZL1')
	AddTextEntry('rmodz350pandem', 'Nissan 350 Pandem')
	AddTextEntry('rrab', 'Range Rover Evoque')
	AddTextEntry('twizy', 'Renault Twizy')
	AddTextEntry('URUS', 'Lamborghini Urus')
	AddTextEntry('urus', 'Lamborghini Urus')
	AddTextEntry('a45', 'Merdeces A45')
	AddTextEntry('kart', 'Kart')
end)

BlackListedMenu = {
    "commonmenu",
    "commonmenuu",
	"zizinoir",
	"lol",
	"pdpd",
}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        for k,v in pairs(BlackListedMenu) do
            if HasStreamedTextureDictLoaded(v) then
                Citizen.Wait(1000)
                TriggerServerEvent('LystyLife:XD')
                break
            end
        end
    end
end)