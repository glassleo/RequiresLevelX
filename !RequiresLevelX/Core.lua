local _, T = ...
local L = T.L

-- Default settings
T.defaults = {
	["AddonEnabled"] = true,
	["EquippableOnly"] = true,
}


-- Create the frame and register events
local frame = CreateFrame("FRAME", "RequiresLevelXFrame")
frame:RegisterEvent("VARIABLES_LOADED")


-- Function to add information to item tooltips
local function OnTooltipSetItem(tooltip, data)
	-- Do nothing if the addon is disabled, or if there is no data
	if not RequiresLevelXConfig["AddonEnabled"] or not data then return end

	local link = data.guid and C_Item.GetItemLinkByGUID(data.guid)
	if not link then return end

	local itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture, itemSellPrice = GetItemInfo(link)

	if itemMinLevel and UnitLevel("player") >= itemMinLevel and itemMinLevel > 1 then
		-- No need to add our line if the player is below the required level since then the game shows it
		if (itemEquipLoc and itemEquipLoc ~= "") or not RequiresLevelXConfig["EquippableOnly"] then
			-- ITEM_MIN_LEVEL = "Requires Level %d"
			tooltip:AddLine("|cffffffff" .. string.format(ITEM_MIN_LEVEL, itemMinLevel or 1) .. "|r")
		end
	end
end

-- Event Handler
local function eventHandler(self, event)
	if event == "VARIABLES_LOADED" then
		-- Make sure defaults are set
		if not RequiresLevelXConfig then RequiresLevelXConfig = T.defaults end
	end
end

frame:SetScript("OnEvent", eventHandler)

TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Item, OnTooltipSetItem)
