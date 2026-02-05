local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
local AS = E:GetModule("AddOnSkins")

if not AS:IsAddonLODorEnabled("MPR") then return end

-- MP-Reporter
-- Skin for MPR_Options frame

function MPROptionsHandleColorButton(button)
    if not button.isSkinned then
        S:HandleButton(button)
        button:Disable()
        button.isSkinned = true
    end
end

function SkinMPReporterOptions()
    -- Hook the Initialize function to skin after frame is created
    if MPR_Options then
        -- Strip default backdrop and apply ElvUI template
        MPR_Options:StripTextures()
        MPR_Options:SetTemplate("Transparent")

        -- Skin close button
        if MPR_Options_BtnClose then
            S:HandleCloseButton(MPR_Options_BtnClose)
            MPR_Options_BtnClose:SetSize(18, 18)
        end

        -- Skin all checkboxes (created via NewCB function)
        for i = 1, 100 do
            local cb = _G["CheckBox" .. i]
            if cb then S:HandleCheckBox(cb) end
        end

        -- Skin color selection checkboxes
        if MPR_Options.CB_Gray then MPROptionsHandleColorButton(MPR_Options.CB_Gray) end
        if MPR_Options.CB_White then MPROptionsHandleColorButton(MPR_Options.CB_White) end
        if MPR_Options.CB_Blue then MPROptionsHandleColorButton(MPR_Options.CB_Blue) end
        if MPR_Options.CB_Green then MPROptionsHandleColorButton(MPR_Options.CB_Green) end
        if MPR_Options.CB_Yellow then MPROptionsHandleColorButton(MPR_Options.CB_Yellow) end
        if MPR_Options.CB_Red then MPROptionsHandleColorButton(MPR_Options.CB_Red) end
        if MPR_Options.CB_SeaGreen then MPROptionsHandleColorButton(MPR_Options.CB_SeaGreen) end
        if MPR_Options.CB_Orange then MPROptionsHandleColorButton(MPR_Options.CB_Orange) end
        if MPR_Options.CB_Purple then MPROptionsHandleColorButton(MPR_Options.CB_Purple) end

        -- Skin death report channel checkboxes
        if MPR_Options.CB_MPR_Options then S:HandleCheckBox(MPR_Options.CB_MPR_Options) end
        if MPR_Options.CB_Raid then S:HandleCheckBox(MPR_Options.CB_Raid) end
        if MPR_Options.CB_Self then S:HandleCheckBox(MPR_Options.CB_Self) end
        if MPR_Options.CB_Guild then S:HandleCheckBox(MPR_Options.CB_Guild) end

        -- Skin sliders
        if MPR_Slider then
            S:HandleSliderFrame(MPR_Slider)
        end
        if MPR_OpacitySlider then
            S:HandleSliderFrame(MPR_OpacitySlider)
        end

        -- Skin buttons
        if BtnToggleIgnoreDispels then
            S:HandleButton(BtnToggleIgnoreDispels)
        end
        if BtnToggleAuraInfo then
            S:HandleButton(BtnToggleAuraInfo)
        end
        if BtnToggleTimers then
            S:HandleButton(BtnToggleTimers)
        end
        if MPR_Options.BTN_CLEAR_DEATHLOG then
            S:HandleButton(MPR_Options.BTN_CLEAR_DEATHLOG)
        end
        if MPR_Options.BTN_ID_LESS then
            S:HandleButton(MPR_Options.BTN_ID_LESS)
        end
        if MPR_Options.BTN_ID_MORE then
            S:HandleButton(MPR_Options.BTN_ID_MORE)
        end
        if MPR_Options.BTN_REPORT then
            S:HandleButton(MPR_Options.BTN_REPORT)
        end
        if MPR_Options.BTN_SAVE_PREFIX then
            S:HandleButton(MPR_Options.BTN_SAVE_PREFIX)
        end
        if _G["BtnTestKillingBlow"] then
            S:HandleButton(_G["BtnTestKillingBlow"])
        end

        -- Skin DKP buttons if they exist
        for i = 1, 50 do
            local btnMore = _G["BtnDKPMore" .. i]
            local btnLess = _G["BtnDKPLess" .. i]
            if btnMore then S:HandleButton(btnMore) end
            if btnLess then S:HandleButton(btnLess) end
            if not btnMore and not btnLess then break end
        end

        -- Skin edit box
        if MPR_Options.EB_PREFIX then
            S:HandleEditBox(MPR_Options.EB_PREFIX)
        end
    end
end

function SkinMPRTimers()
    if MPR_Timers then
        MPR_Timers:StripTextures()
        MPR_Timers:SetTemplate("Transparent")
        
        -- Skin buttons
        if MPR_Timers.CloseButton then
            S:HandleCloseButton(MPR_Timers.CloseButton)
            MPR_Timers.CloseButton:SetSize(18, 18)
        end
        if MPR_Timers.OptionsButton then
            S:HandleButton(MPR_Timers.OptionsButton)
        end
    end
end

function SkinMPRTimersOptions()
    if MPR_Timers_Options then
        MPR_Timers_Options:StripTextures()
        MPR_Timers_Options:SetTemplate("Transparent")
        
        -- Skin close button
        if MPR_Timers_Options.CloseButton then
            S:HandleCloseButton(MPR_Timers_Options.CloseButton)
            MPR_Timers_Options.CloseButton:SetSize(18, 18)
        end
        
        -- Skin all checkboxes created by timer options
        for i = 1, 300 do
            local cb = _G["CheckBox" .. i]
            if cb and cb:GetParent() == MPR_Timers_Options then
                S:HandleCheckBox(cb)
            end
        end
    end
end

function SkinMPRDispels()
    if MPR_Dispels then
        MPR_Dispels:StripTextures()
        MPR_Dispels:SetTemplate("Transparent")
        
        -- Skin close button (global name used in dispels)
        local closeBtn = _G["BtnClose"]
        if closeBtn and closeBtn:GetParent() == MPR_Dispels then
            S:HandleCloseButton(closeBtn)
            closeBtn:SetSize(18, 18)
        end
        
        -- Skin add spell button
        if MPR_Dispels.BTN_ADDSPELL then
            S:HandleButton(MPR_Dispels.BTN_ADDSPELL)
        end
        
        -- Skin edit box
        if MPR_Dispels.EB_ADDSPELL then
            S:HandleEditBox(MPR_Dispels.EB_ADDSPELL)
        end
        
        -- Skin scroll frame
        if _G["ListSpellsScrollFrame"] then
            S:HandleScrollBar(_G["ListSpellsScrollFrameScrollBar"])
        end
        
        -- Skin remove buttons in the list
        for i = 1, 12 do
            local btn = _G["removeBtn" .. i]
            if btn then
                S:HandleButton(btn)
            end
        end
    end
end

function SkinMPRAuraInfo()
    if MPR_AuraInfo then
        MPR_AuraInfo:StripTextures()
        MPR_AuraInfo:SetTemplate("Transparent")
        
        -- Skin navigation buttons (global names)
        local btnPrev = _G["BtnPrev"]
        local btnNext = _G["BtnNext"]
        local btnLess = _G["BtnLess"]
        local btnMore = _G["BtnMore"]
        local btnClose = _G["BtnClose"]
        
        if btnPrev and btnPrev:GetParent() == MPR_AuraInfo then S:HandleButton(btnPrev) end
        if btnNext and btnNext:GetParent() == MPR_AuraInfo then S:HandleButton(btnNext) end
        if btnLess and btnLess:GetParent() == MPR_AuraInfo then S:HandleButton(btnLess) end
        if btnMore and btnMore:GetParent() == MPR_AuraInfo then S:HandleButton(btnMore) end
        if btnClose and btnClose:GetParent() == MPR_AuraInfo then 
            S:HandleCloseButton(btnClose)
            btnClose:SetSize(18, 18)
        end
    end
end

function SkinMPRPenalties()
    if not MPR_Penalties then return end
    
    MPR_Penalties:StripTextures()
    MPR_Penalties:SetTemplate("Transparent")
    
    -- Skin close button
    if MPR_Penalties_BtnClose then
        S:HandleCloseButton(MPR_Penalties_BtnClose)
        MPR_Penalties_BtnClose:SetSize(18, 18)
    end
    
    -- Skin all checkboxes - iterate through all possible CheckBox IDs
    -- The penalty window creates many checkboxes dynamically
    for i = 1, 500 do
        local cb = _G["CheckBox" .. i]
        if cb and cb:GetParent() == MPR_Penalties then
            S:HandleCheckBox(cb)
        end
    end
    
    -- Skin numeric field buttons (-, + buttons for DKP amounts)
    -- These follow pattern: BTN_NF_{ID}_LESS and BTN_NF_{ID}_MORE
    for i = 1, 500 do
        local btnLess = _G["BTN_NF_" .. i .. "_LESS"]
        local btnMore = _G["BTN_NF_" .. i .. "_MORE"]
        if btnLess then 
            S:HandleButton(btnLess)
        end
        if btnMore then 
            S:HandleButton(btnMore)
        end
        -- Stop if we've passed all created buttons
        if not btnLess and not btnMore then break end
    end
    
    -- Skin penalty action buttons in the list
    -- Pattern: MPR_Penalties_Button_{ID}
    for i = 1, 200 do
        local btn = _G["MPR_Penalties_Button_" .. i]
        if btn then
            S:HandleButton(btn)
        else
            break
        end
    end
    
    -- Also try to catch buttons by iterating through Rows table if available
    if MPR_Penalties.Rows then
        for i = 0, 20 do
            local row = MPR_Penalties.Rows[i]
            if row then
                if row.Deduct then S:HandleButton(row.Deduct) end
                if row.Skip then S:HandleButton(row.Skip) end
            end
        end
    end
    
    local btnNFPattern = "BTN_NF_"
    for _, btn in pairs(MPR_Penalties.Frames) do
        if btn and string.sub(btn:GetName(), 1, #btnNFPattern) == btnNFPattern then
            S:HandleButton(btn)
        end
    end
end

S:AddCallbackForAddon("MPR", "MPR", function()
    if not E.private.addOnSkins["MP-Reporter"] then return end
    
    SkinMPReporterOptions()
    
    -- Skin additional windows when they're initialized
    if MPR_Timers then SkinMPRTimers() end
    if MPR_Timers_Options then SkinMPRTimersOptions() end
    if MPR_Dispels then SkinMPRDispels() end
    if MPR_AuraInfo then SkinMPRAuraInfo() end
    if MPR_Penalties then SkinMPRPenalties() end
    
    -- Hook Initialize functions to skin frames when they're created
    if MPR_Timers and MPR_Timers.Initialize then
        hooksecurefunc(MPR_Timers, "Initialize", SkinMPRTimers)
    end
    if MPR_Timers_Options and MPR_Timers_Options.Initialize then
        hooksecurefunc(MPR_Timers_Options, "Initialize", SkinMPRTimersOptions)
    end
    if MPR_Dispels and MPR_Dispels.Initialize then
        hooksecurefunc(MPR_Dispels, "Initialize", SkinMPRDispels)
    end
    if MPR_AuraInfo and MPR_AuraInfo.Initialize then
        hooksecurefunc(MPR_AuraInfo, "Initialize", SkinMPRAuraInfo)
    end
    if MPR_Penalties and MPR_Penalties.Initialize then
        hooksecurefunc(MPR_Penalties, "Initialize", SkinMPRPenalties)
    end
end)