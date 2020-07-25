local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
local AS = E:GetModule("AddOnSkins")

if not AS:IsAddonLODorEnabled("BuyEmAll") then return end

-- BuyEmAll 2.9.2
-- https://www.curseforge.com/wow/addons/project-2590/files/447131

S:AddCallbackForAddon("BuyEmAll", "BuyEmAll", function()
	if not E.private.addOnSkins.BuyEmAll then return end

	BuyEmAllFrame:StripTextures()
	BuyEmAllFrame:SetTemplate("Transparent")

	local moneyText = CreateFrame("Frame", "BuyEmAllFrameMoneyText", BuyEmAllFrame)
	moneyText:SetAllPoints(BuyEmAllFrame)
	moneyText:CreateBackdrop("Transparent")
	moneyText.backdrop:Point("TOPLEFT", 31, -20)
	moneyText.backdrop:Point("BOTTOMRIGHT", -26, 93)

	S:HandleNextPrevButton(BuyEmAllLeftButton)
	S:HandleNextPrevButton(BuyEmAllRightButton)
	BuyEmAllLeftButton:Size(13, 17)
	BuyEmAllRightButton:Size(13, 17)

	S:HandleButton(BuyEmAllOkayButton)
	S:HandleButton(BuyEmAllCancelButton)
	S:HandleButton(BuyEmAllStackButton)
	S:HandleButton(BuyEmAllMaxButton)
end)