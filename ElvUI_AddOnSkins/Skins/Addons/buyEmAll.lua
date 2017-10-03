local E, L, V, P, G = unpack(ElvUI);
local S = E:GetModule("Skins");

-- BuyEmAll 2.9.2

local function LoadSkin()
	if(not E.private.addOnSkins.BuyEmAll) then return; end

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
end

S:AddCallbackForAddon("BuyEmAll", "BuyEmAll", LoadSkin);