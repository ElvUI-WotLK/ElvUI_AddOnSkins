local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
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

	ChatBarFrameBackground:SetOutside()
	ChatBarFrameBackground:SetTemplate("Transparent")

	for i = 1, 20 do
		local button = _G["ChatBarFrameButton" .. i]
		local center = _G["ChatBarFrameButton" .. i .. "Center"]
		local highlight = _G["ChatBarFrameButton" .. i .. "Highlight"]
		local flash = _G["ChatBarFrameButton" .. i .. "Flash"]

		button:StripTextures()
		button:SetTemplate()
		button:SetScale(1)
		button:Size(db.chatBarSize)

		center:SetInside()
		highlight:SetInside()
		flash:SetInside()

		center:SetTexture(1, 1, 1)
		highlight:SetTexture(1, 1, 1, 0.5)
		flash:SetTexture(1, 1, 1, 0.5)

		highlight:SetBlendMode("MOD")
		flash:SetTexture("MOD")
	end

	ChatBarFrame:SetScript("OnUpdate", function(self, elapsed)
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
					frame:Show()
				else
					frame:Hide()
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
		button:ClearAllPoints()
		button.Text:ClearAllPoints()
		button.Text:SetPoint(db.chatBarTextPoint, button, db.chatBarTextPoint, db.chatBarTextXOffset, db.chatBarTextYOffset)

		if ChatBar_VerticalDisplay then
			if ChatBar_AlternateOrientation then
				button:SetPoint("TOP", "ChatBarFrame", "TOP", 0, -db.chatBarSpacing)
			else
				button:SetPoint("BOTTOM", "ChatBarFrame", "BOTTOM", 0, db.chatBarSpacing)
			end
		else
			if ChatBar_AlternateOrientation then
				button:SetPoint("RIGHT", "ChatBarFrame", "RIGHT", -db.chatBarSpacing, 0)
			else
				button:SetPoint("LEFT", "ChatBarFrame", "LEFT", db.chatBarSpacing, 0)
			end
		end

		for i = 2, CHAT_BAR_MAX_BUTTONS do
			button = _G["ChatBarFrameButton"..i]
			button:ClearAllPoints()
			button.Text:ClearAllPoints()
			button.Text:SetPoint(db.chatBarTextPoint, button, db.chatBarTextPoint, db.chatBarTextXOffset, db.chatBarTextYOffset)

			if ChatBar_VerticalDisplay then
				if ChatBar_AlternateOrientation then
					button:SetPoint("TOP", "ChatBarFrameButton"..(i-1), "BOTTOM", 0, -db.chatBarSpacing)
				else
					button:SetPoint("BOTTOM", "ChatBarFrameButton"..(i-1), "TOP", 0, db.chatBarSpacing)
				end
			else
				if ChatBar_AlternateOrientation then
					button:SetPoint("RIGHT", "ChatBarFrameButton"..(i-1), "LEFT", -db.chatBarSpacing, 0)
				else
					button:SetPoint("LEFT", "ChatBarFrameButton"..(i-1), "RIGHT", db.chatBarSpacing, 0)
				end
			end
		end
	end

	hooksecurefunc("ChatBar_UpdateButtons", function()
		local i, buttonIndex = 1, 1

		if not ChatBar_HideAllButtons then
			while ChatBar_ChatTypes[i] and buttonIndex <= 20 do
				if ChatBar_ChatTypes[i].show() then
					_G["ChatBarFrameButton" .. buttonIndex]:Size(db.chatBarSize)
					_G["ChatBarFrameButton" .. buttonIndex]:SetAlpha(1)
					buttonIndex = buttonIndex + 1
				end

				i = i + 1
			end
		end

		local size = (buttonIndex - 1) * (db.chatBarSize + db.chatBarSpacing) + db.chatBarSpacing
		if ChatBar_VerticalDisplay then
			ChatBarFrame:SetWidth(db.chatBarSize + (db.chatBarSpacing * 2))

			if ChatBarFrame:GetTop() then
				ChatBar_StartSlidingTo(size)
			else
				ChatBarFrame:SetHeight(size)
			end
		else
			ChatBarFrame:SetHeight(db.chatBarSize + (db.chatBarSpacing * 2))

			if ChatBarFrame:GetRight() then
				ChatBar_StartSlidingTo(size)
			else
				ChatBarFrame:SetWidth(size)
			end
		end

		while buttonIndex <= 20 do
			_G["ChatBarFrameButton" .. buttonIndex]:SetAlpha(0)
			buttonIndex = buttonIndex + 1
		end
	end)

	ChatBar_UpdateButtonOrientation()

	E:GetModule("Tooltip"):HookScript(ChatBarFrameTooltip, "OnShow", "SetStyle")
end)