CreateFrame("Frame", "IBDF", UIParent)
IBDF:RegisterEvent("CHAT_MSG_ADDON")
IBDF:SetScript("OnEvent", function() IBDF:ReceiveToggle(arg2, arg4) end)
IBDF.fb = true
if GetLocale() == "deDE" then
	IBDF.msg = {
		[1] = "Feuerball",
		[2] = "Frostblitz",
		[3] = "Frostblitz wird nun gecasted.",
		[4] = "Feuerball wird nun gecasted."
	}
else
	IBDF.msg = {
		[1] = "Fireball",
		[2] = "Frostbolt",
		[3] = "Frostbolt will be casted now.",
		[4] = "Fireball will be casted now."
	}
end

function IBDF:SendToggle()
	if IsRaidOfficer() then
		if self.fb then
			self.fb = false
			self:Print(self.msg[3])
			SendAddonMessage("IBDF", "Frostbolt", "RAID")
		else
			self.fb = true
			self:Print(self.msg[4])
			SendAddonMessage("IBDF", "Fireball", "RAID")
		end
	end
end

function IBDF:ReceiveToggle(msg, arg3)
	if arg3 ~= UnitName("player") then
		if msg == "Fireball" then
			self.fb = true
			self:Print(self.msg[4])
		elseif msg == "Frostbolt" then
			self.fb = false
			self:Print(self.msg[3])
		end
	end
end

function IBDF:Cast()
	if self.fb then
		CastSpellByName(self.msg[1])
	else
		CastSpellByName(self.msg[2])
	end
end

function IBDF:Print(msg)
	DEFAULT_CHAT_FRAME:AddMessage("|cFFFF8080IBDF|r: "..msg)
end