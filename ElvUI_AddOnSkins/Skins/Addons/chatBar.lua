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

if not AS:IsAddonLODorEnabled("ChatBar") then return end

local _G = _G
local abs = math.abs

-- ChatBar 3.1

S:AddCallbackForAddon("ChatBar", "ChatBar", function()
	if not E.private.addOnSkins.ChatBar then return end

	local db = E.db.addOnSkins

	if ChatBar_ButtonScale then
		ChatBar_ButtonScale = 1
	end

	ChatBar_UpdateArt = E.noop
	ChatBar_Toggle_LargeButtons = E.noop

	SkinFrame(ChatBarFrameBackground, "SetOutside")
	SkinFrame(ChatBarFrameBackground, "SetTemplate", "Transparent")

	for i = 1, 20 do
		local button = _G["ChatBarFrameButton" .. i]
		local center = _G["ChatBarFrameButton" .. i .. "Center"]
		local highlight = _G["ChatBarFrameButton" .. i .. "Highlight"]
		local flash = _G["ChatBarFrameButton" .. i .. "Flash"]

		SkinFrame(button, "StripTextures")
		SkinFrame(button, "SetTemplate")
		SkinFrame(button, "SetScale", 1)
		SkinFrame(button, "Size", db.chatBarSize)

		SkinFrame(center, "SetInside")
		SkinFrame(highlight, "SetInside")
		SkinFrame(flash, "SetInside")

		center:SetTexture(1, 1, 1)
		highlight:SetTexture(1, 1, 1, 0.5)
		flash:SetTexture(1, 1, 1, 0.5)

		highlight:SetBlendMode("MOD")
		flash:SetTexture("MOD")
	end

	SkinFrame(ChatBarFrame, "SetScript", "OnUpdate", function(self, elapsed)
		if self.slidingEnabled and self.isSliding and self.velocity and self.endsize then
			local currSize = ChatBar_GetSize()

			if abs(currSize - self.endsize) < ConstantSnapLimit then
				ChatBar_SetSize(self.endsize)
				ChatBarFrame.isSliding = nil
				self.velocity = 0

				if ChatBar_VerticalDisplay_Sliding or ChatBar_AlternateDisplay_Sliding or ChatBar_LargeButtons_Sliding then
					if ChatBar_VerticalDisplay_Sliding then
						ChatBar_VerticalDisplay_Sliding = nil
						ChatBar_Toggle_VerticalButtonOrientation()
					elseif ChatBar_AlternateDisplay_Sliding then
						ChatBar_AlternateDisplay_Sliding = nil
						ChatBar_Toggle_AlternateButtonOrientation()
					elseif ChatBar_LargeButtons_Sliding then
						ChatBar_LargeButtons_Sliding = nil
						ChatBar_UpdateButtons()
					end

					ChatBar_UpdateOrientationPoint()
				else
					ChatBar_UpdateOrientationPoint(true)
				end
			else
				local desiredVelocity = ConstantVelocityModifier * (self.endsize - currSize)
				local acceleration = ConstantJerk * (desiredVelocity - self.velocity)

				self.velocity = self.velocity + acceleration * elapsed
				ChatBar_SetSize(currSize + self.velocity * elapsed)
			end

			local frame
			for i = 1, CHAT_BAR_MAX_BUTTONS do
				frame = _G["ChatBarFrameButton" .. i]
				if currSize >= (i * (db.chatBarSize + db.chatBarSpacing) - db.chatBarSpacing) then
					SkinFrame(frame, "Show")
				else
					SkinFrame(frame, "Hide")
				end
			end
		elseif self.count then
			if self.count > CHAT_BAR_UPDATE_DELAY then
				self.count = nil
				ChatBarFrame.slidingEnabled = true
				ChatBar_UpdateButtons()
			else
				self.count = self.count + 1
			end
		end
	end)

	function ChatBar_UpdateButtonOrientation()
		local button = ChatBarFrameButton1
		SkinFrame(button, "ClearAllPoints")
		button.Text:ClearAllPoints()
		button.Text:SetPoint(db.chatBarTextPoint, button, db.chatBarTextPoint, db.chatBarTextXOffset, db.chatBarTextYOffset)

		if ChatBar_VerticalDisplay then
			if ChatBar_AlternateOrientation then
				SkinFrame(button, "SetPoint", "TOP", "ChatBarFrame", "TOP", 0, -db.chatBarSpacing)
			else
				SkinFrame(button, "SetPoint", "BOTTOM", "ChatBarFrame", "BOTTOM", 0, db.chatBarSpacing)
			end
		else
			if ChatBar_AlternateOrientation then
				SkinFrame(button, "SetPoint", "RIGHT", "ChatBarFrame", "RIGHT", -db.chatBarSpacing, 0)
			else
				SkinFrame(button, "SetPoint", "LEFT", "ChatBarFrame", "LEFT", db.chatBarSpacing, 0)
			end
		end

		for i = 2, CHAT_BAR_MAX_BUTTONS do
			button = _G["ChatBarFrameButton"..i]
			SkinFrame(button, "ClearAllPoints")
			button.Text:ClearAllPoints()
			button.Text:SetPoint(db.chatBarTextPoint, button, db.chatBarTextPoint, db.chatBarTextXOffset, db.chatBarTextYOffset)

			if ChatBar_VerticalDisplay then
				if ChatBar_AlternateOrientation then
					SkinFrame(button, "SetPoint", "TOP", "ChatBarFrameButton"..(i-1), "BOTTOM", 0, -db.chatBarSpacing)
				else
					SkinFrame(button, "SetPoint", "BOTTOM", "ChatBarFrameButton"..(i-1), "TOP", 0, db.chatBarSpacing)
				end
			else
				if ChatBar_AlternateOrientation then
					SkinFrame(button, "SetPoint", "RIGHT", "ChatBarFrameButton"..(i-1), "LEFT", -db.chatBarSpacing, 0)
				else
					SkinFrame(button, "SetPoint", "LEFT", "ChatBarFrameButton"..(i-1), "RIGHT", db.chatBarSpacing, 0)
				end
			end
		end
	end

	hooksecurefunc("ChatBar_UpdateButtons", function()
		local i, buttonIndex = 1, 1

		if not ChatBar_HideAllButtons then
			while ChatBar_ChatTypes[i] and buttonIndex <= 20 do
				if ChatBar_ChatTypes[i].show() then
					SkinFrame(_G["ChatBarFrameButton" .. buttonIndex], "Size", db.chatBarSize)
					SkinFrame(_G["ChatBarFrameButton" .. buttonIndex], "SetAlpha", 1)
					buttonIndex = buttonIndex + 1
				end

				i = i + 1
			end
		end

		local size = (buttonIndex - 1) * (db.chatBarSize + db.chatBarSpacing) + db.chatBarSpacing
		if ChatBar_VerticalDisplay then
			SkinFrame(ChatBarFrame, "SetWidth", db.chatBarSize + (db.chatBarSpacing * 2))

			if ChatBarFrame:GetTop() then
				ChatBar_StartSlidingTo(size)
			else
				SkinFrame(ChatBarFrame, "SetHeight", size)
			end
		else
			SkinFrame(ChatBarFrame, "SetHeight", db.chatBarSize + (db.chatBarSpacing * 2))

			if ChatBarFrame:GetRight() then
				ChatBar_StartSlidingTo(size)
			else
				SkinFrame(ChatBarFrame, "SetWidth", size)
			end
		end

		while buttonIndex <= 20 do
			SkinFrame(_G["ChatBarFrameButton" .. buttonIndex], "SetAlpha", 0)
			buttonIndex = buttonIndex + 1
		end
	end)

	ChatBar_UpdateButtonOrientation()

	E:GetModule("Tooltip"):HookScript(ChatBarFrameTooltip, "OnShow", "SetStyle")
end)
