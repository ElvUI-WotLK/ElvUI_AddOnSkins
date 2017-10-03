local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")

local pairs = pairs
local band, lshift = bit.band, bit.lshift

-- Carbonite 3.340

local function LoadSkin()
	if(not E.private.addOnSkins.Carbonite) then return end

	local function ColorConvert(r, g, b, a)
		if not a then a = 1 end

		local clr = r * 255
		clr = lshift(clr, 8) + g * 255
		clr = lshift(clr, 8) + b * 255
		clr = lshift(clr, 8) + a * 255

		return clr
	end

	local borderColor = ColorConvert(unpack(E["media"].bordercolor))
	local backdropColor = ColorConvert(unpack(E["media"].backdropfadecolor))

	local backdrop
	if E.private.general.pixelPerfect then
		backdrop = {
			bgFile = E["media"].blankTex,
			edgeFile = E["media"].blankTex,
			tile = false, tileSize = 0, edgeSize = E.mult,
			insets = {left = 0, right = 0, top = 0, bottom = 0}
		}
	else
		backdrop = {
			bgFile = E["media"].blankTex,
			edgeFile = E["media"].blankTex,
			tile = false, tileSize = 0, edgeSize = E.mult,
			insets = {left = -E.mult, right = -E.mult, top = -E.mult, bottom = -E.mult}
		}
	end

	Nx.Ski1["ElvUI"] = {
		["Folder"] = "",
		["WinBrH"] = "WinBrH",
		["WinBrV"] = "WinBrV",
		["TabOff"] = "TabOff",
		["TabOn"] = "TabOn",
		["Backdrop"] = backdrop,
		["BdCol"] = borderColor,
		["BgCol"] = backdropColor,
	}

	for i, v in pairs(Nx.OpD) do
		if v.N == "Skin" then
			table.insert(Nx.OpD[i], {N = "ElvUI", F = "NXCmdSkin", Dat = "ElvUI"})
			break
		end
	end

	Nx.Tit.Frm:SetTemplate("Transparent")

	for win, _ in pairs(Nx.Win.Win2) do
		win.Frm:SetTemplate("Transparent")
	end

	for men, _ in pairs(Nx.Men.Men1) do
		men.MaF:SetTemplate("Transparent")
	end

	S:RawHook(Nx.Win, "Cre", function(self, ...)
		local win = S.hooks[self].Cre(self, ...)
		win.Frm:SetTemplate("Transparent")
		return win
	end)

	S:RawHook(Nx.Men, "Cre", function(self, ...)
		local men = S.hooks[self].Cre(self, ...)
		men.MaF:SetTemplate("Transparent")
		return men
	end)

	S:RawHook(Nx.Ski, "GFSBGC", function(self)
		return E["media"].backdropfadecolor
	end, true)

	Nx.Ski:Set("ElvUI")
end

S:AddCallbackForAddon("Carbonite", "Carbonite", LoadSkin)