local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
local AS = E:GetModule("AddOnSkins")

if not AS:IsAddonLODorEnabled("QDKP2_GUI") then return end

-- Quick DKP V2 - GUI v 2.6.7 and v 2.7.5

S:AddCallbackForAddon("QDKP2_GUI", "QDKP2_GUI", function()
	if not E.private.addOnSkins.QDKP2_GUI then return end
	--Roster Frame
	QDKP2_Frame2:StripTextures()
	QDKP2_Frame2:CreateBackdrop("Transparent")
	QDKP2_Frame2:Size(780, 400)
	QDKP2_frame2_title:Size(725, 14)
	QDKP2_frame2_scrollbar:StripTextures()
	QDKP2_frame2_scrollbar:Point("TOPLEFT", 15, - 55)
	QDKP2_frame2_scrollbar:Point("BOTTOMRIGHT", - 30, 41)
	QDKP2_frame2_title_name:Size(105, 14)
	QDKP2_frame2_title_class:Size(80, 14)
	QDKP2_frame2_title_net:Size(60, 14)
	QDKP2_frame2_title_total:Size(60, 14)
	QDKP2_frame2_title_spent:Size(60, 14)
	QDKP2_Frame2_Bid_Item:ClearAllPoints()
	QDKP2_Frame2_Bid_Item:Point("BottomLeft", QDKP2_frame2_showRaid, "BottomLeft", - 60, - 2)

	for i = 10, 29 do
		local child = select(i, QDKP2_Frame2:GetChildren())
		if child:IsObjectType("Button") then
			child:StripTextures()
			child:SetHighlightTexture("Interface\\AddOns\\ElvUI\\Media\\Textures\\Highlight.tga", "Add")
			S:HandleButtonHighlight(child, 1, 0.8, 0.1)
		end
	end

	for i = 1, 20 do
		_G["QDKP2_frame2_entry" .. i]:Size(725, 14)
		_G["QDKP2_frame2_entry" .. i .. "_name"]:Size(105, 14)
		_G["QDKP2_frame2_entry" .. i .. "_class"]:Size(80, 14)
		_G["QDKP2_frame2_entry" .. i .. "_net"]:Size(60, 14)
		_G["QDKP2_frame2_entry" .. i .. "_total"]:Size(60, 14)
		_G["QDKP2_frame2_entry" .. i .. "_spent"]:Size(60, 14)

		local highlight = _G["QDKP2_frame2_entry" .. i .. "_Highlight"]
		highlight:SetAllPoints(true)
		highlight:SetTexture(E.Media.Textures.Highlight)
		highlight:SetVertexColor(0.8, 0.6, 0.2, 0.5)
	end

	S:HandleScrollBar(QDKP2_frame2_scrollbarScrollBar)
	S:HandleButton(QDKP2_Frame2_SortBtn_name)
	S:HandleButton(QDKP2_Frame2_SortBtn_rank)
	S:HandleButton(QDKP2_Frame2_SortBtn_class)
	S:HandleButton(QDKP2_Frame2_SortBtn_net)
	S:HandleButton(QDKP2_Frame2_SortBtn_total)
	S:HandleButton(QDKP2_Frame2_SortBtn_spent)
	S:HandleButton(QDKP2_Frame2_SortBtn_hours)
	S:HandleButton(QDKP2_Frame2_SortBtn_deltatotal)
	S:HandleButton(QDKP2_Frame2_SortBtn_deltaspent)
	S:HandleButton(QDKP2_frame2_showRaid)
	S:HandleButton(QDKP2_Frame2_Bid_Button)
	S:HandleButton(QDKP2_Frame2_Bid_ButtonWin)
	S:HandleButton(QDKP2_Frame2_SortBtn_roll)
	S:HandleButton(QDKP2_Frame2_SortBtn_bid)
	S:HandleButton(QDKP2_Frame2_SortBtn_value)
	S:HandleEditBox(QDKP2_Frame2_Bid_Item)
	S:HandleCheckBox(QDKP2frame2_selectList_guild)
	if QDKP2frame2_selectList_guildOnline then
		S:HandleCheckBox(QDKP2frame2_selectList_guildOnline)
	elseif QDKP2frame2_selectList_Custom then
		S:HandleCheckBox(QDKP2frame2_selectList_Custom)
	end
	S:HandleCheckBox(QDKP2frame2_selectList_Raid)
	S:HandleCheckBox(QDKP2frame2_selectList_Bid)
	S:HandleCloseButton(QDKP2_Frame2_Button1, QDKP2_Frame2)

	--RaidLog Frame
	QDKP2_Frame5:StripTextures()
	QDKP2_Frame5:CreateBackdrop("Transparent")
	QDKP2_frame5_scrollbar:StripTextures()
	S:HandleCloseButton(QDKP2_Frame5_Button1, QDKP2_Frame5)
	S:HandleScrollBar(QDKP2_frame5_scrollbarScrollBar)
	QDKP2_frame5_intest_net:Size(40, 14)
	QDKP2_frame5_intest_mod:Size(40, 14)
	for i = 1, 25 do
		_G["QDKP2_frame5_entry" .. i .. "_net"]:Size(40, 14)
		_G["QDKP2_frame5_entry" .. i .. "_mod"]:Size(40, 14)
	end
	for i = 4, 28 do
		local child = select(i, QDKP2_Frame5:GetChildren())
		if child:IsObjectType("Button") then
			child:StripTextures()
			child:SetHighlightTexture("Interface\\AddOns\\ElvUI\\Media\\Textures\\Highlight.tga", "Add")
			S:HandleButtonHighlight(child, 1, 0.8, 0.1)
		end
	end

	--Frame 1
	QDKP2_Frame1:StripTextures()
	QDKP2_Frame1:CreateBackdrop("Transparent")
	S:HandleCloseButton(QDKP2_Frame1_Button1, QDKP2_Frame1)
	S:HandleButton(QDKP2frame1_newSession)
	S:HandleButton(QDKP2frame1_closeSession)
	S:HandleButton(QDKP2frame1_upload)
	S:HandleButton(QDKP2frame1_revert)
	S:HandleButton(QDKP2frame1_backup)
	S:HandleButton(QDKP2frame1_restore)
	S:HandleButton(QDKP2frame1_exportTXT)
	S:HandleButton(QDKP2frame1_list)
	S:HandleButton(QDKP2frame1_log)
	S:HandleButton(QDKP2frame1_award)
	S:HandleButton(QDKP2frame1_dkpBox_perhr)
	S:HandleButton(QDKP2frame1_dkpBox_IM)
	S:HandleButton(QDKP2frame1_ironman)
	S:HandleButton(QDKP2frame1_onOff)
	S:HandleButton(QDKP2frame1_dkpBox)
	S:HandleNextPrevButton(QDKP2frame1_upbutton, "up")
	S:HandleNextPrevButton(QDKP2frame1_downbutton, "down")
	S:HandleNextPrevButton(QDKP2frame1_hourlybonus_upbutton, "up")
	S:HandleNextPrevButton(QDKP2frame1_hourlybonus_downbutton, "down")
	S:HandleNextPrevButton(QDKP2frame1_IMbonus_upbutton, "up")
	S:HandleNextPrevButton(QDKP2frame1_IMbonus_downbutton, "down")
	S:HandleCheckBox(QDKP2frame1_UseBossMod)
	S:HandleCheckBox(QDKP2frame1_DetectBids)
	S:HandleCheckBox(QDKP2frame1_FixedPrice)
	QDKP2_frame1_BackupDate:Point("CENTER", 0, - 3)
	QDKP2_Frame1_raidDKP_text:Point("LEFT", 4, 0)
	QDKP2_Frame1_timerDKP_text:Point("LEFT", 4, 0)
	QDKP2_Frame1_IMDKP_text:Point("LEFT", 4, 0)
	QDKP2frame1_exportTXT:Size(60, 20)
	QDKP2frame1_exportTXT:Point("Left", QDKP2frame1_upload, "RIGHT", 5, - 22)
	QDKP2frame1_log:Point("CENTER", QDKP2_Frame1, "TOP", - 2, - 55)
	QDKP2frame1_newSession:Point("RIGHT", QDKP2_Frame1, "TOP", - 2, - 103)
	QDKP2frame1_backup:Point("RIGHT", QDKP2_frame1_BackupDate_Parent, "TOP", - 36, 5)
	QDKP2frame1_restore:Point("LEFT", QDKP2_frame1_BackupDate_Parent, "TOP", - 35, 5)
	QDKP2frame1_backup:Size(89, 20)
	QDKP2frame1_restore:Size(89, 20)

	--Frame 3
	QDKP2_Frame3:StripTextures()
	QDKP2_Frame3:CreateBackdrop("Transparent")
	QDKP2frame3_dkpBox:Size(45, 20)
	QDKP2frame3_reasonBox:Size(137, 20)
	QDKP2frame3_reasonBox:Point("LEFT", QDKP2frame3_For, "RIGHT", 4, - 2)
	QDKP2frame3_changePlayerInfo:Point("CENTER", QDKP2_Frame3, "BOTTOM", 0, 23)
	S:HandleCloseButton(QDKP2_Frame3_Button1)
	S:HandleEditBox(QDKP2frame3_dkpBox)
	S:HandleEditBox(QDKP2frame3_reasonBox)
	S:HandleButton(QDKP2frame3_award)
	S:HandleButton(QDKP2frame3_spend)
	S:HandleButton(QDKP2frame3_zsBtn)
	S:HandleButton(QDKP2frame3_PopupLog)
	S:HandleButton(QDKP2frame3_changePlayerInfo)

	--Frame 4
	QDKP2_Frame4:StripTextures()
	QDKP2_Frame4:CreateBackdrop("Transparent")
	S:HandleCloseButton(QDKP2_Frame4_Button1)
	QDKP2frame4_NetBox:Size(100, 15)
	QDKP2frame4_TotalBox:Size(100, 15)
	QDKP2frame4_HoursBox:Size(70, 15)
	QDKP2frame4_NetBox:Point("TopLeft", QDKP2_Frame4, "TopLeft", 70, - 31)
	QDKP2frame4_TotalBox:Point("TopLeft", QDKP2_Frame4, "TopLeft", 70, - 51)
	QDKP2frame4_HoursBox:Point("TopLeft", QDKP2_Frame4, "TopLeft", 70, - 71)
	S:HandleEditBox(QDKP2frame4_NetBox)
	S:HandleEditBox(QDKP2frame4_TotalBox)
	S:HandleEditBox(QDKP2frame4_HoursBox)
	S:HandleButton(QDKP2Frame4_Set)

	--QDKP2_modify_log_entry
	QDKP2_modify_log_entry:StripTextures()
	QDKP2_modify_log_entry:CreateBackdrop("Transparent")
	S:HandleCloseButton(QDKP2_modify_log_entry_ButtonClose)
	QDKP2_modify_log_entry:Size(230, 160)
	QDKP2frame6_GainedBox:Size(50, 20)
	QDKP2frame6_SpentBox:Size(50, 20)
	QDKP2frame6_ReasonBox:Size(160, 20)
	QDKP2frame6_ReasonBox:Point("TOP", 19, - 70)
	QDKP2_modify_log_entry_for:Point("TOPLEFT", 5, - 74)
	S:HandleEditBox(QDKP2frame6_GainedBox)
	S:HandleEditBox(QDKP2frame6_SpentBox)
	S:HandleEditBox(QDKP2frame6_ReasonBox)
	S:HandleButton(QDKP2_modify_log_entry_Apply)
	S:HandleButton(QDKP2_modify_log_entry_Cancel)
end)
