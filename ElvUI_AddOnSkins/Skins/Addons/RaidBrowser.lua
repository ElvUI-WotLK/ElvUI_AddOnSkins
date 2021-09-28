local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
local AS = E:GetModule("AddOnSkins")

-- Raid Browser RU 
-- https://github.com/fxpw/RaidBrowser-ru-for-sirus

if not AS:IsAddonLODorEnabled("RaidBrowserRU") then return end




S:AddCallbackForAddon("RaidBrowserRU", "RaidBrowserRU", function()
	
	if not E.private.addOnSkins.RaidBrowserRU then return end


	BARaidBrowserEditSpec:SetTemplate("Transparent")

	BARaidBrowserEditName:SetTemplate("Transparent")
	BARaidBrowserEditGearScore:SetTemplate("Transparent")
	BARaidBrowserEditName:Height(30)
	BARaidBrowserEditGearScore:Height(30)

	BARaidBrowserRaidSet:SetTemplate("Transparent")

	local dropdownArrowColor = {1, 0.8, 0}
	S:HandleNextPrevButton(BARaidBrowserRaidSetButton, "down", dropdownArrowColor)
	BARaidBrowserRaidSetButton:Size(25)

	S:HandleButton(RaidBrowserRaidSetSaveButton)
	S:HandleCloseButton(BARaidBrowserEditSpecCloseButton)
	S:HandleButton(BARaidBrowserEditSpecSaveButton)
	--S:HandleButton(BARaidBrowserEditCurrentSpecButton)
	BARaidBrowserEditNameEditBox:Height(20)
	BARaidBrowserEditGearScoreEditBox:Height(20)
	
	local function lfrhk(self)
			S:HandleScrollBar(LFRBrowseFrameListScrollFrameScrollBar)		
		end

	LFRBrowseFrameListScrollFrameScrollBar:HookScript("OnShow", lfrhk)	
	
end)
