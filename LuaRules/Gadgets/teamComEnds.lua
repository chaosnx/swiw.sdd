function gadget:GetInfo()
	return {
		name = "Team Com Ends",
		desc = "Implements com ends for allyteams",
		author = "KDR_11k (David Becker)",
		date = "2008-02-04",
		license = "Public domain",
		layer = 1,
		enabled = true
	}
end

-- this acts just like Com Ends except instead of killing a player's units when
-- his com dies it acts on an allyteam level, if all coms in an allyteam are dead
-- the allyteam is out

-- the deathmode modoption must be set to one of the following to enable this

local endmodes= {
	com=true,
	comcontrol=true,
}

if (gadgetHandler:IsSyncedCode()) then

--SYNCED

local destroyQueue = {}

local aliveCount = {}

local isAlive = {}


local allyTeamsRemaining = Spring.GetAllyTeamList()
local numAllyTeamsRemaining = #allyTeamsRemaining - 1 -- ignore GAIA allyTeam
local GAIA_ALLY_TEAM = select(6, Spring.GetTeamInfo(Spring.GetGaiaTeamID()))

local GetTeamList=Spring.GetTeamList
local GetTeamUnits = Spring.GetTeamUnits
local GetUnitAllyTeam = Spring.GetUnitAllyTeam
local DestroyUnit=Spring.DestroyUnit

function gadget:GameFrame(t)
	if t % 32 < .1 and t > 0 then
		for at,_ in pairs(destroyQueue) do
			if aliveCount[at] <= 0 then --safety check, triggers on transferring the last com otherwise
				for _,team in ipairs(GetTeamList(at)) do
					Spring.KillTeam(team)
					--[[for _,u in ipairs(GetTeamUnits(team)) do
						DestroyUnit(u, true)
					end]]
				end
				numAllyTeamsRemaining = numAllyTeamsRemaining - 1
				for i, allyTeam in pairs(allyTeamsRemaining) do 
					if allyTeam == at or allyTeam == GAIA_ALLY_TEAM then 
						allyTeamsRemaining[i] = nil 
					end 
				end
				if numAllyTeamsRemaining < 2 then
					Spring.GameOver(allyTeamsRemaining)
				end
			end
			destroyQueue[at]=nil
		end
	end
end

function gadget:UnitCreated(u, udid, team)
	isAlive[u] = true
	local ud = UnitDefs[udid]
	local cp = ud.customParams
	if cp and cp.commander then
		local allyTeam = GetUnitAllyTeam(u)
		aliveCount[allyTeam] = aliveCount[allyTeam] + 1
	end
end

function gadget:UnitGiven(u, udid, team)
	local ud = UnitDefs[udid]
	local cp = ud.customParams
	if cp and cp.commander then
		local allyTeam = GetUnitAllyTeam(u)
		aliveCount[allyTeam] = aliveCount[allyTeam] + 1
	end
end

function gadget:UnitDestroyed(u, udid, team)
	isAlive[u] = nil
	local ud = UnitDefs[udid]
	local cp = ud.customParams
	if cp and cp.commander then
		local allyTeam = GetUnitAllyTeam(u)
		aliveCount[allyTeam] = aliveCount[allyTeam] - 1
		if aliveCount[allyTeam] <= 0 then
			destroyQueue[allyTeam] = true
			
		end
	end
end

function gadget:UnitTaken(u, udid, team)
	local ud = UnitDefs[udid]
	local cp = ud.customParams
	if isAlive[u] and cp and cp.commander then
		local allyTeam = GetUnitAllyTeam(u)
		aliveCount[allyTeam] = aliveCount[allyTeam] - 1
		if aliveCount[allyTeam] <= 0 then
			destroyQueue[allyTeam] = true
		end
	end
end

function gadget:Initialize()
	if not endmodes[Spring.GetModOptions().deathmode] then
		gadgetHandler:RemoveGadget()
	end
	for _,t in ipairs(Spring.GetAllyTeamList()) do
		aliveCount[t] = 0
	end
end

else

--UNSYNCED

return false

end
