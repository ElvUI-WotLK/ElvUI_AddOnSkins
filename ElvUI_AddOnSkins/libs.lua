local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
local AS = E:GetModule("AddOnSkins")

local _G = _G
local select = select

AS.skinnedLibs = {}

local dewdropEditBoxFrame
local dewdropSliderFrame

local function SkinDewdrop2()
	local frame
	local i = 1

	while _G["Dewdrop20Level" .. i] do
		frame = _G["Dewdrop20Level" .. i]

		if not frame.isSkinned then
			frame:SetTemplate("Transparent")

			select(1, frame:GetChildren()):Hide()
			frame.SetBackdropColor = E.noop
			frame.SetBackdropBorderColor = E.noop

			frame.isSkinned = true
		end

		i = i + 1
	end

	i = 1
	while _G["Dewdrop20Button" .. i] do
		if not _G["Dewdrop20Button" .. i].isHook then
			_G["Dewdrop20Button" .. i]:HookScript("OnEnter", function(self)
				if not self.disabled and self.hasArrow then
					if not dewdropEditBoxFrame and self.hasEditBox then
						dewdropEditBoxFrame = AS:FindFrameBySizeChild({"EditBox"}, 200, 40)

						if dewdropEditBoxFrame then
							dewdropEditBoxFrame:SetTemplate("Transparent")
							S:HandleEditBox(dewdropEditBoxFrame.editBox)
							dewdropEditBoxFrame.editBox:DisableDrawLayer("BACKGROUND")
						end
					end
					if not dewdropSliderFrame and self.hasSlider then
						dewdropSliderFrame = AS:FindFrameBySizeChild({"Slider", "EditBox"}, 100, 170)

						if dewdropSliderFrame then
							dewdropSliderFrame:SetTemplate("Transparent")
							S:HandleSliderFrame(dewdropSliderFrame.slider)
							S:HandleEditBox(dewdropSliderFrame.currentText)
							dewdropSliderFrame.currentText:DisableDrawLayer("BACKGROUND")
						end
					end

					SkinDewdrop2()
				end
			end)
			_G["Dewdrop20Button" .. i].isHook = true
		end

		i = i + 1
	end
end

local function SkinTablet2(lib)
	local function SkinDetachedFrame(self, fakeParent, parent)
		if not parent then
			parent = fakeParent
		end
		if self.registry[parent].data.detached then
			local frame
			local i = 1

			while _G["Tablet20DetachedFrame" .. i] do
				frame = _G["Tablet20DetachedFrame" .. i]

				if not frame.isSkinned then
					frame:SetTemplate("Transparent")
					S:HandleSliderFrame(frame.slider)

					frame.isSkinned = true
				end

				i = i + 1
			end
		end
	end

	if not S:IsHooked(lib, "Open") then
		S:SecureHook(lib, "Open", function(self, fakeParent, parent)
			_G["Tablet20Frame"]:SetTemplate("Transparent")
			SkinDetachedFrame(self, fakeParent, parent)
		end)
	end

	if not S:IsHooked(lib, "Detach") then
		S:SecureHook(lib, "Detach", function(self, parent)
			SkinDetachedFrame(self, parent)
		end)
	end
end

local function SkinRockConfig(lib)
	local function SkinMainFrame(self)
		if self.base.isSkinned then return end

		self.base:SetTemplate("Transparent")
		self.base.header:StripTextures()
		S:HandleCloseButton(self.base.closeButton, self.base)

		self.base.treeView:SetTemplate("Transparent")
		S:HandleScrollBar(self.base.treeView.scrollBar)
		S:HandleDropDownBox(self.base.addonChooser)

		self.base.addonChooser.text:Height(20)
		self.base.addonChooser.text:SetTemplate("Transparent")
		S:HandleNextPrevButton(self.base.addonChooser.button, true)
		
		local pullout = _G[self.base.mainPane:GetName().."_ChoicePullout"]
		if pullout then
			pullout:SetTemplate("Transparent")
		else
			S:SecureHookScript(self.base.addonChooser.button, "OnClick", function(self)
				_G[lib.base.mainPane:GetName().."_ChoicePullout"]:SetTemplate("Transparent")
				S:Unhook(self, "OnClick")
			end)
		end

		self.base.mainPane:SetTemplate("Transparent")
		S:HandleScrollBar(self.base.mainPane.scrollBar)

		self.base.treeView.sizer:SetTemplate("Transparent")

		self.base.isSkinned = true
	end

	S:SecureHook(lib, "OpenConfigMenu", function(self)
		SkinMainFrame(self)
		S:Unhook(self, "OpenConfigMenu")
	end)

	local LR = LibStub("LibRock-1.0", true)
	if LR then
		for object in LR:IterateMixinObjects("LibRockConfig-1.0") do
			if not S:IsHooked(object, "OpenConfigMenu") then
				S:SecureHook(object, "OpenConfigMenu", function(self)
					SkinMainFrame(lib)
					S:Unhook(self, "OpenConfigMenu")
				end)
			end
		end
	end
end

function AS:SkinLibrary(name)
	if not name then return end
	if self.skinnedLibs[name] then return end

	if name == "AceAddon-2.0" then
		local AceAddon = LibStub("AceAddon-2.0", true)
		if AceAddon then
			S:SecureHook(AceAddon.prototype, "PrintAddonInfo", function()
				AceAddon20AboutFrame:SetTemplate("Transparent")
				S:HandleButton(AceAddon20AboutFrameButton)
				S:HandleButton(AceAddon20AboutFrameDonateButton)

				S:Unhook(AceAddon.prototype, "PrintAddonInfo")
			end)
			S:SecureHook(AceAddon.prototype, "OpenDonationFrame", function()
				AceAddon20Frame:SetTemplate("Transparent")
				S:HandleScrollBar(AceAddon20FrameScrollFrameScrollBar)
				S:HandleButton(AceAddon20FrameButton)

				S:Unhook(AceAddon.prototype, "OpenDonationFrame")
			end)
			self.skinnedLibs[name] = true
		end
	elseif name == "Dewdrop-2.0" then
		local Dewdrop = LibStub("Dewdrop-2.0", true)
		if Dewdrop and not S:IsHooked(Dewdrop, "Open") then
			S:SecureHook(Dewdrop, "Open", SkinDewdrop2)
			self.skinnedLibs[name] = true
		end
	elseif name == "Tablet-2.0" then
		local Tablet = LibStub("Tablet-2.0", true)
		if Tablet then
			SkinTablet2(Tablet)
			self.skinnedLibs[name] = true
		end
	elseif name == "LibExtraTip-1" then
		local LibExtraTip = LibStub("LibExtraTip-1", true)
		if LibExtraTip and not S:IsHooked(LibExtraTip, "GetFreeExtraTipObject") then
			S:RawHook(LibExtraTip, "GetFreeExtraTipObject", function(self)
				local tooltip = S.hooks[self].GetFreeExtraTipObject(self)

				if not tooltip.isSkinned then
					tooltip:SetTemplate("Transparent")
					tooltip.isSkinned = true
				end

				return tooltip
			end)
			self.skinnedLibs[name] = true
		end
	elseif name == "LibRockConfig-1.0" then
		local LRC = LibStub("LibRockConfig-1.0", true)
		if LRC then
			SkinRockConfig(LRC)
			self.skinnedLibs[name] = true
		end
	elseif name == "ZFrame-1.0" then
		local LZF = LibStub("ZFrame-1.0", true)
		if LZF and not S:IsHooked(LZF, "Create") then
			S:RawHook(LZF, "Create", function(self, ...)
				local frame = S.hooks[self].Create(self, ...)

				frame.ZMain:SetTemplate("Transparent")
				frame.ZMain.close:Size(32)
				S:HandleCloseButton(frame.ZMain.close, frame.ZMain)

				return frame
			end, true)
		end
		self.skinnedLibs[name] = true
	end
end