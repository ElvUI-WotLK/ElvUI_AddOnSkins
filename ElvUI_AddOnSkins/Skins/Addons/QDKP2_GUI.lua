local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
local AS = E:GetModule("AddOnSkins")

if not AS:IsAddonLODorEnabled("QDKP2_GUI") then return end

S:AddCallbackForAddon("QDKP2_GUI", "QDKP2_GUI", function()
  if not E.private.addOnSkins.QDKP2_GUI then return end
  --Roster Frame
  QDKP2_Frame2:StripTextures()
  QDKP2_Frame2:CreateBackdrop("Transparent")
  QDKP2_Frame2:Size(780, 380)
  QDKP2_frame2_title:Size(725, 14)
  QDKP2_frame2_scrollbar:StripTextures()
  --QDKP2_frame2_scrollbar:CreateBackdrop("Transparent")
  QDKP2_frame2_scrollbar:Point("TOPLEFT", 15, - 55)
  QDKP2_frame2_scrollbar:Point("BOTTOMRIGHT", - 30, 41)
  QDKP2_frame2_title_name:Size(105, 14)
  QDKP2_frame2_title_class:Size(80, 14)
  QDKP2_frame2_title_net:Size(60, 14)
  QDKP2_frame2_title_total:Size(60, 14)
  QDKP2_frame2_title_spent:Size(60, 14)
  for i = 1, 20 do
    _G["QDKP2_frame2_entry" .. i]:Size(725, 14)
    _G["QDKP2_frame2_entry" .. i .. "_name"]:Size(105, 14)
    _G["QDKP2_frame2_entry" .. i .. "_class"]:Size(80, 14)
    _G["QDKP2_frame2_entry" .. i .. "_net"]:Size(60, 14)
    _G["QDKP2_frame2_entry" .. i .. "_total"]:Size(60, 14)
    _G["QDKP2_frame2_entry" .. i .. "_spent"]:Size(60, 14)
  end

  for i = 10, 29 do
    local child = select(i, QDKP2_Frame2:GetChildren())
    if child:IsObjectType("Button") then
      child:StripTextures()
      child:SetHighlightTexture("Interface\\AddOns\\ElvUI\\Media\\Textures\\Highlight.tga", "Add")
      S:HandleButtonHighlight(child, 1, 0.8, 0.1)
    end
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
  S:HandleCheckBox(QDKP2frame2_selectList_guildOnline)
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

  QDKP2frame1_exportTXT:Size(60, 20)
  QDKP2frame1_exportTXT:Point("Left", QDKP2frame1_upload, "RIGHT", 5, - 22)
  QDKP2frame1_log:Point("CENTER", QDKP2_Frame1, "TOP", - 2, - 55)
  QDKP2frame1_newSession:Point("RIGHT", QDKP2_Frame1, "TOP", - 2, - 103)
  QDKP2frame1_backup:Point("RIGHT", QDKP2_frame1_BackupDate_Parent, "TOP", - 36, 5)
  QDKP2frame1_restore:Point("LEFT", QDKP2_frame1_BackupDate_Parent, "TOP", - 34, 5)
  QDKP2frame1_backup:Size(89, 20)
  QDKP2frame1_restore:Size(89, 20)
end)
