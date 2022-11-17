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
local function OnTooltipSetItem(tooltip)
	if not RequiresLevelXConfig["AddonEnabled"] then return end

	local tooltip = tooltip
	local match = string.match
	local _, link = tooltip:GetItem()
	if not link then return end -- Break if the link is invalid
	
	-- String matching to get item ID
	local itemString = match(link, "item[%-?%d:]+")
	local _, itemId = strsplit(":", itemString or "")

	-- TradeSkillFrame workaround
	if itemId == "0" and TradeSkillFrame ~= nil and TradeSkillFrame:IsVisible() then
		if (GetMouseFocus():GetName()) == "TradeSkillSkillIcon" then
			itemId = GetTradeSkillItemLink(TradeSkillFrame.selectedSkill):match("item:(%d+):") or nil
		else
			for i = 1, 8 do
				if (GetMouseFocus():GetName()) == "TradeSkillReagent"..i then
					itemId = GetTradeSkillReagentItemLink(TradeSkillFrame.selectedSkill, i):match("item:(%d+):") or nil
					break
				end
			end
		end
	end

	itemId = tonumber(itemId) -- Make sure itemId is an integer

	if not itemId then return end

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
