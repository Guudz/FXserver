---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by iTexZ.
--- DateTime: 05/11/2020 02:17
---

local TextPanels = {
    Background = { Dictionary = "commonmenu", Texture = "gradient_bgd", Y = 4, Width = 431, Height = 42 },
}

---@type Panel
function RageUI.RenderSprite(Dictionary, Texture)
    local CurrentMenu = RageUI.CurrentMenu
    if CurrentMenu ~= nil then
        if CurrentMenu() then
            RenderSprite(Dictionary, Texture, CurrentMenu.X, CurrentMenu.Y + TextPanels.Background.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset + (RageUI.StatisticPanelCount * 42), TextPanels.Background.Width + CurrentMenu.WidthOffset, TextPanels.Background.Height + 200, 0, 255, 255, 255, 255);
            RageUI.StatisticPanelCount = RageUI.StatisticPanelCount + 1
        end
    end
end


---@type Panel
function RageUI.RenderWeapons(Dictionary, Texture)
    local CurrentMenu = RageUI.CurrentMenu
    if CurrentMenu ~= nil then
        if CurrentMenu() then
            RenderSprite(Dictionary, Texture, CurrentMenu.X, 370.25, TextPanels.Background.Width + CurrentMenu.WidthOffset, TextPanels.Background.Height + 200, 0, 255, 255, 255, 255);
            RageUI.StatisticPanelCount = RageUI.StatisticPanelCount + 1
        end
    end
end

---@type Panel
function RageUI.RenderSixt(Dictionary, Texture)
    local CurrentMenu = RageUI.CurrentMenu
    if CurrentMenu ~= nil then
        if CurrentMenu() then
            RenderSprite(Dictionary, Texture, CurrentMenu.X + 430.0, 130.25, TextPanels.Background.Width + CurrentMenu.WidthOffset, TextPanels.Background.Height + 200, 0, 255, 255, 255, 255);
            RageUI.StatisticPanelCount = RageUI.StatisticPanelCount + 1
        end
    end
end

---@type Panel
function RageUI.CaissePreviewOpen(Dictionary, Texture)
    local CurrentMenu = RageUI.CurrentMenu
    if CurrentMenu ~= nil then
        if CurrentMenu() then
            RenderSprite(Dictionary, Texture, CurrentMenu.X, CurrentMenu.Y + TextPanels.Background.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset + (RageUI.StatisticPanelCount * 42), TextPanels.Background.Width + CurrentMenu.WidthOffset, TextPanels.Background.Height + 200, 0, 255, 255, 255, 255);
            RageUI.StatisticPanelCount = RageUI.StatisticPanelCount + 1
        end
    end
end
---@type Panel
function RageUI.RenderCaisse(Dictionary, Texture)
    local CurrentMenu = RageUI.CurrentMenu
    if CurrentMenu ~= nil then
        if CurrentMenu() then
            RenderSprite(Dictionary, Texture, CurrentMenu.X, 255.25, TextPanels.Background.Width + CurrentMenu.WidthOffset, TextPanels.Background.Height + 200, 0, 255, 255, 255, 255);
            RageUI.StatisticPanelCount = RageUI.StatisticPanelCount + 1
        end
    end
end

---@type Panel
function RageUI.RenderCaissePreview(Dictionary, Texture)
    local CurrentMenu = RageUI.CurrentMenu
    if CurrentMenu ~= nil then
        if CurrentMenu() then
            RenderSprite(Dictionary, Texture, CurrentMenu.X, 530.25, TextPanels.Background.Width + CurrentMenu.WidthOffset, TextPanels.Background.Height + 200, 0, 255, 255, 255, 255);
            RageUI.StatisticPanelCount = RageUI.StatisticPanelCount + 1
        end
    end
end

---@type Panel
function RageUI.RenderJournalier(Dictionary, Texture)
    local CurrentMenu = RageUI.CurrentMenu
    if CurrentMenu ~= nil then
        if CurrentMenu() then
            RenderSprite(Dictionary, Texture, CurrentMenu.X, 400.25, TextPanels.Background.Width + CurrentMenu.WidthOffset, TextPanels.Background.Height + 200, 0, 255, 255, 255, 255);
            RageUI.StatisticPanelCount = RageUI.StatisticPanelCount + 1
        end
    end
end

---@type Panel
function RageUI.RenderVehicle(Dictionary, Texture)
    local CurrentMenu = RageUI.CurrentMenu
    if CurrentMenu ~= nil then
        if CurrentMenu() then
            RenderSprite(Dictionary, Texture, CurrentMenu.X, 400.25, TextPanels.Background.Width + CurrentMenu.WidthOffset, TextPanels.Background.Height + 200, 0, 255, 255, 255, 255);
            RageUI.StatisticPanelCount = RageUI.StatisticPanelCount + 1
        end
    end
end