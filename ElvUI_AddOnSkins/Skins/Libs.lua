local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
local AS = E:GetModule("AddOnSkins")

local _G = _G
local ipairs = ipairs
local select = select

local hooksecurefunc = hooksecurefunc

AS.skinnedLibs = {}

local function SkinDewdrop(lib, libName)
	local dewdropEditBoxFrame
	local dewdropSliderFrame

	local function DewdropOpen(prefix)
		local level = prefix.."Level"
		local button = prefix.."Button"

		local i = 1
		local frame = _G[level .. i]

		while frame do
			if not frame.isSkinned then
				frame:SetTemplate("Transparent")

				frame:GetChildren():Hide()
				frame.SetBackdropColor = E.noop
				frame.SetBackdropBorderColor = E.noop

				frame.isSkinned = true
			end

			i = i + 1
			frame = _G[level .. i]
		end

		i = 1
		frame = _G[button .. i]

		while frame do
			if not frame.isHook then
				frame:HookScript("OnEnter", function(self)
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

						DewdropOpen(prefix)
					end
				end)

				frame.isHook = true
			end

			i = i + 1
			frame = _G[button .. i]
		end
	end

	if not S:IsHooked(lib, "Open") then
		S:SecureHook(lib, "Open", function()
			DewdropOpen(libName == "Dewdrop-2.0" and "Dewdrop20" or "ArkDewdrop30")
		end)
	end

	return true
end

local function SkinTablet2(lib)
	local function SkinDetachedFrame(self, fakeParent, parent)
		if not parent then
			parent = fakeParent
		end
		if self.registry[parent].data.detached then
			local i = 1
			local frame = _G["Tablet20DetachedFrame" .. i]

			while frame do
				if not frame.isSkinned then
					frame:SetTemplate("Transparent")
					S:HandleSliderFrame(frame.slider)

					frame.isSkinned = true
				end

				i = i + 1
				frame = _G["Tablet20DetachedFrame" .. i]
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

	return true
end

local function SkinLibRockConfig(lib)
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

	return true
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

	return true
end

local function SkinAceAddon20(lib)
	S:SecureHook(lib.prototype, "PrintAddonInfo", function()
		AceAddon20AboutFrame:SetTemplate("Transparent")
		S:HandleButton(AceAddon20AboutFrameButton)
		S:HandleButton(AceAddon20AboutFrameDonateButton)

		S:Unhook(lib.prototype, "PrintAddonInfo")
	end)

	S:SecureHook(lib.prototype, "OpenDonationFrame", function()
		AceAddon20Frame:SetTemplate("Transparent")
		S:HandleScrollBar(AceAddon20FrameScrollFrameScrollBar)
		S:HandleButton(AceAddon20FrameButton)

		S:Unhook(lib.prototype, "OpenDonationFrame")
	end)

	return true
end

local function SkinAzDialog(libName)
	local lib = _G[libName]
	if not lib then return end

	local function skinDialog(frame)
		if frame.isSkinned then return end

		frame:SetTemplate("Transparent")

		frame.edit:SetBackdrop(nil)
		S:HandleEditBox(frame.edit)

		S:HandleButton(frame.ok)
		S:HandleButton(frame.cancel)

		frame.isSkinned = true
	end

	for _, frame in ipairs(lib.dialogs) do
		skinDialog(frame)
	end

	S:SecureHook(lib, "Show", function(self)
		skinDialog(self.dialogs[#self.dialogs])
	end)

	return true
end

local function SkinLibExtraTip(lib)
	S:RawHook(lib, "GetFreeExtraTipObject", function(self)
		local tooltip = S.hooks[self].GetFreeExtraTipObject(self)

		if not tooltip.isSkinned then
			tooltip:SetTemplate("Transparent")
			tooltip.isSkinned = true
		end

		return tooltip
	end)

	return true
end

local function SkinZFrame(lib)
	S:RawHook(lib, "Create", function(self, ...)
		local frame = S.hooks[self].Create(self, ...)

		frame.ZMain:SetTemplate("Transparent")
		frame.ZMain.close:Size(32)
		S:HandleCloseButton(frame.ZMain.close, frame.ZMain)

		return frame
	end, true)

	return true
end

AS.libSkins = {
	["AceAddon-2.0"] = {
		stub = true,
		func = SkinAceAddon20
	},
	["ArkDewdrop-3.0"] = {
		stub = true,
		func = SkinDewdrop
	},
	["AzDialog"] = {
		stub = false,
		func = SkinAzDialog
	},
	["Configator"] = {
		stub = true,
		func = SkinConfigator
	},
	["Dewdrop-2.0"] = {
		stub = true,
		func = SkinDewdrop
	},
	["LibExtraTip-1"] = {
		stub = true,
		func = SkinLibExtraTip
	},
	["LibRockConfig-1.0"] = {
		stub = true,
		func = SkinLibRockConfig
	},
	["Tablet-2.0"] = {
		stub = true,
		func = SkinTablet2
	},
	["ZFrame-1.0"] = {
		stub = true,
		func = SkinZFrame
	},
}

function AS:SkinLibrary(libName)
	if not libName or not self.libSkins[libName] then return end

	if self.libSkins[libName].stub then
		local lib, minor = LibStub(libName, true)
		if lib and (not self.skinnedLibs[libName] or self.skinnedLibs[libName] < minor) then
			if self.libSkins[libName].func(lib, libName) then
				self.skinnedLibs[libName] = minor or 1
				return true
			end
		end
	elseif not self.skinnedLibs[libName] then
		if self.libSkins[libName].func(libName) then
			self.skinnedLibs[libName] = true
			return true
		end
	end
end