---@class ContextUIItems
ContextUIItems = {};

function ContextUIItems:AddButton(Text, Action, Submenu)
	local PosX, PosY = ContextUI.Position.x, ContextUI.Position.y
	local Colors = {
		Rectangle = { 10, 10, 10, 220 },
		Text = { 255, 255, 255, 255 }
	}

	PosY = PosY + (ContextUI.Options * Settings.Button.Height)

	local onHovered = Graphics.IsMouseInBounds(PosX, PosY, Settings.Button.Width, Settings.Button.Height);
	if (onHovered) then
		local Selected = false;
		SetMouseCursorSprite(5)
		Colors.Rectangle = { 213, 10, 89, 255 }
		if IsControlJustPressed(0, 24) then
			if Submenu then
				ContextUI.Category = Submenu.Category
			end
			local audioName = Text == "← Retour" and "BACK" or "SELECT"
			PlaySoundFrontend(-1, audioName, "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
			Selected = true
		end
		if (Action) then
			Action(Selected)
		end
	end

	if not (onHovered) then
		Graphics.Rectangle(PosX, PosY, Settings.Button.Width, Settings.Button.Height, Colors.Rectangle[1], Colors.Rectangle[2], Colors.Rectangle[3], Colors.Rectangle[4])
	else
		Graphics.Sprite("sooyoanalanal", "gradient_nav", PosX, PosY, Settings.Button.Width, Settings.Button.Height)
	end
	if (Submenu) and (Submenu.Category ~= "main") then
		Graphics.Text("", PosX + Settings.Text.X + 190, PosY + Settings.Text.Y, Settings.Text.Font, Settings.Text.Scale, Colors.Text[1], Colors.Text[2], Colors.Text[3], Colors.Text[4], Settings.Text.Center, Settings.Text.Outline, Settings.Text.DropShadow)
	end

	Graphics.Text(Text, PosX + Settings.Text.X, PosY + Settings.Text.Y, Settings.Text.Font, Settings.Text.Scale, Colors.Text[1], Colors.Text[2], Colors.Text[3], Colors.Text[4], Settings.Text.Center, Settings.Text.Outline, Settings.Text.DropShadow)

	ContextUI.Options = ContextUI.Options + 1
	ContextUI.Offset = vector2(PosX, PosY)
end

local SettingsCheckbox = {
	Textures = {
		"shop_box_blankb", -- 1
		"shop_box_tickb", -- 2
		"shop_box_blank", -- 3
		"shop_box_tick", -- 4
		"shop_box_crossb", -- 5
		"shop_box_cross", -- 6
	},
}

---StyleCheckBox
---@param Selected number
---@param Checked boolean
---@param Box number
---@param BoxSelect number
---@return nil
local function StyleCheckBox(PosX, PosY, Selected, Checked, Box, BoxSelect)
	if Selected then
		if Checked then
			Graphics.Sprite("sooyoanalanal", SettingsCheckbox.Textures[Box], PosX + 186.0, PosY - 2.5, 36, 36)
		else
			Graphics.Sprite("sooyoanalanal", "shop_box_blankb", PosX + 186.0, PosY - 2.5, 36, 36)
		end
	else
		if Checked then
			Graphics.Sprite("sooyoanalanal", SettingsCheckbox.Textures[BoxSelect], PosX + 186.0, PosY - 2.5, 36, 36)
		else
			Graphics.Sprite("sooyoanalanal", "shop_box_blank", PosX + 186.0, PosY - 2.5, 36, 36)
		end
	end
end

function ContextUIItems:AddCheckBox(Text, Checked, Action, Style)
	local PosX, PosY = ContextUI.Position.x, ContextUI.Position.y
	local Colors = {
		Rectangle = { 10, 10, 10, 220 },
		Text = { 255, 255, 255, 255 }
	}

	PosY = PosY + (ContextUI.Options * Settings.Button.Height)

	local onHovered = Graphics.IsMouseInBounds(PosX, PosY, Settings.Button.Width, Settings.Button.Height)

	if not (onHovered) then
		Graphics.Rectangle(PosX, PosY, Settings.Button.Width, Settings.Button.Height, Colors.Rectangle[1], Colors.Rectangle[2], Colors.Rectangle[3], Colors.Rectangle[4])
	else
		Graphics.Sprite("sooyoanalanal", "gradient_nav", PosX, PosY, Settings.Button.Width, Settings.Button.Height)
	end
	Graphics.Text(Text, PosX + Settings.Text.X, PosY + Settings.Text.Y, Settings.Text.Font, Settings.Text.Scale, Colors.Text[1], Colors.Text[2], Colors.Text[3], Colors.Text[4], Settings.Text.Center, Settings.Text.Outline, Settings.Text.DropShadow)

	if Style ~= nil then
		if Style == RageUI.CheckboxStyle.Tick then
			StyleCheckBox(PosX, PosY, onHovered, Checked, 2, 4)
		elseif Style == RageUI.CheckboxStyle.Cross then
			StyleCheckBox(PosX, PosY, onHovered, Checked, 5, 6)
		else
			StyleCheckBox(PosX, PosY, onHovered, Checked, 2, 4)
		end
	else
		StyleCheckBox(PosX, PosY, onHovered, Checked, 2, 4)
	end

	if onHovered then
		local Selected = false;
		SetMouseCursorSprite(5)
		Colors.Rectangle = { 35, 35, 35, 220 }
		if IsControlJustPressed(0, 24) or IsDisabledControlJustPressed(0, 24) then
			local audioName = Text == "← Retour" and "BACK" or "SELECT"
			PlaySoundFrontend(-1, audioName, "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
			Selected = true
		end
		if (Action) then
			Action(Selected, not Checked)
		end
	end

	ContextUI.Options = ContextUI.Options + 1
	ContextUI.Offset = vector2(PosX, PosY)
end
