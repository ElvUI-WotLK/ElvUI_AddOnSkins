local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
local AS = E:GetModule("AddOnSkins")

if not AS:IsAddonLODorEnabled("Stalker") then return end

-- Stalker 1.2
-- https://wow.curseforge.com/projects/Stalker/files/442604

S:AddCallbackForAddon("Stalker", "Stalker", function()
	if not E.private.addOnSkins.Stalker then return end

	Stalker_AlertWindow:StripTextures()
	Stalker_AlertWindow:SetTemplate("Transparent")
	Stalker_AlertWindow:Point("TOP", UIParent, "TOP", 0, -130)

	Stalker.AlertWindow.Title:FontTemplate(nil, 12)
	Stalker.AlertWindow.Name:FontTemplate(nil, 12)
	Stalker.AlertWindow.Location:FontTemplate(nil, 12)

	Stalker_MainWindow:StripTextures()
	Stalker_MainWindow:SetTemplate("Transparent")

	for i = 1, 5 do
		local bar = _G["Stalker_MainWindow_Bar"..i]

		bar:StyleButton()
		bar.StatusBar:SetStatusBarTexture(E["media"].normTex)
		bar.LeftText:FontTemplate(nil, 12)
		bar.RightText:FontTemplate(nil, 12)
	end

	Stalker.MainWindow.Title:FontTemplate(nil, 12)

	S:HandleCloseButton(Stalker_MainWindow.CloseButton)
	Stalker_MainWindow.CloseButton:Size(32)
	Stalker_MainWindow.CloseButton:Point("TOPRIGHT", 2, -6)

	S:HandleNextPrevButton(Stalker_MainWindow.RightButton)
	S:SetNextPrevButtonDirection(Stalker_MainWindow.RightButton, "right")
	Stalker_MainWindow.RightButton:Size(16)
	Stalker_MainWindow.RightButton:Point("TOPRIGHT", -27, -14)

	S:HandleNextPrevButton(Stalker_MainWindow.LeftButton)
	S:SetNextPrevButtonDirection(Stalker_MainWindow.LeftButton, "left")
	Stalker_MainWindow.LeftButton:Size(16)
	Stalker_MainWindow.LeftButton:Point("RIGHT", Stalker_MainWindow.RightButton, "LEFT", -3, 0)

	S:HandleNextPrevButton(Stalker_MainWindow.ClearButton)
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