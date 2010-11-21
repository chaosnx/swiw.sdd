function gadget:GetInfo()
	return {
		name = "Does Not Count",
		desc = "Makes certain units not count for a team's alive status by killing them",
		author = "KDR_11k (David Becker)",
		date = "2008-02-04",
		license = "Public domain",
		layer = 1,
		enabled = true
	}
end

-- use the custom param dontcount=1 (capitalization doesn't matter in a .fbi, only
-- in a .lua unit definition) to mark a unit as not counted:
--
-- [customParams]
-- {
--     dontCount=1;
-- }
--
-- Uses I can think of include making mines explode when the team has nothing useful left
-- or implementing C&C-style no buildings = dead rules.

if (gadgetHandler:IsSyncedCode()) then

--SYNCED

local destroyQueue = {}

local aliveCount = {}

local isAlive = {}

function gadget:GameFrame(t)
	if t % 32 < .1 then
		for t,_ in pairs(destroyQueue) do
			for _,u in ipairs(Spring.GetTeamUnits(t)) do
				Spring.DestroyUnit(u, true)
			end
			destroyQueue[t]=nil
		end
	end
end

function gadget:UnitCreated(u, ud, team)
	isAlive[u] = true
	if UnitDefs[ud].customParams.dontcount~="1" then
		aliveCount[team] = aliveCount[team] + 1
	end
end

function gadget:UnitGiven(u, ud, team)
	if isAlive[u] and UnitDefs[ud].customParams.dontcount~="1" then
		aliveCount[team] = aliveCount[team] + 1
	end
end

function gadget:UnitDestroyed(u, ud, team)
	isAlive[u] = nil
	if UnitDefs[ud].customParams.dontcount~="1" then
		aliveCount[team] = aliveCount[team] - 1
		if aliveCount[team] <= 0 then
			destroyQueue[team] = true
		end
	end
end

function gadget:UnitTaken(u, ud, team)
	if isAlive[u] and UnitDefs[ud].customParams.dontcount~="1" then
		aliveCount[team] = aliveCount[team] - 1
		if aliveCount[team] <= 0 then
			destroyQueue[team] = true
		end
	end
end

function gadget:Initialize()
	for _,t in ipairs(Spring.GetTeamList()) do
		aliveCount[t] = 0
	end
end

else

--UNSYNCED

return false

end
