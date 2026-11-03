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

if not AS:IsAddonLODorEnabled("QDKP2_GUI") then return end

-- Quick DKP V2 - GUI v 2.6.7 and v 2.7.5

S:AddCallbackForAddon("QDKP2_GUI", "QDKP2_GUI", function()
	if not E.private.addOnSkins.QDKP2_GUI then return end
	--Roster Frame
	SkinFrame(QDKP2_Frame2, "StripTextures")
	QDKP2_Frame2:CreateBackdrop("Transparent")
	SkinFrame(QDKP2_Frame2, "Size", 780, 400)
	SkinFrame(QDKP2_frame2_title, "Size", 725, 14)
	SkinFrame(QDKP2_frame2_scrollbar, "StripTextures")
	SkinFrame(QDKP2_frame2_scrollbar, "Point", "TOPLEFT", 15, - 55)
	SkinFrame(QDKP2_frame2_scrollbar, "Point", "BOTTOMRIGHT", - 30, 41)
	SkinFrame(QDKP2_frame2_title_name, "Size", 105, 14)
	SkinFrame(QDKP2_frame2_title_class, "Size", 80, 14)
	SkinFrame(QDKP2_frame2_title_net, "Size", 60, 14)
	SkinFrame(QDKP2_frame2_title_total, "Size", 60, 14)
	SkinFrame(QDKP2_frame2_title_spent, "Size", 60, 14)
	SkinFrame(QDKP2_Frame2_Bid_Item, "ClearAllPoints")
	SkinFrame(QDKP2_Frame2_Bid_Item, "Point", "BottomLeft", QDKP2_frame2_showRaid, "BottomLeft", - 60, - 2)

	for i = 10, 29 do
		local child = select(i, QDKP2_Frame2:GetChildren())
		if child:IsObjectType("Button") then
			SkinFrame(child, "StripTextures")
			SkinFrame(child, "SetHighlightTexture", "Interface\\AddOns\\ElvUI\\Media\\Textures\\Highlight.tga", "Add")
			SkinControl("HandleButtonHighlight", child, 1, 0.8, 0.1)
		end
	end

	for i = 1, 20 do
		SkinFrame(_G["QDKP2_frame2_entry" .. i], "Size", 725, 14)
		SkinFrame(_G["QDKP2_frame2_entry" .. i .. "_name"], "Size", 105, 14)
		SkinFrame(_G["QDKP2_frame2_entry" .. i .. "_class"], "Size", 80, 14)
		SkinFrame(_G["QDKP2_frame2_entry" .. i .. "_net"], "Size", 60, 14)
		SkinFrame(_G["QDKP2_frame2_entry" .. i .. "_total"], "Size", 60, 14)
		SkinFrame(_G["QDKP2_frame2_entry" .. i .. "_spent"], "Size", 60, 14)

		local highlight = _G["QDKP2_frame2_entry" .. i .. "_Highlight"]
		SkinFrame(highlight, "SetAllPoints", true)
		highlight:SetTexture(E.Media.Textures.Highlight)
		highlight:SetVertexColor(0.8, 0.6, 0.2, 0.5)
	end

	SkinControl("HandleScrollBar", QDKP2_frame2_scrollbarScrollBar)
	SkinControl("HandleButton", QDKP2_Frame2_SortBtn_name)
	SkinControl("HandleButton", QDKP2_Frame2_SortBtn_rank)
	SkinControl("HandleButton", QDKP2_Frame2_SortBtn_class)
	SkinControl("HandleButton", QDKP2_Frame2_SortBtn_net)
	SkinControl("HandleButton", QDKP2_Frame2_SortBtn_total)
	SkinControl("HandleButton", QDKP2_Frame2_SortBtn_spent)
	SkinControl("HandleButton", QDKP2_Frame2_SortBtn_hours)
	SkinControl("HandleButton", QDKP2_Frame2_SortBtn_deltatotal)
	SkinControl("HandleButton", QDKP2_Frame2_SortBtn_deltaspent)
	SkinControl("HandleButton", QDKP2_frame2_showRaid)
	SkinControl("HandleButton", QDKP2_Frame2_Bid_Button)
	SkinControl("HandleButton", QDKP2_Frame2_Bid_ButtonWin)
	SkinControl("HandleButton", QDKP2_Frame2_SortBtn_roll)
	SkinControl("HandleButton", QDKP2_Frame2_SortBtn_bid)
	SkinControl("HandleButton", QDKP2_Frame2_SortBtn_value)
	SkinControl("HandleEditBox", QDKP2_Frame2_Bid_Item)
	SkinControl("HandleCheckBox", QDKP2frame2_selectList_guild)
	if QDKP2frame2_selectList_guildOnline then
		SkinControl("HandleCheckBox", QDKP2frame2_selectList_guildOnline)
	elseif QDKP2frame2_selectList_Custom then
		SkinControl("HandleCheckBox", QDKP2frame2_selectList_Custom)
	end
	SkinControl("HandleCheckBox", QDKP2frame2_selectList_Raid)
	SkinControl("HandleCheckBox", QDKP2frame2_selectList_Bid)
	SkinControl("HandleCloseButton", QDKP2_Frame2_Button1, QDKP2_Frame2)

	--RaidLog Frame
	SkinFrame(QDKP2_Frame5, "StripTextures")
	QDKP2_Frame5:CreateBackdrop("Transparent")
	SkinFrame(QDKP2_frame5_scrollbar, "StripTextures")
	SkinControl("HandleCloseButton", QDKP2_Frame5_Button1, QDKP2_Frame5)
	SkinControl("HandleScrollBar", QDKP2_frame5_scrollbarScrollBar)
	SkinFrame(QDKP2_frame5_intest_net, "Size", 40, 14)
	SkinFrame(QDKP2_frame5_intest_mod, "Size", 40, 14)
	for i = 1, 25 do
		SkinFrame(_G["QDKP2_frame5_entry" .. i .. "_net"], "Size", 40, 14)
		SkinFrame(_G["QDKP2_frame5_entry" .. i .. "_mod"], "Size", 40, 14)
	end
	for i = 4, 28 do
		local child = select(i, QDKP2_Frame5:GetChildren())
		if child:IsObjectType("Button") then
			SkinFrame(child, "StripTextures")
			SkinFrame(child, "SetHighlightTexture", "Interface\\AddOns\\ElvUI\\Media\\Textures\\Highlight.tga", "Add")
			SkinControl("HandleButtonHighlight", child, 1, 0.8, 0.1)
		end
	end

	--Frame 1
	SkinFrame(QDKP2_Frame1, "StripTextures")
	QDKP2_Frame1:CreateBackdrop("Transparent")
	SkinControl("HandleCloseButton", QDKP2_Frame1_Button1, QDKP2_Frame1)
	SkinControl("HandleButton", QDKP2frame1_newSession)
	SkinControl("HandleButton", QDKP2frame1_closeSession)
	SkinControl("HandleButton", QDKP2frame1_upload)
	SkinControl("HandleButton", QDKP2frame1_revert)
	SkinControl("HandleButton", QDKP2frame1_backup)
	SkinControl("HandleButton", QDKP2frame1_restore)
	SkinControl("HandleButton", QDKP2frame1_exportTXT)
	SkinControl("HandleButton", QDKP2frame1_list)
	SkinControl("HandleButton", QDKP2frame1_log)
	SkinControl("HandleButton", QDKP2frame1_award)
	SkinControl("HandleButton", QDKP2frame1_dkpBox_perhr)
	SkinControl("HandleButton", QDKP2frame1_dkpBox_IM)
	SkinControl("HandleButton", QDKP2frame1_ironman)
	SkinControl("HandleButton", QDKP2frame1_onOff)
	SkinControl("HandleButton", QDKP2frame1_dkpBox)
	SkinControl("HandleNextPrevButton", QDKP2frame1_upbutton, "up")
	SkinControl("HandleNextPrevButton", QDKP2frame1_downbutton, "down")
	SkinControl("HandleNextPrevButton", QDKP2frame1_hourlybonus_upbutton, "up")
	SkinControl("HandleNextPrevButton", QDKP2frame1_hourlybonus_downbutton, "down")
	SkinControl("HandleNextPrevButton", QDKP2frame1_IMbonus_upbutton, "up")
	SkinControl("HandleNextPrevButton", QDKP2frame1_IMbonus_downbutton, "down")
	SkinControl("HandleCheckBox", QDKP2frame1_UseBossMod)
	SkinControl("HandleCheckBox", QDKP2frame1_DetectBids)
	SkinControl("HandleCheckBox", QDKP2frame1_FixedPrice)
	SkinFrame(QDKP2_frame1_BackupDate, "Point", "CENTER", 0, - 3)
	SkinFrame(QDKP2_Frame1_raidDKP_text, "Point", "LEFT", 4, 0)
	SkinFrame(QDKP2_Frame1_timerDKP_text, "Point", "LEFT", 4, 0)
	SkinFrame(QDKP2_Frame1_IMDKP_text, "Point", "LEFT", 4, 0)
	SkinFrame(QDKP2frame1_exportTXT, "Size", 60, 20)
	SkinFrame(QDKP2frame1_exportTXT, "Point", "Left", QDKP2frame1_upload, "RIGHT", 5, - 22)
	SkinFrame(QDKP2frame1_log, "Point", "CENTER", QDKP2_Frame1, "TOP", - 2, - 55)
	SkinFrame(QDKP2frame1_newSession, "Point", "RIGHT", QDKP2_Frame1, "TOP", - 2, - 103)
	SkinFrame(QDKP2frame1_backup, "Point", "RIGHT", QDKP2_frame1_BackupDate_Parent, "TOP", - 36, 5)
	SkinFrame(QDKP2frame1_restore, "Point", "LEFT", QDKP2_frame1_BackupDate_Parent, "TOP", - 35, 5)
	SkinFrame(QDKP2frame1_backup, "Size", 89, 20)
	SkinFrame(QDKP2frame1_restore, "Size", 89, 20)

	--Frame 3
	SkinFrame(QDKP2_Frame3, "StripTextures")
	QDKP2_Frame3:CreateBackdrop("Transparent")
	SkinFrame(QDKP2frame3_dkpBox, "Size", 45, 20)
	SkinFrame(QDKP2frame3_reasonBox, "Size", 137, 20)
	SkinFrame(QDKP2frame3_reasonBox, "Point", "LEFT", QDKP2frame3_For, "RIGHT", 4, - 2)
	SkinFrame(QDKP2frame3_changePlayerInfo, "Point", "CENTER", QDKP2_Frame3, "BOTTOM", 0, 23)
	SkinControl("HandleCloseButton", QDKP2_Frame3_Button1)
	SkinControl("HandleEditBox", QDKP2frame3_dkpBox)
	SkinControl("HandleEditBox", QDKP2frame3_reasonBox)
	SkinControl("HandleButton", QDKP2frame3_award)
	SkinControl("HandleButton", QDKP2frame3_spend)
	SkinControl("HandleButton", QDKP2frame3_zsBtn)
	SkinControl("HandleButton", QDKP2frame3_PopupLog)
	SkinControl("HandleButton", QDKP2frame3_changePlayerInfo)

	--Frame 4
	SkinFrame(QDKP2_Frame4, "StripTextures")
	QDKP2_Frame4:CreateBackdrop("Transparent")
	SkinControl("HandleCloseButton", QDKP2_Frame4_Button1)
	SkinFrame(QDKP2frame4_NetBox, "Size", 100, 15)
	SkinFrame(QDKP2frame4_TotalBox, "Size", 100, 15)
	SkinFrame(QDKP2frame4_HoursBox, "Size", 70, 15)
	SkinFrame(QDKP2frame4_NetBox, "Point", "TopLeft", QDKP2_Frame4, "TopLeft", 70, - 31)
	SkinFrame(QDKP2frame4_TotalBox, "Point", "TopLeft", QDKP2_Frame4, "TopLeft", 70, - 51)
	SkinFrame(QDKP2frame4_HoursBox, "Point", "TopLeft", QDKP2_Frame4, "TopLeft", 70, - 71)
	SkinControl("HandleEditBox", QDKP2frame4_NetBox)
	SkinControl("HandleEditBox", QDKP2frame4_TotalBox)
	SkinControl("HandleEditBox", QDKP2frame4_HoursBox)
	SkinControl("HandleButton", QDKP2Frame4_Set)

	--QDKP2_modify_log_entry
	SkinFrame(QDKP2_modify_log_entry, "StripTextures")
	QDKP2_modify_log_entry:CreateBackdrop("Transparent")
	SkinControl("HandleCloseButton", QDKP2_modify_log_entry_ButtonClose)
	SkinFrame(QDKP2_modify_log_entry, "Size", 230, 160)
	SkinFrame(QDKP2frame6_GainedBox, "Size", 50, 20)
	SkinFrame(QDKP2frame6_SpentBox, "Size", 50, 20)
	SkinFrame(QDKP2frame6_ReasonBox, "Size", 160, 20)
	SkinFrame(QDKP2frame6_ReasonBox, "Point", "TOP", 19, - 70)
	SkinFrame(QDKP2_modify_log_entry_for, "Point", "TOPLEFT", 5, - 74)
	SkinControl("HandleEditBox", QDKP2frame6_GainedBox)
	SkinControl("HandleEditBox", QDKP2frame6_SpentBox)
	SkinControl("HandleEditBox", QDKP2frame6_ReasonBox)
	SkinControl("HandleButton", QDKP2_modify_log_entry_Apply)
	SkinControl("HandleButton", QDKP2_modify_log_entry_Cancel)
end)

