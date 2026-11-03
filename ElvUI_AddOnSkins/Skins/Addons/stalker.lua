local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
-- Optional controls differ between supported addon versions. Keep missing
-- targets out of native skin handlers without masking other Lua errors.
local function SkinControl(method, frame, ...)
	if frame then return S[method](S, frame, ...) end
end
local function SkinFrame(frame, method, ...)
	if frame then return frame[method](frame, ...) end
end

local AS = E:GetModule("AddOnSkins")

if not AS:IsAddonLODorEnabled("Stalker") then return end

-- Stalker 1.2
-- https://wow.curseforge.com/projects/Stalker/files/442604

S:AddCallbackForAddon("Stalker", "Stalker", function()
	if not E.private.addOnSkins.Stalker then return end

	SkinFrame(Stalker_AlertWindow, "StripTextures")
	SkinFrame(Stalker_AlertWindow, "SetTemplate", "Transparent")
	SkinFrame(Stalker_AlertWindow, "Point", "TOP", UIParent, "TOP", 0, -130)

	Stalker.AlertWindow.Title:FontTemplate(nil, 12)
	Stalker.AlertWindow.Name:FontTemplate(nil, 12)
	Stalker.AlertWindow.Location:FontTemplate(nil, 12)

	SkinFrame(Stalker_MainWindow, "StripTextures")
	SkinFrame(Stalker_MainWindow, "SetTemplate", "Transparent")

	for i = 1, 5 do
		local bar = _G["Stalker_MainWindow_Bar"..i]

		SkinFrame(bar, "StyleButton")
		bar.StatusBar:SetStatusBarTexture(E["media"].normTex)
		bar.LeftText:FontTemplate(nil, 12)
		bar.RightText:FontTemplate(nil, 12)
	end

	Stalker.MainWindow.Title:FontTemplate(nil, 12)

	SkinControl("HandleCloseButton", Stalker_MainWindow.CloseButton)
	Stalker_MainWindow.CloseButton:Size(32)
	Stalker_MainWindow.CloseButton:Point("TOPRIGHT", 2, -6)

	SkinControl("HandleNextPrevButton", Stalker_MainWindow.RightButton)
	S:SetNextPrevButtonDirection(Stalker_MainWindow.RightButton, "right")
	Stalker_MainWindow.RightButton:Size(16)
	Stalker_MainWindow.RightButton:Point("TOPRIGHT", -27, -14)

	SkinControl("HandleNextPrevButton", Stalker_MainWindow.LeftButton)
	S:SetNextPrevButtonDirection(Stalker_MainWindow.LeftButton, "left")
	Stalker_MainWindow.LeftButton:Size(16)
	Stalker_MainWindow.LeftButton:Point("RIGHT", Stalker_MainWindow.RightButton, "LEFT", -3, 0)

	SkinControl("HandleNextPrevButton", Stalker_MainWindow.ClearButton)
	S:SetNextPrevButtonDirection(Stalker_MainWindow.ClearButton, "down")
	Stalker_MainWindow.ClearButton:Size(16)
	Stalker_MainWindow.ClearButton:Point("RIGHT", Stalker_MainWindow.LeftButton, "LEFT", -3, 0)

	Stalker_MainWindow.DragBottomLeft:SetNormalTexture(nil)
	Stalker_MainWindow.DragBottomRight:SetNormalTexture(nil)

	hooksecurefunc(Stalker, "ShowMapTooltip", function()
		if Stalker.MapTooltip then
			Stalker.MapTooltip:SetTemplate("Transparent")
		end
	end)
end)
