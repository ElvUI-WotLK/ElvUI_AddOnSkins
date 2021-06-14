local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
local AS = E:GetModule("AddOnSkins")

if not AS:IsAddonLODorEnabled("Overachiever_Tabs") then return end

local _G = _G
local getmetatable = getmetatable
local ipairs = ipairs

-- Overachiever 0.56
-- https://www.curseforge.com/wow/addons/overachiever/files/443622

S:AddCallbackForAddon("Overachiever_Tabs", "Overachiever", function()
	if not E.private.addOnSkins.Overachiever then return end

	for i = 3, 5 do
		local tab = _G["AchievementFrameTab"..i]
		S:HandleTab(tab)
		tab:Point("LEFT", _G["AchievementFrameTab"..(i-1)], "RIGHT", -15, 0)
		tab.text:Point("CENTER", 0, 2)
		tab.text.SetPoint = E.noop
	end

	local leftFrame = _G["Overachiever_LeftFrame"]
	for _, childFrame in ipairs({leftFrame:GetChildren()}) do
		for _, obj in ipairs({childFrame:GetChildren()}) do
			local objType = obj:GetObjectType()
			if objType == "Button" then
				S:HandleButton(obj)
			elseif objType == "EditBox" then
				S:HandleEditBox(obj)
			elseif objType == "CheckButton" then
				S:HandleCheckBox(obj)
			elseif objType == "Frame" and obj.TjDDM then
				S:HandleDropDownBox(obj)
			end
		end
	end

	local containers = {
		"Overachiever_SearchFrame",
		"Overachiever_SuggestionsFrame",
		"Overachiever_WatchFrame"
	}

	for _, frameName in ipairs(containers) do
		local frame = _G[frameName]
		frame:StripTextures()
		frame:SetTemplate("Transparent")

		frame:GetChildren():StripTextures()

		frame.scrollFrame:Point("TOPLEFT", 2, -2)
		frame.scrollFrame:Point("BOTTOMRIGHT", -2, 4)

		local scrollBar = _G[frame.scrollFrame:GetName() .. "ScrollBar"]
		S:HandleScrollBar(scrollBar)

		scrollBar:Point("TOPLEFT", frame.scrollFrame, "TOPRIGHT", 5, -17)
		scrollBar:Point("BOTTOMLEFT", frame.scrollFrame, "BOTTOMRIGHT", 5, 15)

		scrollBar.Show = function(self)
			frame:SetWidth(500)
			for _, button in ipairs(frame.buttons) do
				button:SetWidth(496)
			end
			getmetatable(self).__index.Show(self)
		end

		scrollBar.Hide = function(self)
			frame:SetWidth(521)
			for _, button in ipairs(frame.buttons) do
				button:SetWidth(517)
			end
			getmetatable(self).__index.Hide(self)
		end
	end
end)