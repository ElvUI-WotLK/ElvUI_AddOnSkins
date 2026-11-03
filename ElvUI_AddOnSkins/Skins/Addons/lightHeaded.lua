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

if not AS:IsAddonLODorEnabled("LightHeaded") then return end

local cos, pi = math.cos, math.pi

-- LightHeaded r310

S:AddCallbackForAddon("LightHeaded", "LightHeaded", function()
	if not E.private.addOnSkins.LightHeaded then return end

	SkinFrame(LightHeadedFrame, "StripTextures")
	SkinFrame(LightHeadedFrame, "SetTemplate", "Transparent")
	SkinFrame(LightHeadedFrame, "Height", 424)
	SkinFrame(LightHeadedFrame, "Point", "LEFT", QuestLogFrame, "RIGHT", -2, 0)

	LightHeadedFrame.handle:SetParent(QuestLogFrame) -- ignore LightHeadedFrame alpha
	LightHeadedFrame.handle:StripTextures()
	LightHeadedFrame.handle:SetTemplate("Default")
	LightHeadedFrame.handle:Point("LEFT", LightHeadedFrame, "RIGHT", -1, 0)

	SkinFrame(LightHeadedSearchBox, "Width", 281)
	SkinFrame(LightHeadedSearchBox, "Point", "TOP", LightHeadedFrame, "TOP", 0, -30)
	SkinControl("HandleEditBox", LightHeadedSearchBox)

	SkinControl("HandleCloseButton", LightHeadedFrame.close, LightHeadedFrame)

	LightHeadedScrollFrame:CreateBackdrop("Transparent")
	LightHeadedScrollFrame.backdrop:Point("TOPLEFT", -1, 2)
	LightHeadedScrollFrame.backdrop:Point("BOTTOMRIGHT", 1, -2)

	SkinFrame(LightHeadedScrollFrame, "Point", "TOPLEFT", 9, -75)
	SkinFrame(LightHeadedScrollFrame, "Point", "BOTTOMRIGHT", -30, 55)

	SkinFrame(LightHeadedScrollFrameScrollBar, "Point", "TOPLEFT", LightHeadedScrollFrame, "TOPRIGHT", 4, -17)
	SkinFrame(LightHeadedScrollFrameScrollBar, "Point", "BOTTOMLEFT", LightHeadedScrollFrame, "BOTTOMRIGHT", 4, 17)

	SkinControl("HandleNextPrevButton", LightHeadedFrameSub.next, "right")
	SkinControl("HandleNextPrevButton", LightHeadedFrameSub.prev, "left")

	SkinControl("HandleScrollBar", LightHeadedScrollFrameScrollBar)

	SkinFrame(LightHeadedTooltip, "SetTemplate", "Transparent")
	hooksecurefunc(LightHeaded, "OnHyperlinkEnter", function()
		local backdrop = E.media.backdropfadecolor
		local border = E.media.bordercolor
		SkinFrame(LightHeadedTooltip, "SetBackdropColor", backdrop[1], backdrop[2], backdrop[3], backdrop[4])
		SkinFrame(LightHeadedTooltip, "SetBackdropBorderColor", border[1], border[2], border[3])
	end)
	hooksecurefunc(LightHeaded, "OnHyperlinkClick", function()
		SkinFrame(LightHeadedTooltip, "Hide")
	end)

	local QLFrameOffsetXOpened, QLFrameOffsetXClosed = -2, -326

	local function UpdatePosition()
		if LightHeaded.db.profile.open then
			SkinFrame(LightHeadedFrame, "Point", "LEFT", QuestLogFrame, "RIGHT", QLFrameOffsetXOpened, 0)
		else
			SkinFrame(LightHeadedFrame, "SetAlpha", 0)
			SkinFrame(LightHeadedFrameSub, "SetAlpha", 1)
			SkinFrame(LightHeadedFrame, "Point", "LEFT", QuestLogFrame, "RIGHT", QLFrameOffsetXClosed, 0)
		end
	end

	UpdatePosition()

	hooksecurefunc(LightHeaded, "LockUnlockFrame", function()
		SkinFrame(LightHeadedFrame, "Height", 424)
		UpdatePosition()
	end)

	local function cosineInterpolation(y1, y2, mu)
		return y1 + (y2 - y1) * (1 - cos(pi * mu)) / 2
	end

	local openedX, closedX = QLFrameOffsetXOpened, QLFrameOffsetXClosed
	local timeToFade = 1.5
	local mod = 1 / timeToFade

	if LightHeaded.db.profile.open then
		openedX, closedX = closedX, openedX
	end

	local count = 0
	local totalElapsed = 0
	local function OnUpdate(self, elapsed)
		count = count + 1
		totalElapsed = totalElapsed + elapsed

		if totalElapsed >= timeToFade then
			local temp = openedX
			openedX = closedX
			closedX = temp
			count = 0
			totalElapsed = 0
			SkinFrame(self, "SetScript", "OnUpdate", nil)

			if not LightHeaded.db.profile.open then
				if LightHeadedFrameSub.justclosed then
					LightHeadedFrameSub.justclosed = false
					SkinFrame(LightHeadedFrameSub, "Hide")

					SkinFrame(self, "SetAlpha", 0)
				else
					LightHeaded.db.profile.open = true

					SkinFrame(self, "SetAlpha", 1)
				end
			end

			return
		elseif count == 1 then
			if LightHeaded.db.profile.open then
				LightHeaded.db.profile.open = false
				LightHeadedFrameSub.justclosed = true
			else
				SkinFrame(LightHeadedFrameSub, "Show")
				LightHeaded:SelectQuestLogEntry()
			end
		end

		local status = mod * totalElapsed
		local offset = cosineInterpolation(closedX, openedX, status)

		SkinFrame(self, "Point", "LEFT", QuestLogFrame, "RIGHT", offset, 0)
		SkinFrame(self, "SetAlpha", LightHeaded.db.profile.lhopen and (1 - status) or status)
	end

	LightHeadedFrame.handle:SetScript("OnClick", function()
		SkinFrame(LightHeadedFrame, "SetScript", "OnUpdate", OnUpdate)

		if LightHeaded.db.profile.sound then
			PlaySoundFile("Sound\\Doodad\\Karazahn_WoodenDoors_Close_A.wav")
		end

		LightHeaded.db.profile.lhopen = not LightHeaded.db.profile.lhopen
	end)

	LightHeaded.ChangeBGAlpha = E.noop
end)
