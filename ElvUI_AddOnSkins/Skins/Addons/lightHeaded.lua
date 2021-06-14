local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
local AS = E:GetModule("AddOnSkins")

if not AS:IsAddonLODorEnabled("LightHeaded") then return end

local cos, pi = math.cos, math.pi

-- LightHeaded r310

S:AddCallbackForAddon("LightHeaded", "LightHeaded", function()
	if not E.private.addOnSkins.LightHeaded then return end

	LightHeadedFrame:StripTextures()
	LightHeadedFrame:SetTemplate("Transparent")
	LightHeadedFrame:Height(424)
	LightHeadedFrame:Point("LEFT", QuestLogFrame, "RIGHT", -2, 0)

	LightHeadedFrame.handle:SetParent(QuestLogFrame) -- ignore LightHeadedFrame alpha
	LightHeadedFrame.handle:StripTextures()
	LightHeadedFrame.handle:SetTemplate("Default")
	LightHeadedFrame.handle:Point("LEFT", LightHeadedFrame, "RIGHT", -1, 0)

	LightHeadedSearchBox:Width(281)
	LightHeadedSearchBox:Point("TOP", LightHeadedFrame, "TOP", 0, -30)
	S:HandleEditBox(LightHeadedSearchBox)

	S:HandleCloseButton(LightHeadedFrame.close, LightHeadedFrame)

	LightHeadedScrollFrame:CreateBackdrop("Transparent")
	LightHeadedScrollFrame.backdrop:Point("TOPLEFT", -1, 2)
	LightHeadedScrollFrame.backdrop:Point("BOTTOMRIGHT", 1, -2)

	LightHeadedScrollFrame:Point("TOPLEFT", 9, -75)
	LightHeadedScrollFrame:Point("BOTTOMRIGHT", -30, 55)

	LightHeadedScrollFrameScrollBar:Point("TOPLEFT", LightHeadedScrollFrame, "TOPRIGHT", 4, -17)
	LightHeadedScrollFrameScrollBar:Point("BOTTOMLEFT", LightHeadedScrollFrame, "BOTTOMRIGHT", 4, 17)

	S:HandleNextPrevButton(LightHeadedFrameSub.next, "right")
	S:HandleNextPrevButton(LightHeadedFrameSub.prev, "left")

	S:HandleScrollBar(LightHeadedScrollFrameScrollBar)

	LightHeadedTooltip:SetTemplate("Transparent")
	hooksecurefunc(LightHeaded, "OnHyperlinkEnter", function()
		local backdrop = E.media.backdropfadecolor
		local border = E.media.bordercolor
		LightHeadedTooltip:SetBackdropColor(backdrop[1], backdrop[2], backdrop[3], backdrop[4])
		LightHeadedTooltip:SetBackdropBorderColor(border[1], border[2], border[3])
	end)
	hooksecurefunc(LightHeaded, "OnHyperlinkClick", function()
		LightHeadedTooltip:Hide()
	end)

	local QLFrameOffsetXOpened, QLFrameOffsetXClosed = -2, -326

	local function UpdatePosition()
		if LightHeaded.db.profile.open then
			LightHeadedFrame:Point("LEFT", QuestLogFrame, "RIGHT", QLFrameOffsetXOpened, 0)
		else
			LightHeadedFrame:SetAlpha(0)
			LightHeadedFrameSub:SetAlpha(1)
			LightHeadedFrame:Point("LEFT", QuestLogFrame, "RIGHT", QLFrameOffsetXClosed, 0)
		end
	end

	UpdatePosition()

	hooksecurefunc(LightHeaded, "LockUnlockFrame", function()
		LightHeadedFrame:Height(424)
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
			self:SetScript("OnUpdate", nil)

			if not LightHeaded.db.profile.open then
				if LightHeadedFrameSub.justclosed then
					LightHeadedFrameSub.justclosed = false
					LightHeadedFrameSub:Hide()

					self:SetAlpha(0)
				else
					LightHeaded.db.profile.open = true

					self:SetAlpha(1)
				end
			end

			return
		elseif count == 1 then
			if LightHeaded.db.profile.open then
				LightHeaded.db.profile.open = false
				LightHeadedFrameSub.justclosed = true
			else
				LightHeadedFrameSub:Show()
				LightHeaded:SelectQuestLogEntry()
			end
		end

		local status = mod * totalElapsed
		local offset = cosineInterpolation(closedX, openedX, status)

		self:Point("LEFT", QuestLogFrame, "RIGHT", offset, 0)
		self:SetAlpha(LightHeaded.db.profile.lhopen and (1 - status) or status)
	end

	LightHeadedFrame.handle:SetScript("OnClick", function()
		LightHeadedFrame:SetScript("OnUpdate", OnUpdate)

		if LightHeaded.db.profile.sound then
			PlaySoundFile("Sound\\Doodad\\Karazahn_WoodenDoors_Close_A.wav")
		end

		LightHeaded.db.profile.lhopen = not LightHeaded.db.profile.lhopen
	end)

	LightHeaded.ChangeBGAlpha = E.noop
end)