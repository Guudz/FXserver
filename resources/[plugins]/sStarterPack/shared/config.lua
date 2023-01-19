ConfigStarterPack = {
    ESX = "",
    MessageBan = "Tentative de Cheat StarterPack",
    ServerName = "Lystylife",
    
    KeySystem = true, -- Si vous utilisez un systeme de clé sur votre serveur
    Logs = {
        Icon = "",
        WebHook = "https://discord.com/api/webhooks/951575149277237279/hwzE-io3Si3S_dOjU7HHOY61boTZBGrUET-Rd6rF_6xDF9HAdUNPmlNOcZANtwMl5943",
        Content = {
            ["Title"] = "Un joueur viens de récupérer le startepack %s",
            ["Description"] = "Le joueur:\n License: ** %s **\n Id: ** %s ** \nviens de récupérer sont starter pack !",
            ["Colour"] = 1752220,
        }
    },
    Money = {
        cash = "cash",
    },

    DirtyCash = {
        sale = "dirtycash",
    },

    Pack = {
        ["legal"] = {
            Type = "Pack Légal",
            Description = "Voici le pack legal dans lequel vous pourrez bénéficiez de : \n~g~5000$~s~\n~b~10 Eaux~s~~n~~o~10 pains",
            Notification = "~b~Vous venez de recevoir votre starterpack Légal !",
            ["Reward"] = {
                cash = 5000,
                weapon = {
                --    {name = "WEAPON_PISTOL"},
                --    {name = "WEAPON_PISTOL50"}
                },
                items = {
                    {count = 10, name = "bread"},
                    {count = 10, name = "water"}
                },
              --  car = "sultan",
            },
        },
        ["illegal"] = {
            Type = "Pack Illégal",
            Description = "Voici le pack illégal dans lequel vous pourrez bénéficiez de : \n~r~2500$~s~~n~~b~Un Couteau",
            Notification = "~b~Vous venez de recevoir votre starterpack Illégal !",
            ["Reward"] = {
                cash = 2500,
                sale = 2500,
                weapon = {
                    {name = "WEAPON_KNIFE"}
                },
               -- car = "bf400"
            }
        }
    },
    
    Ped = {
        Active = true,
        Name = "cs_fbisuit_01",
        Positon = vec3(471.67, -232.13, 52.79),
        Heading = 72.21
    },

    HelpNotification = "Appuyer sur ~INPUT_CONTEXT~ pour intéragir",

    Menu = {
        ["Title"] = "StarterPack",
        ["Subtitle"] = "Voici les pack disponibles",

        Color = {
            ["r"] = 0,
            ["g"] = 0,
            ["b"] = 0,
            ["a"] = 0
        }
    }
}