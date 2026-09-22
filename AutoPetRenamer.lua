local function PlainString(value)
	if type(value) ~= "string" or not canaccessvalue(value) or value == "" then
		return nil
	end
	return value
end

local function SameName(a, b)
	return a and b and strlower(a) == strlower(b)
end

local function TryRename()
	if not UnitExists("pet") or not UnitExists("target") or not UnitIsPlayer("target") or not UnitIsEnemy("player", "target") then
		return
	end
	local name = PlainString(UnitName("target"))
	local petName = PlainString(UnitName("pet"))
	if not name or SameName(name, petName) then
		return
	end
	C_PetInfo.PetRename(name)
end

local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_TARGET_CHANGED")
f:RegisterEvent("UNIT_PET")
f:SetScript("OnEvent", function(_, event, unit)
	if event == "UNIT_PET" and unit ~= "player" then
		return
	end
	TryRename()
end)
