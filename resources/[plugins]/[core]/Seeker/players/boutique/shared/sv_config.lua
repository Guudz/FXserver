SecurityVehicles = {
    ['tmax'] = {label = 'T-Max', model = 'tmax', description = nil, price = 500},
    ['ninjah2'] = {label = 'Ninja H2', model = 'ninjah2', description = nil, price = 1500},
    ['16challenger'] = {label = 'Dodge Challenger', model = '16challenger', description = nil, price = 1500},
    ['a80'] = {label = 'Toyota Supra', model = 'a80', description = nil, price = 2000},
    ['venatus'] = {label = 'Lamborghini Venatus', model = 'venatus', description = nil, price = 2500},
    ['rmodgt63'] = {label = 'Mercedes GT63', model = 'rmodgt63', description = nil, price = 2500},
    ['rmodbugatti'] = {label = 'Bugatti Divo', model = 'rmodbugatti', description = nil, price = 1645},
    ['rmodcharger69'] = {label = 'Dodge Charger 69', model = 'rmodcharger69', description = nil, price = 1645},
    ['rmoddarki8'] = {label = 'Darki 8', model = 'rmoddarki8', description = nil, price = 1645},
    ['rmode63s'] = {label = 'Mercedes E 63 S', model = 'rmode63s', description = nil, price = 1645},
    ['rmodgtr50'] = {label = 'Nissan GTR-50', model = 'rmodgtr50', description = nil, price = 1645},
    ['xadv'] = {label = 'Handa-xadv', model = 'xadv', description = nil, price = 1645},
}

SecurityVehiclesPlane = {
    ['microlight'] = {model = 'microlight', price = 750},
    ['stunt'] = {model = 'stunt', price = 1250},
    ['buzzard2'] = {model = 'buzzard2', price = 1500},
    ['supervolito2'] = {model = 'supervolito2', price = 2000},
    ['havok'] = {model = 'havok', price = 1000},
    ['swift2'] = {model = 'swift2', price = 2500},
    ['luxor2'] = {model = 'luxor2', price = 3000},
}

SecurityVehiclesBoat = {
    ['seashark3'] = {model = 'seashark3', price = 750},
    ['submersible'] = {model = 'submersible', price = 1250},
    ['submersible2'] = {model = 'submersible2', price = 1500},
    ['longfin'] = {model = 'longfin', price = 2000},
    ['sr650fly'] = {model = 'sr650fly', price = 2500},
}

-- ARMES 

SecurityWeapons = {
    ['WEAPON_HATCHET'] = {price = 450, name = 'WEAPON_HATCHET', label = 'Epée en diamant'},
    ['WEAPON_NAVYREVOLVER'] = {price = 1250, name = 'WEAPON_NAVYREVOLVER',label = 'Navy Revolver'},
    ['weapon_gusenberg'] = {price = 2500, name = 'WEAPON_GUSENBERG',label = 'Gusenberg'},
    ['WEAPON_ASSAULTRIFLE'] = {price = 2500, name = 'WEAPON_ASSAULTRIFLE',label = 'AK-47'},
    ['WEAPON_COMBATPDW'] = {price = 3500, name = 'WEAPON_COMBATPDW',label = 'Arme de Défense Personnel'},
    ['WEAPON_GADGETPISTOL'] = {price = 1500, name = 'WEAPON_GADGETPISTOL',label = 'Pistolet Cayo'},
}

-- CAISSE MYSTERE

MysteryBox = {
    ListBox = {
        ['caisse_gold'] = {label = 'Caisse Gold', price = 500},
        ['caisse_diamond'] = {label = 'Caise Diamond', price = 1000},
        ['caisse_ruby'] = {label = 'Caisse Ruby', price = 2500},
        ['caisse_noel'] = {label = 'Caisse Noel', price = 1500},
        ['caisse_halloween'] = {label = 'Caisse Halloween', price = 1500},
        ['caisse_fidelite'] = {label = 'Caisse Fidelité', price = 9999999},
        ['caisse_vehicule'] = {label = 'Caisse Véhicule', price = 1750},
    },
    Box = {
        ['caisse_gold'] = {
            [4] = {
                "weapon_pistol_mk2",
                "Coins_1000",
            },
            [3] = {
                "weapon_machinepistol",
                "weapon_katana",
            },
            [2] = {
                "money_250000",
                "money_150000",
                "money_500000",
                "ferrari812",
            },
            [1] = {
                "GADGET_PARACHUTE",
                "a45amg",
                "m6prior",
                "bmci",
                "weapon_stone_hatchet",
            },
        },
        ['caisse_diamond'] = {
            [4] = {
                "weapon_pumpshotgun",
                "weapon_heavyshotgun",
            },
            [3] = {
                "weapon_appistol",
                "weapon_assaultrifle",
            },
            [2] = {
                "money_1000000",
                "Coins_850",
                "Coins_500",
            },
            [1] = {
                "rmod918spyder",
                "rmodc63amg",
                "rmodchiron300",
                "rmodatlantic",
                "rs615",
                "rs7r",
                "rmod240sx",
                "nh2r",
                "g65amg",
                "rmodpagani",
                "rmodr8c",
                "rs318",
                "km1000rr",
                "rmodrover",
                "760m",
                "rmodg65",
                "brabus800",
            },
        },
        ['caisse_ruby'] = {
            [4] = {
                --"weapon_combatmg_mk2",
                --"weapon_mg",
                --"weapon_combatmg",
                "weapon_assaultshotgun",
                "weapon_marksmanrifle_mk2",
                "swift2",
                "weapon_heavysniper_mk2",
                "cargobob2",
                "gls632",
            },
            [3] = {
                "luxor2",
                "buzzard2",
                "avenger",
            },
            [2] = {
                "s1000rr",
                "p1",
                "rs6abtp",
                "Coins_1000",
            },
            [1] = {
                "Coins_850",
                "Coins_800",
                "rs615",
            },
        },
        ['caisse_noel'] = {
            [4] = {
                "WEAPON_SCAR17FM",
                "Coins_2250",
                "WEAPON_SPECIALCARBINE",
                "WEAPON_COMBATPDW",
                "vehicleunique",
                "cargobob2",
                "gls632",
            },
            [3] = {
                "WEAPON_ASSAULTRIFLE",
                "WEAPON_GADGETPISTOL",
                "WEAPON_SNOWBALL",
                "Custom_5",
            },
            [2] = {
                "q820",
                "Custom_3",
                "WEAPON_CASABLANCA",
                "WEAPON_KATANA",
            },
            [1] = {
                "Custom_1",
                "mb250",
                "GADGET_PARACHUTE",
                "survolt",
                "senna",
                "rmodm5e34",
                "acz4",
                "a80",
                "16challenger",
                "rmodrs6",
                "r820",
                "rmodx6",
            },
        },
        ['caisse_halloween'] = {
            [3] = {
                "dune2",
                "speedo2",
                "Coins_2500"
            },
            [2] = {
                "money_2500000",
                "money_1500000",
                "weapon_flaregun",
            },
            [1] = {
                "BType2",
                "money_750000",
                "Tornado6",
            },
        },
        ['caisse_fidelite'] = {
            [4] = {
                --"weapon_combatmg_mk2",
                --"weapon_mg",
                --"weapon_combatmg",
                "weapon_assaultshotgun",
                "weapon_marksmanrifle_mk2",
                "swift2",
                "weapon_heavysniper_mk2",
                "cargobob2",
                "gls632",
            },
            [3] = {
                "luxor2",
                "buzzard2",
                "avenger",
            },
            [2] = {
                "s1000rr",
                "p1",
                "rs6abtp",
                "Coins_1000",
            },
            [1] = {
                "Coins_850",
                "Coins_800",
                "rs666",
                "gadget_parachute",
            },
        },
        ['caisse_vehicule'] = {
            [4] = {
                "weapon_pistol_mk2",
                "weapon_machinepistol",
                "weapon_stone_hatchet",
            },
            [3] = {
                "FCT",
                "VIPER",
                "rmodmustang",
            },
            [2] = {
                "M3E30",
                "mercxclass",
                "Mustang",
            },
            [1] = {
                "cooperworks",
                "PEANUT",
                "TESLAMODELS",
            },
        }
    },
    Recompense = {
        -- Caisse gold
        ["weapon_pistol_mk2"] = { type = "weapon", message = "Félicitation, vous avez gagner un Pistolet MK2." },
        ["weapon_machinepistol"] = { type = "weapon", message = "Félicitation, vous avez gagner un Pistolet Mitrailleur." },
        ["weapon_katana"] = { type = "weapon", message = "Félicitation, vous avez gagner un Katana." },
        ["money_150000"] = { type = "money", message = "Félicitation, vous avez gagner 150000$." },
        ["money_250000"] = { type = "money", message = "Félicitation, vous avez gagner 250000$." },
        ["money_500000"] = { type = "money", message = "Félicitation, vous avez gagner 500000$." },
        ["Coins_1000"] = { type = "Coins", message = "Félicitation, vous avez gagner 1000 Coins." },
        ["ferrari812"] = { type = "vehicle", message = "Félicitation, vous avez gagner un Ferrari 812." },
        ["a45amg"] = { type = "vehicle", message = "Félicitation, vous avez gagner un Mercedes A45." },
        ["m6prior"] = { type = "vehicle", message = "Félicitation, vous avez gagner un BMW M6." },
        ["bmci"] = { type = "vehicle", message = "Félicitation, vous avez gagner un BMW M5." },
        ["weapon_stone_hatchet"] = { type = "weapon", message = "Félicitation, vous avez gagner une Hachete en pierre." },
        ["gadget_parachute"] = { type = "weapon", message = "Félicitation, vous avez gagner un Parachute." },
        -- Caisse Diamond
        ["weapon_pumpshotgun"] = { type = "weapon", message = "Félicitation, vous avez gagner un Fusil a Pompe." },
        ["weapon_heavyshotgun"] = { type = "weapon", message = "Félicitation, vous avez gagner un Fusil a Pompe." },
        ["weapon_appistol"] = { type = "weapon", message = "Félicitation, vous avez gagner un Pistolet Mitrailleur." },
        ["weapon_assaultrifle"] = { type = "weapon", message = "Félicitation, vous avez gagner une Ak-47."},
        ["money_1000000"] = { type = "money", message = "Félicitation, vous avez gagner 1000000$." },
        ["Coins_850"] = { type = "Coins", message = "Félicitation, vous avez gagner 850 Coins" },
        ["Coins_500"] = { type = "Coins", message = "Félicitation, vous avez gagner 500 Coins" },
        ["Coins_1250"] = { type = "Coins", message = "Félicitation, vous avez gagner 1250 Coins" },
        ["rmod918spyder"] = { type = "vehicle", message = "Félicitation, vous avez gagner une Porsche 918 Spyder." },
        ["rmodc63amg"] = { type = "vehicle", message = "Félicitation, vous avez gagner une Mercedes-AMG C63." },
        ["rmodchiron300"] = { type = "vehicle", message = "Félicitation, vous avez gagner un Bugatti Chiron." },
        ["rmodatlantic"] = { type = "vehicle", message = "Félicitation, vous avez gagner un Bugatti Atlantic." },
        ["rs615"] = { type = "vehicle", message = "Félicitation, vous avez gagner un Audi RS6 2015." },
        ["rs7r"] = { type = "vehicle", message = "Félicitation, vous avez gagner un AUDI RS7 R." },
        ["z15326power"] = { type = "vehicle", message = "Félicitation, vous avez gagner une Voiture de Drift." },
        ["nh2r"] = { type = "vehicle", message = "Félicitation, vous avez gagner une Moto." },
        ["g65amg"] = { type = "vehicle", message = "Félicitation, vous avez gagner une MERCEDES G65 AMG." },
        ["rmodpagani"] = { type = "vehicle", message = "Félicitation, vous avez gagner une Pagani." },
        ["rmodr8c"] = { type = "vehicle", message = "Félicitation, vous avez gagner une Audi R8." },
        ["rs318"] = { type = "vehicle", message = "Félicitation, vous avez gagner une Audi RS3 2018." },
        ["km1000rr"] = { type = "vehicle", message = "Félicitation, vous avez gagner une Moto." },
        ["760m"] = { type = "vehicle", message = "Félicitation, vous avez gagner un BMW 760M." },
        ["rmodg65"] = { type = "vehicle", message = "Félicitation, vous avez gagner un Mercedes BRABUS 500." },
        ["brabus800"] = { type = "vehicle", message = "Félicitation, vous avez gagner un Mercedes BRABUS 800." },
        -- CAISSE NOEL
        ["WEAPON_SCAR17FM"] = { type = "weapon", message = "Félicitation, vous avez gagner une SCAR-17."},
        ["Coins_2250"] = { type = "Coins", message = "Félicitation, vous avez gagner 1000 Coins."},
        ["WEAPON_SPECIALCARBINE"] = { type = "weapon", message = "Félicitation, vous avez gagner une Carabine Spéciale."},
        ["WEAPON_COMBATPDW"] = { type = "weapon", message = "Félicitation, vous avez gagner une ADP de Combat."},
        ["vehicleunique"] = { type = "vehunique", message = "Félicitation, vous avez gagner un Véhicule Unique ( Prennez un screen )."},
        ["WEAPON_GADGETPISTOL"] = { type = "weapon", message = "Félicitation, vous avez gagner une Pistolet Cayo."},
        ["WEAPON_SNOWBALL"] = { type = "weapon", message = "Félicitation, vous avez gagner une Boule de Neige."},
        ["Custom_5"] = { type = "custom", message = "Félicitation, vous avez gagner x5 Jeton Custom."},
        ["Custom_3"] = { type = "custom", message = "Félicitation, vous avez gagner x3 Jeton Custom."},
        ["Custom_1"] = { type = "custom", message = "Félicitation, vous avez gagner x1 Jeton Custom."},
        ["q820"] = { type = "vehicle", message = "Félicitation, vous avez gagner une Audi Q8."},
        ["mb250"] = { type = "vehicle", message = "Félicitation, vous avez gagner un MB250."},
        ["survolt"] = { type = "vehicle", message = "Félicitation, vous avez gagner un Survolt."},
        ["senna"] = { type = "vehicle", message = "Félicitation, vous avez gagner un McLaren Senna."},
        ["rmodm5e34"] = { type = "vehicle", message = "Félicitation, vous avez gagner une BMW M5E34."},
        ["acz4"] = { type = "vehicle", message = "Félicitation, vous avez gagner une ACZ4."},
        ["a80"] = { type = "vehicle", message = "Félicitation, vous avez gagner une Toyota Supra."},
        ["16challenger"] = { type = "vehicle", message = "Félicitation, vous avez gagner une Dodge Challenger."},
        ["rmodrs6"] = { type = "vehicle", message = "Félicitation, vous avez gagner une Audi RS6."},
        ["r820"] = { type = "vehicle", message = "Félicitation, vous avez gagner une Audi R8."},
        ["rmodx6"] = { type = "vehicle", message = "Félicitation, vous avez gagner une BMW MX6."},
        -- Caisse Ruby
        ["weapon_combatmg_mk2"] = { type = "weapon", message = "Félicitation, vous avez gagner une Mitrailleuse MK2." },
        ["weapon_mg"] = { type = "weapon", message = "Félicitation, vous avez gagner une Mitrailleuse." },
        ["weapon_combatmg"] = { type = "weapon", message = "Félicitation, vous avez gagner une Mitrailleuse de Combat." },
        ["weapon_marksmanrifle_mk2"] = { type = "weapon", message = "Félicitation, vous avez gagner un Sniper Marksman." },
        ["swift2"] = { type = "helico", message = "Félicitation, vous avez gagner Hélicoptère de Luxe." },
        ["weapon_heavysniper_mk2"] = { type = "weapon", message = "Félicitation, vous avez gagner Sniper Heavy" },
        ["cargobob2"] = { type = "helico", message = "Félicitation, vous avez gagner un Cargobob"},
        ["weapon_assaultshotgun"] = { type = "weapon", message = "Félicitation, vous avez gagner un fusil a pompe d'assault" },
        ["luxor2"] = { type = "helico", message = "Félicitation, vous avez gagner un Jet de luxe." },
        ["buzzard2"] = { type = "helico", message = "Félicitation, vous avez gagner un Buzzard." },
        ["avenger"] = { type = "helico", message = "Félicitation, vous avez gagner un Avenger." },
        ["money_4000000"] = { type = "money", message = "Félicitation, vous avez gagner un 4000000$." },
        ["Coins_500"] = { type = "Coins", message = "Félicitation, vous avez gagner 500 Coins." },
        ["Coins_800"] = { type = "Coins", message = "Félicitation, vous avez gagner 800 Coins." },
        ["Coins_450"] = { type = "Coins", message = "Félicitation, vous avez gagner 450 Coins." },
        ["gls632"] = { type = "vehicle", message = "Félicitation, vous avez gagner un Mercedes GLS 63." },
        ["s1000rr"] = { type = "vehicle", message = "Félicitation, vous avez gagner une Moto." },
        ["p1"] = { type = "vehicle", message = "Félicitation, vous avez gagner une Mclaren P1." },
        ["rs6abtp"] = { type = "vehicle", message = "Félicitation, vous avez gagner une Audi RS6 ABT" },
        ["rs666"] = { type = "vehicle", message = "Félicitation, vous avez gagner une Audi RS6." },
        -- CAISSE HALLOWEEN
        ["dune2"] = { type = "vehicle", message = "Félicitation, vous avez gagner une Voiture Halloween." },
        ["speedo2"] = { type = "vehicle", message = "Félicitation, vous avez gagner un Camion Halloween." },
        ["weapon_flaregun"] = { type = "weapon", message = "Félicitation, vous avez gagner un Flare Gun." },
        ["money_2500000"] = { type = "money", message = "Félicitation, vous avez gagner 2.500.000$"},
        ["money_1500000"] = { type = "money", message = "Félicitation, vous avez gagner 1.500.000$" },
        ["BType2"] = { type = "vehicle", message = "Félicitation, vous avez gagner une BType2." },
        ["money_750000"] = { type = "money", message = "Félicitation, vous avez gagner 750.000$" },
        ["Tornado6"] = { type = "vehicle", message = "Félicitation, vous avez gagner Tornado Halloween" },
        -- CAISSE FIDELITE
        ["WEAPON_ASSAULTSHOTGUN"] = { type = "weapon", message = "Félicitation, vous avez gagner un Fusil a pompe d'assault." },
        ["rx7fdbn"] = { type = "vehicle", message = "Félicitation, vous avez gagner une Mazda RX7." },
        ["WEAPON_CASABLANCA"] = { type = "weapon", message = "Félicitation, vous avez gagner une Machete Casa Blanca." },
        ["WEAPON_KATANA"] = { type = "weapon", message = "Félicitation, vous avez gagner un Katana." },
        -- CAISSE VEHICULE
        ["cooperworks"] = { type = "vehicle", message = "Félicitation, vous avez gagner une cooper." },
        ["FCT"] = { type = "vehicle", message = "Félicitation, vous avez gagner une ferrari 2015." },
        ["M3E30"] = { type = "vehicle", message = "Félicitation, vous avez gagner une BMW M3 E30." },
        ["mercxclass"] = { type = "vehicle", message = "Félicitation, vous avez gagner un Mercedes-Benz X-Class." },
        ["Mustang"] = { type = "vehicle", message = "Félicitation, vous avez gagner une mustang." },
        ["PEANUT"] = { type = "vehicle", message = "Félicitation, vous avez gagner une PEANUT." },
        ["rmodmustang"] = { type = "vehicle", message = "Félicitation, vous avez gagner une mustang GT." },
        ["TESLAMODELS"] = { type = "vehicle", message = "Félicitation, vous avez gagner une Tesla model S." },
        ["VIPER"] = { type = "vehicle", message = "Félicitation, vous avez gagner une VIPER." }
    }
}