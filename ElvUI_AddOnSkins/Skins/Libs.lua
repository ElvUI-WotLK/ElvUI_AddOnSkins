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
		S:HandleNextPrevButton(self.base.addonChooser.button)

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

local function SkinConfigator(lib)
	local function skinSlider(obj)
		obj:StripTextures()
		obj:SetTemplate("Default")
		obj:Height(12)
		obj:SetThumbTexture(E["media"].blankTex)
		obj:GetThumbTexture():SetVertexColor(0.3, 0.3, 0.3)
		obj:GetThumbTexture():Size(10)
	end

	local function skinEditBox(obj)
		if not obj then return end

		local objName = obj:GetName()
		if objName then
			_G[objName.."Left"]:Kill()
			_G[objName.."Middle"]:Kill()
			_G[objName.."Right"]:Kill()
		end

		obj:Height(17)
		obj:CreateBackdrop("Default")
		obj.backdrop:Point("TOPLEFT", -2, 0)
		obj.backdrop:Point("BOTTOMRIGHT", 2, 0)
		obj.backdrop:SetParent(obj:GetParent())
		obj:SetParent(obj.backdrop)
	end

	local function skinObject(obj)
		if not obj then return end

		local objType = obj:GetObjectType()

	--	if objType == "FontString" then
		if objType == "CheckButton" then
			S:HandleCheckBox(obj)
		elseif objType == "Slider" then
			skinSlider(obj)

			if obj.slave then
				skinEditBox(obj.slave)
			end
		elseif objType == "EditBox" then
			skinEditBox(obj)
		elseif objType == "Button" then
			S:HandleButton(obj, true)
		elseif objType == "Frame" then
			if obj.stype == "SelectBox" then
				obj.clearance = 3

				obj:StripTextures()
				obj:CreateBackdrop("Default")
				obj.backdrop:SetPoint("TOPLEFT", 15, -1)
				obj.backdrop:SetPoint("BOTTOMRIGHT", -16, -1)
				_G[obj:GetName().."Text"]:SetParent(obj.backdrop)

				obj.button:SetPoint("TOPRIGHT", -18, -3)
				S:HandleNextPrevButton(obj.button)
				S:SetNextPrevButtonDirection(obj.button)
			elseif obj.stype == "MoneyFrame"
			or obj.stype == "PinnedMoney"
			or obj.stype == "MoneyFramePinned" then
				local objName = obj:GetName()
				if objName then
					skinEditBox(_G[objName.."Gold"])
					skinEditBox(_G[objName.."Silver"])
					skinEditBox(_G[objName.."Copper"])
				else
					for i = 1, obj:GetNumChildren() do
						local child = select(i, obj:GetChildren())
						if child and child:IsObjectType("EditBox") then
							skinEditBox(child)
						end
					end
				end
			end
		end
	end

	local function skinTab(self)
		self.tabs[#self.tabs].frame:SetTemplate("Transparent")
	end

	local function skinScroll(self, id)
		local tab = self.tabs[id]
		if tab.scroll.isSkinned then return end

		if tab.scroll.vScroll then
			S:HandleScrollBar(tab.scroll.vScroll, 1)
		end
		if tab.scroll.hScroll then
			S:HandleScrollBar(tab.scroll.hScroll, 1)
		end

		tab.scroll.isSkinned = true
	end

	local function skinControl(self, id, cType, ...)
		local obj = S.hooks[self].AddControl(self, id, cType, ...)

		skinObject(obj)

		return obj
	end

	S:RawHook(lib, "Create", function(self, ...)
		local gui = S.hooks[self].Create(self, ...)

		_G[gui:GetName() .. "Backdrop"]:SetTemplate("Transparent")
		S:HandleButton(gui.Done)

		hooksecurefunc(gui, "AddTab", skinTab)
		hooksecurefunc(gui, "MakeScrollable", skinScroll)
		S:RawHook(gui, "AddControl", skinControl)

		return gui
	end)

	if #lib.frames > 0 then
		for _, frame in ipairs(lib.frames) do
			frame.Backdrop:SetTemplate("Transparent")
			S:HandleButton(frame.Done)

			for _, tab in ipairs(frame.tabs) do
				if tab.frame then
					tab.frame:SetTemplate("Transparent")
				end

				if tab.scroll then
					if tab.scroll.vScroll then
						S:HandleScrollBar(tab.scroll.vScroll, 1)
					end
					if tab.scroll.hScroll then
						S:HandleScrollBar(tab.scroll.hScroll, 1)
					end
				end

				if tab.frame.ctrls then
					for _, entry in ipairs(tab.frame.ctrls) do
						for _, object in ipairs(entry.kids) do
							skinObject(object)
						end
					end
				end
			end
		end
	end

	lib.tooltip:SetTemplate("Transparent")

	lib.help:SetTemplate("Transparent")
	lib.help.scroll:SetTemplate("Transparent")
	S:HandleScrollBar(lib.help.scroll.vScroll, 1)
	S:HandleCloseButton(lib.help.close)

	local SelectBox = LibStub("SelectBox")
	SelectBox.menu.back:SetTemplate("Transparent")
	SelectBox.menu.isSkinned = true

	local ScrollSheet = LibStub("ScrollSheet", true)
	if ScrollSheet then
		S:RawHook(ScrollSheet, "Create", function(self, ...)
			local sheet = S.hooks[self].Create(self, ...)

			if not sheet.panel.isSkinned then
				if sheet.panel.vScroll then
					S:HandleScrollBar(sheet.panel.vScroll, 1)
				end
				if sheet.panel.hScroll then
					S:HandleScrollBar(sheet.panel.hScroll, 1)
				end

				sheet.panel.isSkinned = true
			end

			return sheet
		end, true)
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
	elseif name == "Configator" then
		local Configator = LibStub("Configator", true)
		if Configator then
			SkinConfigator(Configator)
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