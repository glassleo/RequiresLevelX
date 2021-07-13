local _, T = ...
local L = T.L

local cfgFrame = CreateFrame("Frame", nil, UIParent)


-- Header
local cfgFrameHeader = cfgFrame:CreateFontString("OVERLAY", nil, "GameFontNormalLarge")
cfgFrameHeader:SetPoint("TOPLEFT", 15, -15)
cfgFrameHeader:SetText("Requires Level X")

-- Info text
local cfgDescription = cfgFrame:CreateFontString("OVERLAY", nil, "GameFontHighlightSmall")
cfgDescription:SetPoint("TOPLEFT", 15, -40)
cfgDescription:SetJustifyH("LEFT")
cfgDescription:SetJustifyV("TOP")
cfgDescription:SetWidth("600")
cfgDescription:SetText(L["Description"])

-- Checkbox: Enable Addon
local cfgAddonEnabled = CreateFrame("CheckButton", nil, cfgFrame, "InterfaceOptionsCheckButtonTemplate")
cfgAddonEnabled:SetPoint("TOPLEFT", 20, -140)
cfgAddonEnabled.Text:SetText(L["Enable Addon"])
cfgAddonEnabled:SetScript("OnClick", function(self)
	RequiresLevelXConfig["AddonEnabled"] = self:GetChecked()
end)


-- Checkbox: Equippable Items Only
local cfgEquippableOnly = CreateFrame("CheckButton", nil, cfgFrame, "InterfaceOptionsCheckButtonTemplate")
cfgEquippableOnly:SetPoint("TOPLEFT", 20, -170)
cfgEquippableOnly.Text:SetText(L["Equippable Items Only"])
cfgEquippableOnly:SetScript("OnClick", function(self)
	RequiresLevelXConfig["EquippableOnly"] = self:GetChecked()
end)




local function RequiresLevelX_cfgInitView()
	cfgAddonEnabled:SetChecked(RequiresLevelXConfig["AddonEnabled"] ~= false)
	cfgEquippableOnly:SetChecked(RequiresLevelXConfig["EquippableOnly"] ~= false)
end

local function RequiresLevelX_cfgSaveView()
	-- Settings are already saved dynamically
end

local function RequiresLevelX_cfgSetDefaults()
	ParagonDB["config"] = T.defaults
	Paragon_cfgInitView()
end

cfgFrame:Hide()
cfgFrame:SetScript("OnShow", RequiresLevelX_cfgInitView)
cfgFrame.name, cfgFrame.okay, cfgFrame.default = "Requires Level X", RequiresLevelX_cfgSaveView, RequiresLevelX_cfgSetDefaults
InterfaceOptions_AddCategory(cfgFrame)
