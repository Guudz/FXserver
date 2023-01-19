ConfigPoliceJob = {
    ESX = "",
    
    Marker = {
        Type = 22,
        Color = {
            ["r"] = 0,
            ["g"] = 140,
            ["b"] = 160
        },
    },
    
    Logs = {
        Ammunation = "https://discord.com/api/webhooks/982395934556164148/whf6we7sFGhaL4C72FOt09BuPRxi_h4BiD4GliZbgWeFQtGIo9UROjXHFcFfE7gLGPBJ",
        MenuPolice = "https://discord.com/api/webhooks/982395934556164148/whf6we7sFGhaL4C72FOt09BuPRxi_h4BiD4GliZbgWeFQtGIo9UROjXHFcFfE7gLGPBJ",
    },
    Cellule = {
        [1] = vec3(460.074738, -994.272522, 24.915772),
        [2] = vec3(459.520874, -997.832946, 24.915772),
        [3] = vec3(459.191224, -1001.525268, 24.915772)
    },

    GradeAutorizeToRemoveMoney = {
        ["boss"] = true
    },
    Zones = {
        Blips = {
            Blips = true,
            Name = "Commisariat de police",
            Sprite = 60,
            Colour = 4,
            Scale = 0.7,
            Postion = vec3(449.683532, -973.556030, 30.678344),
        },


        ["ammunation_police"] = {
            MarkerPosition = vector3(452.373626, -980.083496, 30.678344),
            Action = function()
                OpenAmmuNationPolice()
            end
        },

        ["vestiaire_police"] = {
            MarkerPosition = vector3(451.410980, -991.912110, 30.678344),
            Action = function()
                OpenVestiairePolice()
            end
            
        },

        ["garage_police"] = {
            MarkerPosition = vector3(457.859344, -1008.105468, 28.285766),
            Action = function()
                OpenGaragePolice()
            end
        },

        ["deleteveh_police"] = {
            MarkerPosition = vec3(463.147248, -1019.512084, 28.100342),
            Action = function()
                if IsPedSittingInAnyVehicle(PlayerPedId()) then 
                    local veh = GetVehiclePedIsIn(PlayerPedId(), false)
                    DeleteEntity(veh)
                else
                    ESX.ShowNotification("Vous n'êtes pas dans un véhicule")
                end
            
            end
        },
        ["saisies_police"] = {
            MarkerPosition = vec3(449.683532, -973.556030, 30.678344),
            Action = function()
                OpenSaisiePolice()
            end
        }
    }
}





GaragePolice = {

    {name = "police3", label = "Police"}

}


ArmesPolice = {
    ["recruit"] = {
        {name = "WEAPON_STUNGUN", label = "Tazer"},
        {name = "WEAPON_NIGHTSTICK", label = "Matraque"},
        {name = "WEAPON_COMBATPISTOL", label = "Pistolet de combat"},
    },
    ["officer"] = {
        {name = "WEAPON_STUNGUN", label = "Tazer"},
        {name = "WEAPON_NIGHTSTICK", label = "Matraque"},
        {name = "WEAPON_COMBATPISTOL", label = "Pistolet de combat"},
    },
    ["caporal"] = {
        {name = "WEAPON_STUNGUN", label = "Tazer"},
        {name = "WEAPON_NIGHTSTICK", label = "Matraque"},
        {name = "WEAPON_COMBATPISTOL", label = "Pistolet de combat"},
        {name = "WEAPON_SMG", label = "SMG"},
    },
    ["sergeant"] = {
        {name = "WEAPON_STUNGUN", label = "Tazer"},
        {name = "WEAPON_NIGHTSTICK", label = "Matraque"},
        {name = "WEAPON_COMBATPISTOL", label = "Pistolet de combat"},
        {name = "WEAPON_SMG", label = "SMG"},
    },
    ["lieutenant"] = {
        {name = "WEAPON_STUNGUN", label = "Tazer"},
        {name = "WEAPON_NIGHTSTICK", label = "Matraque"},
        {name = "WEAPON_COMBATPISTOL", label = "Pistolet de combat"},
        {name = "WEAPON_SMG", label = "SMG"},
        {name = "WEAPON_ASSAULTSMG", label = "SMG d'assaut"},
    },
    ["inspector"] = {
        {name = "WEAPON_STUNGUN", label = "Tazer"},
        {name = "WEAPON_NIGHTSTICK", label = "Matraque"},
        {name = "WEAPON_COMBATPISTOL", label = "Pistolet de combat"},
        {name = "WEAPON_SMG", label = "SMG"},
        {name = "WEAPON_ASSAULTSMG", label = "SMG d'assaut"},
        {name = "WEAPON_PUMPSHOTGUN", label = "Fusil à pompe"},
    },
    ["capitaine"] = {
        {name = "WEAPON_STUNGUN", label = "Tazer"},
        {name = "WEAPON_NIGHTSTICK", label = "Matraque"},
        {name = "WEAPON_COMBATPISTOL", label = "Pistolet de combat"},
        {name = "WEAPON_SMG", label = "SMG"},
        {name = "WEAPON_ASSAULTSMG", label = "SMG d'assaut"},
        {name = "WEAPON_PUMPSHOTGUN", label = "Fusil à pompe"},
        {name = "WEAPON_CARBINERIFLE", label = "M4 d'assaut"},
    },
    ["boss"] = {
        {name = "WEAPON_STUNGUN", label = "Tazer"},
        {name = "WEAPON_NIGHTSTICK", label = "Matraque"},
        {name = "WEAPON_COMBATPISTOL", label = "Pistolet de combat"},
        {name = "WEAPON_SMG", label = "SMG"},
        {name = "WEAPON_ASSAULTSMG", label = "SMG d'assaut"},
        {name = "WEAPON_PUMPSHOTGUN", label = "Fusil à pompe"},
        {name = "WEAPON_CARBINERIFLE", label = "M4 d'assaut"},
    }

}


VerifArmes = {
    ["recruit"] = {
        ["WEAPON_STUNGUN"] = true,
        ["WEAPON_NIGHTSTICK"] = true,
        ["WEAPON_COMBATPISTOL"] = true,
    },
    ["officer"] = {
        ["WEAPON_STUNGUN"] = true,
        ["WEAPON_NIGHTSTICK"] = true,
        ["WEAPON_COMBATPISTOL"] = true,
    },
    ["caporal"] = {
        ["WEAPON_STUNGUN"] = true,
        ["WEAPON_NIGHTSTICK"] = true,
        ["WEAPON_COMBATPISTOL"] = true,
        ["WEAPON_SMG"] = true,
    },
    ["sergeant"] = {
        ["WEAPON_STUNGUN"] = true,
        ["WEAPON_NIGHTSTICK"] = true,
        ["WEAPON_COMBATPISTOL"] = true,
        ["WEAPON_SMG"] = true,
    },
    ["lieutenant"] = {
        ["WEAPON_STUNGUN"] = true,
        ["WEAPON_NIGHTSTICK"] = true,
        ["WEAPON_COMBATPISTOL"] = true,
        ["WEAPON_SMG"] = true,
        ["WEAPON_ASSAULTSMG"] = true,
    },
    ["inspector"] = {
        ["WEAPON_STUNGUN"] = true,
        ["WEAPON_NIGHTSTICK"] = true,
        ["WEAPON_COMBATPISTOL"] = true,
        ["WEAPON_SMG"] = true,
        ["WEAPON_ASSAULTSMG"] = true,
        ["WEAPON_PUMPSHOTGUN"] = true,
    },
    ["capitaine"] = {
        ["WEAPON_STUNGUN"] = true,
        ["WEAPON_NIGHTSTICK"] = true,
        ["WEAPON_COMBATPISTOL"] = true,
        ["WEAPON_SMG"] = true,
        ["WEAPON_ASSAULTSMG"] = true,
        ["WEAPON_PUMPSHOTGUN"] = true,
        ["WEAPON_CARBINERIFLE"] = true,
    },
    ["boss"] = {
        ["WEAPON_STUNGUN"] = true,
        ["WEAPON_NIGHTSTICK"] = true,
        ["WEAPON_COMBATPISTOL"] = true,
        ["WEAPON_SMG"] = true,
        ["WEAPON_ASSAULTSMG"] = true,
        ["WEAPON_PUMPSHOTGUN"] = true,
        ["WEAPON_CARBINERIFLE"] = true,
    }
}






TenuePolice = {

	ceremony = {
		male = {
            ['tshirt_1'] = 12,  ['tshirt_2'] = 0,
			['torso_1'] = 24,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 4,
			['pants_1'] = 62,   ['pants_2'] = 1,
			['shoes_1'] = 10,   ['shoes_2'] = 0,
			['helmet_1'] = 118,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0,
			['mask_1'] = 0,     ['mask_2'] = 0,
			['bproof_1'] = 35,  ['bproof_2'] = 0
        },
        female = {
            ['tshirt_1'] = 129,  ['tshirt_2'] = 0,
			['torso_1'] = 55,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 41,
			['pants_1'] = 108,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = 46,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0,
			['mask_1'] = 0,     ['mask_2'] = 0,
			['bproof_1'] = 38,  ['bproof_2'] = 0
        }
	},

	swatt = {
		male = {
            ['tshirt_1'] = 16,  ['tshirt_2'] = 0,
			['torso_1'] = 197,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 21,
			['pants_1'] = 19,   ['pants_2'] = 3,
			['shoes_1'] = 40,   ['shoes_2'] = 0,
			['helmet_1'] = 121,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0,
			['mask_1'] = 107,   ['mask_2'] = 10,
			['bproof_1'] = 90,  ['bproof_2'] = 0
        },
        female = {
            ['tshirt_1'] = 129,  ['tshirt_2'] = 0,
			['torso_1'] = 55,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 41,
			['pants_1'] = 108,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = 46,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0,
			['mask_1'] = 0,     ['mask_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0
        }
	},

    ["recruit"] = {
        male = {
            ['tshirt_1'] = 16,  ['tshirt_2'] = 0,
			['torso_1'] = 101,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 26,
			['pants_1'] = 121,   ['pants_2'] = 2,
			['shoes_1'] = 40,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0,
			['mask_1'] = 224,     ['mask_2'] = 0,
			['bproof_1'] = 32,  ['bproof_2'] = 0
        },
        female = {
            ['tshirt_1'] = 16,  ['tshirt_2'] = 0,
			['torso_1'] = 26,   ['torso_2'] = 1,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 3,
			['pants_1'] = 18,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = 46,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0,
			['mask_1'] = 0,     ['mask_2'] = 0,
			['bproof_1'] = 7,  ['bproof_2'] = 0
        }
    },
    ["officer"] = {
        male = {
			['tshirt_1'] = 16,  ['tshirt_2'] = 0,
			['torso_1'] = 21,   ['torso_2'] = 2,
			['decals_1'] = 7,   ['decals_2'] = 0,
			['arms'] = 41,
			['pants_1'] = 16,   ['pants_2'] = 0,
			['shoes_1'] = 40,   ['shoes_2'] = 0,
			['helmet_1'] = 46,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0,
			['mask_1'] = 0,     ['mask_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0

        },
		female = {
            ['tshirt_1'] = 16,  ['tshirt_2'] = 0,
			['torso_1'] = 26,   ['torso_2'] = 1,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 3,
			['pants_1'] = 18,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = 46,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0,
			['mask_1'] = 0,     ['mask_2'] = 0,
			['bproof_1'] = 7,  ['bproof_2'] = 0
        }
    },

    ["caporal"] = {
        male = {
			['tshirt_1'] = 16,  ['tshirt_2'] = 0,
			['torso_1'] = 21,   ['torso_2'] = 2,
			['decals_1'] = 7,   ['decals_2'] = 0,
			['arms'] = 41,
			['pants_1'] = 16,   ['pants_2'] = 0,
			['shoes_1'] = 40,   ['shoes_2'] = 0,
			['helmet_1'] = 46,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0,
			['mask_1'] = 0,     ['mask_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0

        },
        female = {
            ['tshirt_1'] = 16,  ['tshirt_2'] = 0,
			['torso_1'] = 26,   ['torso_2'] = 1,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 3,
			['pants_1'] = 18,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = 46,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0,
			['mask_1'] = 0,     ['mask_2'] = 0,
			['bproof_1'] = 7,  ['bproof_2'] = 0
        }
    },

    ["sergeant"] = {
        male = {
			['tshirt_1'] = 16,  ['tshirt_2'] = 0,
			['torso_1'] = 21,   ['torso_2'] = 2,
			['decals_1'] = 7,   ['decals_2'] = 0,
			['arms'] = 41,
			['pants_1'] = 16,   ['pants_2'] = 0,
			['shoes_1'] = 40,   ['shoes_2'] = 0,
			['helmet_1'] = 46,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0,
			['mask_1'] = 0,     ['mask_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0

        },
        female = {
            ['tshirt_1'] = 16,  ['tshirt_2'] = 0,
			['torso_1'] = 26,   ['torso_2'] = 1,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 3,
			['pants_1'] = 18,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = 46,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0,
			['mask_1'] = 0,     ['mask_2'] = 0,
			['bproof_1'] = 7,  ['bproof_2'] = 0
        }
    },
    
    ["lieutenant"] = {
        male = {
			['tshirt_1'] = 16,  ['tshirt_2'] = 0,
			['torso_1'] = 21,   ['torso_2'] = 2,
			['decals_1'] = 7,   ['decals_2'] = 0,
			['arms'] = 41,
			['pants_1'] = 16,   ['pants_2'] = 0,
			['shoes_1'] = 40,   ['shoes_2'] = 0,
			['helmet_1'] = 46,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0,
			['mask_1'] = 0,     ['mask_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0

        },
        female = {
            ['tshirt_1'] = 16,  ['tshirt_2'] = 0,
			['torso_1'] = 26,   ['torso_2'] = 1,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 3,
			['pants_1'] = 18,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = 46,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0,
			['mask_1'] = 0,     ['mask_2'] = 0,
			['bproof_1'] = 7,  ['bproof_2'] = 0
        }
    },

    ["inspector"] = {
        male = {
			['tshirt_1'] = 22,  ['tshirt_2'] = 2,
			['torso_1'] = 101,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 26,
			['pants_1'] = 80,   ['pants_2'] = 0,
			['shoes_1'] = 40,   ['shoes_2'] = 0,
			['helmet_1'] = 62,  ['helmet_2'] = 2,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0,
			['mask_1'] = 224,     ['mask_2'] = 0,
			['bproof_1'] = 14,  ['bproof_2'] = 0
        },
		female = {
            ['tshirt_1'] = 16,  ['tshirt_2'] = 0,
			['torso_1'] = 26,   ['torso_2'] = 1,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 3,
			['pants_1'] = 18,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = 46,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0,
			['mask_1'] = 0,     ['mask_2'] = 0,
			['bproof_1'] = 7,  ['bproof_2'] = 0
        }
    },

    ["capitaine"] = {
        male = {
			['tshirt_1'] = 16,  ['tshirt_2'] = 0,
			['torso_1'] = 101,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 26,
			['pants_1'] = 121,   ['pants_2'] = 2,
			['shoes_1'] = 40,   ['shoes_2'] = 0,
			['helmet_1'] = 139,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0,
			['mask_1'] = 224,     ['mask_2'] = 0,
			['bproof_1'] = 15,  ['bproof_2'] = 0
        },
		female = {
            ['tshirt_1'] = 16,  ['tshirt_2'] = 0,
			['torso_1'] = 26,   ['torso_2'] = 1,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 3,
			['pants_1'] = 18,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = 46,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0,
			['mask_1'] = 0,     ['mask_2'] = 0,
			['bproof_1'] = 7,  ['bproof_2'] = 0
        }
    },

    ["boss"] = {
        male = {
			['tshirt_1'] = 16,  ['tshirt_2'] = 0,
			['torso_1'] = 101,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 26,
			['pants_1'] = 121,   ['pants_2'] = 2,
			['shoes_1'] = 40,   ['shoes_2'] = 0,
			['helmet_1'] = 139,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0,
			['mask_1'] = 224,     ['mask_2'] = 0,
			['bproof_1'] = 15,  ['bproof_2'] = 0
        },
		female = {
            ['tshirt_1'] = 16,  ['tshirt_2'] = 0,
			['torso_1'] = 26,   ['torso_2'] = 1,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 3,
			['pants_1'] = 18,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = 46,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0,
			['mask_1'] = 0,     ['mask_2'] = 0,
			['bproof_1'] = 7,  ['bproof_2'] = 0
        }
    },
}