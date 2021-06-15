local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
local AS = E:GetModule("AddOnSkins")

if not AS:IsAddonLODorEnabled("BuyEmAll") then return end

-- BuyEmAll 2.9.2

S:AddCallbackForAddon("BuyEmAll", "BuyEmAll", function()
	if not E.private.addOnSkins.BuyEmAll then return end

	BuyEmAllFrame:StripTextures()
	BuyEmAllFrame:SetTemplate("Transparent")

	local moneyTextBG = CreateFrame("Frame", "BuyEmAllFrameMoneyTexBG", BuyEmAllFrame)
	moneyTextBG:SetTemplate("Default")
	moneyTextBG:Size(113, 21)
	moneyTextBG:Point("TOPLEFT", 32, -20)

	BuyEmAllText:SetParent(BuyEmAllFrameMoneyTexBG)
	BuyEmAllText:Point("RIGHT", BuyEmAllFrameMoneyTex, "RIGHT", -12, 0)

	S:HandleNextPrevButton(BuyEmAllLeftButton)
	S:HandleNextPrevButton(BuyEmAllRightButton)
	BuyEmAllLeftButton:Size(13, 17)
	BuyEmAllRightButton:Size(13, 17)

	BuyEmAllMoneyFrame:Point("TOP", BuyEmAllFrameMoneyTex, "BOTTOM", 7, 6)

	S:HandleButton(BuyEmAllOkayButton)
	S:HandleButton(BuyEmAllCancelButton)
	S:HandleButton(BuyEmAllStackButton)
	S:HandleButton(BuyEmAllMaxButton)
end)