local LL, _, T = {}, ...

-- Localization Data

-- English
LL["enUS"] = {
	-- Settings Panel
	["Description"] = "In Patch 9.1, Blizzard removed the ability to see what level is required to equip or use an item if your character meets the requirement.\n\nThis is problematic in many situations, for example if you're trying to figure out if your alt could use a BoE that you found, or when you want to craft some gear for someone who is not max level.\n\nThis addon simply adds that functionality back into item tooltips.",
	["Enable Addon"] = "Enable",
	["Equippable Items Only"] = "Equippable Items Only",
}

-- End of localization data




-- L metatable
local L, LD = LL[GetLocale()], LL.enUS
T.L = setmetatable({}, { __index = function(self, key)
	local s = L and L[key] or LD[key] or ("#NOLOC#" .. tostring(key) .. "#")
	self[key] = s
	return s
end, __call = function(self, key)
	return self[key]
end })