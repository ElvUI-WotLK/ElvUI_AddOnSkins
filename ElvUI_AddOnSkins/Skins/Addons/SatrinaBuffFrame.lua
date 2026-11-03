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

if not AS:IsAddonLODorEnabled("SatrinaBuffFrame") then return end

local _G = _G
local ipairs = ipairs
local unpack = unpack

-- SatrinaBuffFrame 3.1.20

S:AddCallbackForAddon("SatrinaBuffFrame", "SatrinaBuffFrame", function()
	if not E.private.addOnSkins.SatrinaBuffFrame then return end

	local SBF = LibStub("AceAddon-3.0"):GetAddon("SBF", true)
	if not SBF then return end

	local function skinIcon(frame)
		if frame.isSkinned then return end

		frame.icon:SetTexCoord(unpack(E.TexCoords))
		frame.icon:CreateBackdrop("Default")

		frame.border:Kill()

		frame.isSkinned = true
	end

	local function skinBar(frame)
		if frame.isSkinned then return end

		SkinFrame(frame, "SetFrameLevel", frame:GetFrameLevel() + 1)
		SkinFrame(frame, "StripTextures")
		frame:CreateBackdrop("Transparent")

		frame.isSkinned = true
	end

	do
		local iconCount = 0
		local barCount = 0

		for _, frame in ipairs(SBF.frames) do
			for _, slot in ipairs(frame.slots) do
				if slot.icon then
					skinIcon(slot.icon)
					iconCount = iconCount + 1
				end
				if slot.bar then
					skinBar(slot.bar)
					barCount = barCount + 1
				end
			end
		end

		local i = iconCount + 1
		local frame = _G["SBFBuffIcon"..i]

		while frame do
			skinIcon(frame)
			i = i + 1
			frame = _G["SBFBuffIcon"..i]
		end

		i = barCount + 1
		frame = _G["SBFBuffBar"..i]

		while frame do
			skinBar(frame)
			i = i + 1
			frame = _G["SBFBuffBar"..i]
		end
	end

	S:RawHook(SBF, "GetIcon", function(self)
		local element = S.hooks[SBF].GetIcon(self)
		skinIcon(element)
		return element
	end)

	S:RawHook(SBF, "GetBar", function(self)
		local element = S.hooks[SBF].GetBar(self)
		skinBar(element)
		return element
	end)
end)
