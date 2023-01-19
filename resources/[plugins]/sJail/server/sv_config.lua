--[[
  This file is part of Ronflex Shop.

  Copyright (c) Ronflex Shop - All Rights Reserved

  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]

Config = {}
Config.ESX = "" --A laisser vide de base

Config.PointSortie = vector3(1853.835, 2639.68, 45.672) -- Position de sortie du jouer
Config.PointEntrer = vector3(1642.493, 2570.144, 45.564) -- Position de spawn 

Config.WebhookJail = "https://discord.com/api/webhooks/969840604521578526/Drwlxb8ZmEicgEAV94lgi0rvW2jXK2Rilnqy70B5XALeOXczUt0jXKVfCDMmXUQ8uufW" -- Logs lorsqu'il est jail
Config.WebhookUnJail = "https://discord.com/api/webhooks/969840604521578526/Drwlxb8ZmEicgEAV94lgi0rvW2jXK2Rilnqy70B5XALeOXczUt0jXKVfCDMmXUQ8uufW" -- Logs lorsqu'il est unjail
Config.WebhookJailOffline = "https://discord.com/api/webhooks/969840604521578526/Drwlxb8ZmEicgEAV94lgi0rvW2jXK2Rilnqy70B5XALeOXczUt0jXKVfCDMmXUQ8uufW"-- Logs lorsqu'il est jailoffline
Config.StaffOnlyUnjailPlayerJail = false -- Vous permet de choisir si UNIQUEMENT le staff qui à jail la personne peut le unajil
Config.TimerJailMortDeco = 0 -- Temps que la personne sera en jail si elle déco
Config.JailPlayerDead = false -- Configurer si la perosnne est jail quand elle déco en étant morte


--[[

Pour retirer le joueur de la table afin que quand il est revive il ne soit plus dans la table
pour le jail mettez de trigger:

TriggerServerEvent("ronflex:updatejailplayerider", true)

--]]