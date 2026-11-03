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

if not AS:IsAddonLODorEnabled("BuyEmAll") then return end

-- BuyEmAll 2.9.2

S:AddCallbackForAddon("BuyEmAll", "BuyEmAll", function()
	if not E.private.addOnSkins.BuyEmAll then return end

	SkinFrame(BuyEmAllFrame, "StripTextures")
	SkinFrame(BuyEmAllFrame, "SetTemplate", "Transparent")

	local moneyTextBG = CreateFrame("Frame", "BuyEmAllFrameMoneyTexBG", BuyEmAllFrame)
	SkinFrame(moneyTextBG, "SetTemplate", "Default")
	SkinFrame(moneyTextBG, "Size", 113, 21)
	SkinFrame(moneyTextBG, "Point", "TOPLEFT", 32, -20)

	BuyEmAllText:SetParent(BuyEmAllFrameMoneyTexBG)
	SkinFrame(BuyEmAllText, "Point", "RIGHT", BuyEmAllFrameMoneyTex, "RIGHT", -12, 0)

	SkinControl("HandleNextPrevButton", BuyEmAllLeftButton)
	SkinControl("HandleNextPrevButton", BuyEmAllRightButton)
	SkinFrame(BuyEmAllLeftButton, "Size", 13, 17)
	SkinFrame(BuyEmAllRightButton, "Size", 13, 17)

	SkinFrame(BuyEmAllMoneyFrame, "Point", "TOP", BuyEmAllFrameMoneyTex, "BOTTOM", 7, 6)

	SkinControl("HandleButton", BuyEmAllOkayButton)
	SkinControl("HandleButton", BuyEmAllCancelButton)
	SkinControl("HandleButton", BuyEmAllStackButton)
	SkinControl("HandleButton", BuyEmAllMaxButton)
end)
