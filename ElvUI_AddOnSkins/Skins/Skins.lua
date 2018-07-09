local E, L, V, P, G = unpack(ElvUI)
local AS = E:GetModule("AddOnSkins")
local S = E:GetModule("Skins")

local select = select

function AS:SetTemplate(Frame, Template, UseTexture, TextureFile)
	local Texture = AS.Blank

	if UseTexture then
		Texture = TextureFile or AS.NormTex
	end

	if AS.PixelPerfect then
		Frame:SetBackdrop({
			bgFile = Texture,
			edgeFile = AS.Blank,
			tile = false, tileSize = 0, edgeSize = 1,
			insets = {left = 0, right = 0, top = 0, bottom = 0},
		})
	else
		Frame:SetBackdrop({
			bgFile = Texture,
			edgeFile = AS.Blank,
			tile = false, tileSize = 0, edgeSize = 1,
			insets = { left = -1, right = -1, top = -1, bottom = -1},
		})

		if not Frame.isInsetDone then
			Frame.InsetTop = Frame:CreateTexture(nil, "BORDER")
			Frame.InsetTop:Point("TOPLEFT", Frame, "TOPLEFT", -1, 1)
			Frame.InsetTop:Point("TOPRIGHT", Frame, "TOPRIGHT", 1, -1)
			Frame.InsetTop:Height(1)
			Frame.InsetTop:SetTexture(0,0,0)
			Frame.InsetTop:SetDrawLayer("BORDER", -7)

			Frame.InsetBottom = Frame:CreateTexture(nil, "BORDER")
			Frame.InsetBottom:Point("BOTTOMLEFT", Frame, "BOTTOMLEFT", -1, -1)
			Frame.InsetBottom:Point("BOTTOMRIGHT", Frame, "BOTTOMRIGHT", 1, -1)
			Frame.InsetBottom:Height(1)
			Frame.InsetBottom:SetTexture(0,0,0)
			Frame.InsetBottom:SetDrawLayer("BORDER", -7)

			Frame.InsetLeft = Frame:CreateTexture(nil, "BORDER")
			Frame.InsetLeft:Point("TOPLEFT", Frame, "TOPLEFT", -1, 1)
			Frame.InsetLeft:Point("BOTTOMLEFT", Frame, "BOTTOMLEFT", 1, -1)
			Frame.InsetLeft:Width(1)
			Frame.InsetLeft:SetTexture(0,0,0)
			Frame.InsetLeft:SetDrawLayer("BORDER", -7)

			Frame.InsetRight = Frame:CreateTexture(nil, "BORDER")
			Frame.InsetRight:Point("TOPRIGHT", Frame, "TOPRIGHT", 1, 1)
			Frame.InsetRight:Point("BOTTOMRIGHT", Frame, "BOTTOMRIGHT", -1, -1)
			Frame.InsetRight:Width(1)
			Frame.InsetRight:SetTexture(0,0,0)
			Frame.InsetRight:SetDrawLayer("BORDER", -7)

			Frame.InsetInsideTop = Frame:CreateTexture(nil, "BORDER")
			Frame.InsetInsideTop:Point("TOPLEFT", Frame, "TOPLEFT", 1, -1)
			Frame.InsetInsideTop:Point("TOPRIGHT", Frame, "TOPRIGHT", -1, 1)
			Frame.InsetInsideTop:Height(1)
			Frame.InsetInsideTop:SetTexture(0,0,0)
			Frame.InsetInsideTop:SetDrawLayer("BORDER", -7)

			Frame.InsetInsideBottom = Frame:CreateTexture(nil, "BORDER")
			Frame.InsetInsideBottom:Point("BOTTOMLEFT", Frame, "BOTTOMLEFT", 1, 1)
			Frame.InsetInsideBottom:Point("BOTTOMRIGHT", Frame, "BOTTOMRIGHT", -1, 1)
			Frame.InsetInsideBottom:Height(1)
			Frame.InsetInsideBottom:SetTexture(0,0,0)
			Frame.InsetInsideBottom:SetDrawLayer("BORDER", -7)

			Frame.InsetInsideLeft = Frame:CreateTexture(nil, "BORDER")
			Frame.InsetInsideLeft:Point("TOPLEFT", Frame, "TOPLEFT", 1, -1)
			Frame.InsetInsideLeft:Point("BOTTOMLEFT", Frame, "BOTTOMLEFT", -1, 1)
			Frame.InsetInsideLeft:Width(1)
			Frame.InsetInsideLeft:SetTexture(0,0,0)
			Frame.InsetInsideLeft:SetDrawLayer("BORDER", -7)

			Frame.InsetInsideRight = Frame:CreateTexture(nil, "BORDER")
			Frame.InsetInsideRight:Point("TOPRIGHT", Frame, "TOPRIGHT", -1, -1)
			Frame.InsetInsideRight:Point("BOTTOMRIGHT", Frame, "BOTTOMRIGHT", 1, 1)
			Frame.InsetInsideRight:Width(1)
			Frame.InsetInsideRight:SetTexture(0,0,0)
			Frame.InsetInsideRight:SetDrawLayer("BORDER", -7)

			Frame.isInsetDone = true
		end
	end

	--local R, G, B = unpack(AS.BackdropColor)
	local backdropr, backdropg, backdropb = unpack(AS.BackdropColor)
	local R = backdropr
	local G = backdropg
	local B = backdropb
	local Alpha = (Template == "Transparent" and .8 or 1)

	if AS:CheckAddOn('ElvUI') then
		if Template == "Transparent" then
			R, G, B, Alpha = unpack(ElvUI[1]["media"].backdropfadecolor)
		else
			R, G, B = unpack(ElvUI[1]["media"].backdropcolor)
		end

		Frame.template = Template
		ElvUI[1]["frames"][Frame] = true
	end

	borderr, borderg, borderb = unpack(E["media"].bordercolor)

	Frame:SetBackdropBorderColor(borderr, borderg, borderb)
	Frame:SetBackdropColor(R, G, B, Alpha)
end

function AS:StripTextures(Object, Kill, Alpha)
	for i = 1, Object:GetNumRegions() do
		local Region = select(i, Object:GetRegions())
		if Region and Region:GetObjectType() == "Texture" then
			if Kill then
				Region:Kill()
				--Region:SetParent(AS.Hider)
			elseif Alpha then
				Region:SetAlpha(0)
			else
				Region:SetTexture(nil)
			end
		end
	end
end

function AS:SkinFrame(frame, template, override, kill)
	if not template then template = AS:CheckOption('SkinTemplate') end
	if not override then AS:StripTextures(frame, kill) end
	AS:SetTemplate(frame, template)
end

local BlizzardRegions = {
	'Left',
	'Middle',
	'Right',
	'Mid',
	'LeftDisabled',
	'MiddleDisabled',
	'RightDisabled',
}

function AS:SkinButton(Button, Strip)
	if Button.isSkinned then return end

	local ButtonName = Button:GetName()

	for _, Region in pairs(BlizzardRegions) do
		if ButtonName and _G[ButtonName..Region] then
			_G[ButtonName..Region]:SetAlpha(0)
		end
		if Button[Region] then
			Button[Region]:SetAlpha(0)
		end
	end

	if Button.SetNormalTexture then Button:SetNormalTexture("") end
	if Button.SetHighlightTexture then Button:SetHighlightTexture("") end
	if Button.SetPushedTexture then Button:SetPushedTexture("") end
	if Button.SetDisabledTexture then Button:SetDisabledTexture("") end

	AS:SkinFrame(Button, nil, not Strip)

	if AS:CheckAddOn('ElvUI') and AS:CheckOption('ElvUISkinModule') then
		AS:SetTemplate(Button, 'Default', true)
	end

	Button:HookScript("OnEnter", function(self)
		self:SetBackdropBorderColor(unpack(AS.ValueColor or AS.ClassColor))
	end)

	Button:HookScript("OnLeave", function(self)
		self:SetBackdropBorderColor(unpack(AS.BorderColor))
	end)

	if Button.Flash then
		Button.Flash:SetTexture(0, 0, 0, 0)
	--[[
		AS:CreateBackdrop(Button)
		Button.Backdrop:SetAllPoints()
		Button.Backdrop:SetBackdropBorderColor(1, 0, 0, 1)
		Button.Backdrop:SetBackdropColor(0, 0, 0, 0)
		Button.Backdrop:SetFrameStrata(Button:GetFrameStrata())
		Button.Backdrop:SetFrameLevel(Button:GetFrameLevel() + 4)

		Button.Backdrop:SetScript('OnUpdate', function(self)
			if Button.Flash:IsShown() then
				self:SetAlpha(Button.Flash:GetAlpha())
			else
				self:SetAlpha(0)
			end
		end)
	]]
	end
end

function AS:StyleButton(Button)
	if Button.HasStyle then return end

	if Button.SetHighlightTexture then
		local Hover = Button:CreateTexture()
		Hover:SetTexture(1, 1, 1, 0.3)
		Hover:SetInside()

		Button:SetHighlightTexture(Hover)
	end

	if Button.SetPushedTexture then
		local Pushed = Button:CreateTexture()
		Pushed:SetTexture(0.9, 0.8, 0.1, 0.3)
		Pushed:SetInside()

		Button:SetPushedTexture(Pushed)
	end

	if Button.SetCheckedTexture then
		local Checked = Button:CreateTexture()
		Checked:SetTexture(0,1,0,.3)
		Checked:SetInside()

		Button:SetCheckedTexture(Checked)
	end

	local Cooldown = Button:GetName() and _G[Button:GetName().."Cooldown"]

	if Cooldown then
		Cooldown:ClearAllPoints()
		Cooldown:SetInside()
		--Cooldown:SetSwipeColor(0, 0, 0, 1)
	end

	Button.HasStyle = true
end

function AS:SkinIconButton(Button)
	if Button.isSkinned then return end

	local ButtonName = Button:GetName()
	local Icon, Texture = Button.icon or Button.Icon or ButtonName and (_G[ButtonName.."Icon"] or _G[ButtonName.."IconTexture"])

	if Icon then
		Texture = Icon:GetTexture()
		AS:SkinFrame(Button)
		AS:StyleButton(Button)
		Icon:SetTexture(Texture)
		AS:SkinTexture(Icon)
		Icon:SetInside(Button)
		Button.isSkinned = true
	end
end

function AS:SkinTexture(frame)
	frame:SetTexCoord(unpack(AS.TexCoords))
end

function AS:Desaturate(frame, point)
	for i = 1, frame:GetNumRegions() do
		local region = select(i, frame:GetRegions())
		if region:IsObjectType("Texture") then
			local Texture = region:GetTexture()
			if type(Texture) == "string" and strlower(Texture) == "interface\\dialogframe\\ui-dialogbox-corner" then
				region:SetTexture(nil)
				region:Kill()
			else
				region:SetDesaturated(true)
			end
		end
	end

	frame:HookScript("OnUpdate", function(self)
		if self:GetNormalTexture() then
			self:GetNormalTexture():SetDesaturated(true)
		end
		if self:GetPushedTexture() then
			self:GetPushedTexture():SetDesaturated(true)
		end
		if self:GetHighlightTexture() then
			self:GetHighlightTexture():SetDesaturated(true)
		end
	end)
end

function AS:AcceptFrame(MainText, Function)
	if not AcceptFrame then
		AcceptFrame = CreateFrame("Frame", "AcceptFrame", UIParent)
		AcceptFrame:SetTemplate("Transparent")
		AcceptFrame:Point("CENTER", UIParent, "CENTER")
		AcceptFrame:SetFrameStrata("DIALOG")

		AcceptFrame.Text = AcceptFrame:CreateFontString(nil, "OVERLAY")
		AcceptFrame.Text:FontTemplate()
		AcceptFrame.Text:Point("TOP", AcceptFrame, "TOP", 0, -10)

		AcceptFrame.Accept = CreateFrame("Button", nil, AcceptFrame, "OptionsButtonTemplate")
		S:HandleButton(AcceptFrame.Accept)
		AcceptFrame.Accept:Size(70, 25)
		AcceptFrame.Accept:Point("RIGHT", AcceptFrame, "BOTTOM", -10, 20)
		AcceptFrame.Accept:SetFormattedText("|cFFFFFFFF%s|r", YES)

		AcceptFrame.Close = CreateFrame("Button", nil, AcceptFrame, "OptionsButtonTemplate")
		S:HandleButton(AcceptFrame.Close)
		AcceptFrame.Close:Size(70, 25)
		AcceptFrame.Close:Point("LEFT", AcceptFrame, "BOTTOM", 10, 20)
		AcceptFrame.Close:SetScript("OnClick", function(self) self:GetParent():Hide() end)
		AcceptFrame.Close:SetFormattedText("|cFFFFFFFF%s|r", NO)
	end
	AcceptFrame.Text:SetText(MainText)
	AcceptFrame:Size(AcceptFrame.Text:GetStringWidth() + 100, AcceptFrame.Text:GetStringHeight() + 60)
	AcceptFrame.Accept:SetScript("OnClick", Function)
	AcceptFrame:Show()
end