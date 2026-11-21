local addonName, ns = ...

local function InitializeConfig()
	AUTODEPOSIT_CONFIG = AUTODEPOSIT_CONFIG or {}
	for key, value in pairs(ns.Defaults) do
		if AUTODEPOSIT_CONFIG[key] == nil then
			AUTODEPOSIT_CONFIG[key] = value
		end
	end
	ns.config = AUTODEPOSIT_CONFIG
end

local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("ADDON_LOADED")
eventFrame:SetScript("OnEvent", function(self, event, loadedAddon)
	if event == "BANKFRAME_OPENED" then
		ns.Deposit()
		return
	end

	if loadedAddon ~= addonName then return end
	self:UnregisterEvent(event)

	InitializeConfig()
	ns.InitSettings()
	self:RegisterEvent("BANKFRAME_OPENED")
end)
