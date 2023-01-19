Map = {
    {name="Banque Centrale",color=53, id=475,ZoneBlip = false, Position = vector3(230.476, 214.235, 105.547)},
    {name="~r~Activité ~s~ | FightClub",color=1, id=311,ZoneBlip = false, Position = vector3(-294.97158813477,-1992.6604003906,30.966026306152)},
    -- Chantier
    {name="~r~Activité Farm ~s~ | Récolte d'acier",color=36, id=237,ZoneBlip = false, Position = vector3(99.9797134399414, -385.5039367675781, 41.35879516601562)},
    {name="~r~Activité Farm ~s~ | Traitement d'acier",color=36, id=237,ZoneBlip = false, Position = vector3(985.1104125976563, -1921.376220703125, 31.13475227355957)},
    {name="~r~Activité Farm ~s~ | Vente d'acier",color=36, id=237,ZoneBlip = false, Position = vector3(1189.1917724609,-3106.4943847656,5.6027612686157)},
    -- Fleeca
    {name="Braquage de Fleeca-Bank",color=49, id=156,ZoneBlip = false, Position = vector3(149.694, -1040.757, 29.374)},
    {name="Braquage de Fleeca-Bank",color=49, id=156,ZoneBlip = false, Position = vector3(313.969, -279.032, 54.1708)},
    {name="Braquage de Fleeca-Bank",color=49, id=156,ZoneBlip = false, Position = vector3(-1212.751, -330.773, 37.787)},
    {name="Braquage de Fleeca-Bank",color=49, id=156,ZoneBlip = false, Position = vector3(-2962.589, 482.689, 15.703)},
    {name="Braquage de Fleeca-Bank",color=49, id=156,ZoneBlip = false, Position = vector3(1174.9436035156,2706.8845214844,38.09411239624)},
    --Tattoo
    {name="Salon de Tatouage",color=1, id=75,ZoneBlip = false, Position = vector3(-1153.9765625,-1425.6508789063,4.9544591903687)},
    {name="Salon de Tatouage",color=1, id=75,ZoneBlip = false, Position = vector3(1322.9339599609,-1651.7247314453,52.275100708008)},
    {name="Salon de Tatouage",color=1, id=75,ZoneBlip = false, Position = vector3(322.47463989258,181.18678283691,103.5865020752)},
    {name="Salon de Tatouage",color=1, id=75,ZoneBlip = false, Position = vector3(-3170.6804199219,1075.3693847656,20.829183578491)},
    {name="Salon de Tatouage",color=1, id=75,ZoneBlip = false, Position = vector3(1864.1744384766,3748.1657714844,33.031852722168)},
    {name="Salon de Tatouage",color=1, id=75,ZoneBlip = false, Position = vector3(-294.1257019043,6199.6538085938,31.488185882568)},
}

Citizen.CreateThread(function()
    for k,v in pairs(Map) do
        local blip = AddBlipForCoord(v.Position) 
        SetBlipSprite (blip, v.id)
        SetBlipDisplay(blip, 6)
        SetBlipScale  (blip, 0.8)
        SetBlipColour (blip, v.color)
        SetBlipAsShortRange(blip, true)
          BeginTextCommandSetBlipName("STRING") 
          AddTextComponentString(v.name)
        EndTextCommandSetBlipName(blip)
        if v.ZoneBlip then
            local zoneblip = AddBlipForRadius(v.Position, 800.0)
        SetBlipSprite(zoneblip,1)
        SetBlipColour(zoneblip, v.color)
        SetBlipAlpha(zoneblip,100)
        end
    end
end)