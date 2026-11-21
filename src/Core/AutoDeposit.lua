local addonName, ns = ...

local ACCOUNT_BANK = Enum.BankType.Account

local function Print(message)
	print(("|cff33ff99%s|r: %s"):format(addonName, message))
end

function ns.Deposit()
	if not ns.config.enabled then return end
	if not C_Bank.CanDepositMoney(ACCOUNT_BANK) then return end

	local depositAmount = GetMoney() - ns.config.keepGold * COPPER_PER_GOLD
	if depositAmount <= 0 then return end

	C_Bank.DepositMoney(ACCOUNT_BANK, depositAmount)
	Print(("Deposited %s into the warbank."):format(GetMoneyString(depositAmount, true)))
end
