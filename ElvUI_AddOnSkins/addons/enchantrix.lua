local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")

local floor = math.floor
local select = select

-- Enchantrix 5.8.4723

local function LoadSkin()
	if(not E.private.addOnSkins.Enchantrix) then return end

	local function SkinEditBox(obj)
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

	local function SkinSlider(obj)
		obj:StripTextures()
		obj:SetTemplate("Default")
		obj:Height(12)
		obj:SetThumbTexture(E["media"].blankTex)
		obj:GetThumbTexture():SetVertexColor(0.3, 0.3, 0.3)
		obj:GetThumbTexture():Size(10)
	end

	local function SkinObject(obj)
		if not obj then return end

		local objType = obj:GetObjectType()
		if objType == "FontString" then return end

		if objType == "CheckButton" then
			S:HandleCheckBox(obj)
		elseif objType == "Slider" then
			SkinSlider(obj)
		elseif objType == "EditBox" then
			SkinEditBox(obj)
		elseif objType == "Button" then
			S:HandleButton(obj, true)
		elseif objType == "Frame" then
			if obj.stype == "SelectBox" then
				S:HandleDropDownBox(obj)
			elseif obj.stype == "MoneyFramePinned" then
				local objName = obj:GetName()
				if objName then
					SkinEditBox(_G[objName.."Gold"])
					SkinEditBox(_G[objName.."Silver"])
					SkinEditBox(_G[objName.."Copper"])
				else
					for i = 1, obj:GetNumChildren() do
						local child = select(i, obj:GetChildren())
						if(child and child:IsObjectType("EditBox")) then
							SkinEditBox(child)
						end
					end
				end
			end
		end
	end

	hooksecurefunc(Enchantrix.Settings, "MakeGuiConfig", function()
		local GUI = Enchantrix.Settings.Gui
		if not GUI then return end
		if GUI.isSkinned then return end
		GUI.isSkinned = true

		_G[GUI:GetName() .. "Backdrop"]:SetTemplate("Transparent")
		S:HandleButton(GUI.Done)

		local tab
		for tabID, _ in pairs(GUI.tabs) do
			if type(tabID) == "number" then
				tab = GUI.tabs[tabID]

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
					for i, entry in pairs(tab.frame.ctrls) do
						if type(i) == "number" then
							for _, object in pairs(entry.kids) do
								SkinObject(object)
							end
						end
					end
				end
			end
		end

		if SelectBoxMenu then
			SelectBoxMenu.back:StripTextures()
			SelectBoxMenu.back:SetTemplate("Default")
		end
	end)

	S:SecureHook(Enchantrix_Manifest, "ShowMessage", function()
		Enchantrix_Manifest.messageFrame:SetTemplate("Transparent")
		S:HandleButton(Enchantrix_Manifest.messageFrame.done)
		S:Unhook(Enchantrix_Manifest, "ShowMessage")
	end)

	local function SkinAutoDePrompt(frame)
		frame:SetTemplate("Transparent")

		S:HandleItemButton(AutoDisenchantPromptItem, true)
		AutoDisenchantPromptItem:GetNormalTexture():SetInside(AutoDisenchantPromptItem.backdrop)
		AutoDisenchantPromptItem:GetNormalTexture():SetTexCoord(unpack(E.TexCoords))

		S:HandleButton(AutoDEPromptYes)
		S:HandleButton(AutoDEPromptNo)
		S:HandleButton(AutoDEPromptIgnore)
	end

	if _G["AutoDEPromptYes"] then
		SkinAutoDePrompt(AutoDEPromptYes:GetParent())
	else
		S:SecureHook(Enchantrix.AutoDisenchant, "AddonLoaded", function()
			SkinAutoDePrompt(AutoDEPromptYes:GetParent())
			S:Unhook(Enchantrix.AutoDisenchant, "AddonLoaded")
		end)
	end

	E:GetModule("AddOnSkins"):SkinLibrary("LibExtraTip-1")
end

S:AddCallbackForAddon("Enchantrix", "Enchantrix", LoadSkin)