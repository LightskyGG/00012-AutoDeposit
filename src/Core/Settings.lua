local addonName, ns = ...

local settingsCategory

local function GetKeepGoldOptions()
	local container = Settings.CreateControlTextContainer()
	for _, gold in ipairs(ns.KeepGoldOptions) do
		container:Add(gold, BreakUpLargeNumbers(gold) .. "g")
	end
	return container:GetData()
end

function ns.InitSettings()
	local category = Settings.RegisterVerticalLayoutCategory(addonName)

	local enabledSetting = Settings.RegisterAddOnSetting(
		category,
		"AUTODEPOSIT_ENABLED",
		"enabled",
		ns.config,
		Settings.VarType.Boolean,
		"Enable",
		ns.Defaults.enabled
	)
	Settings.CreateCheckbox(category, enabledSetting, "Deposit gold into the warbank when opening the bank.")

	local keepGoldSetting = Settings.RegisterAddOnSetting(
		category,
		"AUTODEPOSIT_KEEP_GOLD",
		"keepGold",
		ns.config,
		Settings.VarType.Number,
		"Gold to Keep",
		ns.Defaults.keepGold
	)
	Settings.CreateDropdown(category, keepGoldSetting, GetKeepGoldOptions, "Gold kept on hand when depositing.")

	Settings.RegisterAddOnCategory(category)
	settingsCategory = category
end

function AutoDeposit_AddonCompartmentCallback()
	if settingsCategory then
		Settings.OpenToCategory(settingsCategory:GetID())
	end
end
