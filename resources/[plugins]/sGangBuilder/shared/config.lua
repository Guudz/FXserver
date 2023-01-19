ConfigGangBuilder = {

    PrefixESX = "",
    ESX = "esx:getSharedObject",
    Command = {
        OpenMenu = "gangbuilder" -- Commande pour ouvrir le mneu
    },
    BaseCalifornia = true,

    Marker = {
        Type = 22,
        Color = {
            ["r"] = 255,
            ["g"] = 122,
            ["b"] = 12
        }
    },

    Logs = {
        Active = true,

        -- Création gang
        CreateGang = "https://discordapp.com/api/webhooks/987110798096756736/b1xStdyLGrnGfpN1ozZ7gTkpfntOyc9UKyFGA6QY_NqLr_rogq-9hzePkxcL0nm5I8vE",
        -- Argent
        DepostiMoney = "https://discordapp.com/api/webhooks/987110930850643978/tj0yvmBMYURERw4Wgwx2pHQ_vZlIv41Cl8xFa03HO7OC82zp5vOFmbQifrfE2VbZitNz",
        RemoveMoney = "https://discordapp.com/api/webhooks/987111024954077214/AsT_VPTcPgW2W35NaL_PhjUC91l98dH4SFMfn5AjG4qP1_OFfhojG_dNXWcnZcZdNwpI",
        -- Items 
        DepositItem = "https://discordapp.com/api/webhooks/987111209843179570/J3Hv7Tf7_xwPFCL0WThB79BQPxueYfIVIL1hd9qqFGPVpew-wc64lgUQw4kg8fecdCTj",
        RemoveItem = "https://discordapp.com/api/webhooks/987111343339499570/7V7tJCxaczjPpjf9rrinXPZgbSpp5QR3ajHJZ6oQZ7_YkUMGo6Zp58oFNIYh8eelaqSF",
        -- Armes
        DepositArmes = "https://discordapp.com/api/webhooks/987111454287233055/b8Jk_qEFvTVv_Og5hdZ_JhjEESwUtwXa84awXMZPO6wpzAa2P1-f2w2l9rBo0oa3ZcMY",
        RemoveArmes = "https://discordapp.com/api/webhooks/987111560285675651/xYHOX0NKDo-ajOvum0MhT8qqdfQE_XK923eGPsZtGHJnjEsbnEjSxbTCGE-ABH_8zJ2o",

    },



    AutorizedJobF7 = {
        ["test1"] = true,
        ["eme"] = true,
    },

    Money = {
        cash = "cash",
        argensale = "dirtycash"
    },

    GroupAutorize = {
        ["user"] = false,
        ["admin"] = true,
        ["superadmin"] = true,
        ["_dev"] = true,
        ["fondateur"] = true,
    },

    AutorizeRemoveMoney = {
        ["recruit"] = false, 
        ["membre"] = false,
        ["copatron"] = true,
        ["boss"] = true
    },
}

Garage = {
    Price = 50,
    ["qz"] = {
        primary = {r = 0, g = 255, b = 0},
        secondary = {r = 0, g = 255, b = 0},
    },    
}

Vestiaire = {
    ["mafia677"] = {
        ["recruit"] = {
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

        ["membre"] = {
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

        ["copatron"] = {
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

        ["boss"] = {
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

        }
    }
}

