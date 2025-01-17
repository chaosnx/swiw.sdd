-- Author: Tobi Vollebregt
-- License: GNU General Public License v2

--[[
This class is implemented as a single function returning a table with public
interface methods.  Private data is stored in the function's closure.

Public interface:

local WaypointMgr = CreateWaypointMgr()

function WaypointMgr.GameStart()
function WaypointMgr.GameFrame(f)
function WaypointMgr.UnitCreated(unitID, unitDefID, unitTeam, builderID)

function WaypointMgr.GetGameFrameRate()
function WaypointMgr.GetWaypoints()
function WaypointMgr.GetTeamStartPosition(myTeamID)
function WaypointMgr.GetFrontline(myTeamID, myAllyTeamID)
	Returns frontline, previous. Frontline is the set of waypoints adjacent

]]--

function CreateWaypointMgr()

-- constants
local GAIA_TEAM_ID    = Spring.GetGaiaTeamID()
local GAIA_ALLYTEAM_ID      -- initialized later on..
local FLAG_RADIUS     = FLAG_RADIUS
local WAYPOINT_RADIUS = 500
local WAYPOINT_HEIGHT = 100

-- speedups
local Log = Log
local GetUnitsInBox = Spring.GetUnitsInBox
local GetUnitsInCylinder = Spring.GetUnitsInCylinder
local GetUnitDefID = Spring.GetUnitDefID
local GetUnitTeam = Spring.GetUnitTeam
local GetUnitAllyTeam = Spring.GetUnitAllyTeam
local GetUnitPosition = Spring.GetUnitPosition
local sqrt = math.sqrt
local isFlag = gadget.flags

-- class
local WaypointMgr = {}

-- Array containing the waypoints and adjacency relations
-- Format: { { x = x, y = y, z = z, adj = {}, --[[ more properties ]]-- }, ... }
local waypoints = {}
local index = 0      -- where we are with updating waypoints

-- Dictionary mapping unitID of flag to waypoint it is in.
local flags = {}

-- Format: { [team1] = allyTeam1, [team2] = allyTeam2, ... }
local teamToAllyteam = {}

-- caches result of CalculateFrontline..
local frontlineCache = {}

-- caches result of Spring.GetTeamStartPosition
local teamStartPosition = {}


local function GetDist2D(x, z, p, q)
	local dx = x - p
	local dz = z - q
	return sqrt(dx * dx + dz * dz)
end


-- Returns the nearest waypoint to point x, z, and the distance to it.
local function GetNearestWaypoint2D(x, z)
	local minDist = 1.0e20
	local nearest
	for _,p in ipairs(waypoints) do
		local dist = GetDist2D(x, z, p.x, p.z)
		if (dist < minDist) then
			minDist = dist
			nearest = p
		end
	end
	return nearest, minDist
end


-- This calculates the set of waypoints which are
--  1) adjacent to waypoints possessed by an enemy, and
--  2) not possessed by any (other) enemy, and
--  3) reachable from hq, without going through enemy waypoints.
local function CalculateFrontline(myTeamID, myAllyTeamID)
	-- mark all waypoints adjacent to any enemy waypoints,
	-- and create a set of all enemy waypoints in 'blocked'.
	local marked = {}
	local blocked = {}
	for _,p in ipairs(waypoints) do
		if ((p.owner or myAllyTeamID) ~= myAllyTeamID) then
			blocked[p] = true
			for a,edge in pairs(p.adj) do
				if ((a.owner or myAllyTeamID) == myAllyTeamID) then
					marked[a] = true
				end
			end
		end
	end

	-- block all edges which connect two frontline waypoints
	-- (ie. prevent units from pathing over the frontline..)
	for p,_ in pairs(marked) do
		for a,edge in pairs(p.adj) do
			if marked[a] then
				blocked[edge] = true
			end
		end
	end

	-- "perform a Dijkstra" starting at HQ
	local hq = teamStartPosition[myTeamID]
	local previous = PathFinder.Dijkstra(waypoints, hq, blocked)

	-- now 'frontline' is intersection between 'marked' and 'previous'
	local frontline = {}
	for p,_ in pairs(marked) do
		if previous[p] then
			frontline[#frontline+1] = p
		end
	end

	return frontline, previous
end


-- Called everytime a waypoint changes owner.
-- A waypoint changes owner when compared to previous update,
-- a different allyteam now possesses ALL units near the waypoint.
local function WaypointOwnerChange(waypoint, newOwner)
	local oldOwner = waypoint.owner
	waypoint.owner = newOwner

	Log("WaypointOwnerChange ", waypoint.x, ", ", waypoint.z, ": ",
		(oldOwner or "neutral"), " -> ", (newOwner or "neutral"))

	if (oldOwner ~= nil) then
		-- invalidate cache for oldOwner
		for t,at in pairs(teamToAllyteam) do
			if (at == oldOwner) then
				frontlineCache[t] = nil
			end
		end
	end

	if (newOwner ~= nil) then
		-- invalidate cache for newOwner
		for t,at in pairs(teamToAllyteam) do
			if (at == newOwner) then
				frontlineCache[t] = nil
			end
		end
	end
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--
--  Waypoint prototype (Waypoint public interface)
--  TODO: do I actually need this... ?
--

local Waypoint = {}
Waypoint.__index = Waypoint

function Waypoint:GetFriendlyUnitCount(myAllyTeamID)
	return self.allyTeamUnitCount[myAllyTeamID] or 0
end

function Waypoint:GetEnemyUnitCount(myAllyTeamID)
	local sum = 0
	for at,count in pairs(self.allyTeamUnitCount) do
		if (at ~= myAllyTeamID) then
			sum = sum + count
		end
	end
	return sum
end

function Waypoint:AreAllFlagsCappedByAllyTeam(myAllyTeamID)
	for _,f in pairs(self.flags) do
		if (GetUnitAllyTeam(f) ~= myAllyTeamID) then
			return false
		end
	end
	return true
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--
--  WaypointMgr public interface
--

function WaypointMgr.GetGameFrameRate()
	-- returns every how many frames GameFrame should be called.
	-- currently I set this so each waypoint is updated every 30 sec (= 900 frames)
	return math.floor(900 / #waypoints)
end

function WaypointMgr.GetWaypoints()
	return waypoints
end

function WaypointMgr.GetTeamStartPosition(myTeamID)
	return teamStartPosition[myTeamID]
end

function WaypointMgr.GetFrontline(myTeamID, myAllyTeamID)
	if (not frontlineCache[myTeamID]) then
		frontlineCache[myTeamID] = { CalculateFrontline(myTeamID, myAllyTeamID) }
	end
	return unpack(frontlineCache[myTeamID])
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--
--  The call-in routines
--

function WaypointMgr.GameStart()
	-- Can not run this in the initialization code at the end of this file,
	-- because at that time Spring.GetTeamStartPosition seems to always return 0,0,0.
	for _,t in ipairs(Spring.GetTeamList()) do
		if (t ~= GAIA_TEAM_ID) then
			local x, y, z = Spring.GetTeamStartPosition(t)
			if x and x ~= 0 then
				teamStartPosition[t] = GetNearestWaypoint2D(x, z)
			end
		end
	end
end

function WaypointMgr.GameFrame(f)
	index = (index % #waypoints) + 1
	--Log("WaypointMgr: updating waypoint ", index)
	local p = waypoints[index]
	p.flags = {}

	-- Update p.allyTeamUnitCount
	-- Box check (as opposed to Rectangle, Sphere, Cylinder),
	-- because this allows us to easily exclude aircraft.
	local x1, y1, z1 = p.x - WAYPOINT_RADIUS, p.y - WAYPOINT_HEIGHT, p.z - WAYPOINT_RADIUS
	local x2, y2, z2 = p.x + WAYPOINT_RADIUS, p.y + WAYPOINT_HEIGHT, p.z + WAYPOINT_RADIUS
	local allyTeamUnitCount = {}
	for _,u in ipairs(GetUnitsInBox(x1, y1, z1, x2, y2, z2)) do
		local ud = GetUnitDefID(u)
		local at = GetUnitAllyTeam(u)
		if isFlag[ud] then
			local x, y, z = GetUnitPosition(u)
			local dist = GetDist2D(x, z, p.x, p.z)
			if (dist < FLAG_RADIUS) then
				p.flags[#p.flags+1] = u
				flags[p] = u
				--Log("Flag ", u, " (", at, ") is near ", p.x, ", ", p.z)
			end
		elseif (UnitDefs[ud].speed == 0) and (at ~= GAIA_ALLYTEAM_ID) then
			allyTeamUnitCount[at] = (allyTeamUnitCount[at] or 0) + 1
		end
	end
	p.allyTeamUnitCount = allyTeamUnitCount

	-- Update p.owner
	local owner = nil
	for at,count in pairs(allyTeamUnitCount) do
		if (owner == nil) then
			if (allyTeamUnitCount[at] > 0) then owner = at end
		else
			if (allyTeamUnitCount[at] > 0) then owner = p.owner break end
		end
	end
	if (owner ~= p.owner) then
		WaypointOwnerChange(p, owner)
	end
end

--------------------------------------------------------------------------------
--
--  Unit call-ins
--

function WaypointMgr.UnitCreated(unitID, unitDefID, unitTeam, builderID)
	if isFlag[unitDefID] then
		-- This is O(n*m), with n = number of flags and m = number of waypoints.
		local x, y, z = GetUnitPosition(unitID)
		local p, dist = GetNearestWaypoint2D(x, z)
		if (dist < FLAG_RADIUS) then
			p.flags[#p.flags+1] = unitID
			flags[unitID] = p
			Log("Flag ", unitID, " is near ", p.x, ", ", p.z)
		end
	end
end

function WaypointMgr.UnitDestroyed(unitID, unitDefID, unitTeam, attackerID, attackerDefID, attackerTeam)
	if isFlag[unitDefID] then
		local p = flags[unitID]
		if p then
			flags[unitID] = nil
			for i=1,#p.flags do
				if (p.flags[i] == unitID) then
					table.remove(p.flags, i)
					break
				end
			end
		end
	end
end

--------------------------------------------------------------------------------
--
--  Initialization
--

do

local function LoadFile(filename)
	local text = VFS.LoadFile(filename, VFS.ZIP)
	if (text == nil) then
		Warning("Failed to load: ", filename)
		return nil
	end
	Warning("Map waypoint profile found. Loading waypoints.")
	local chunk, err = loadstring(text, filename)
	if (chunk == nil) then
		Warning("Failed to load: ", filename, "  (", err, ")")
		return nil
	end
	return chunk
end

local function AddWaypoint(x, y, z)
	local waypoint = {
		x = x, y = y, z = z, --position
		adj = {},            --map of adjacent waypoints -> edge distance
		flags = {},          --array of flag unitIDs
		allyTeamUnitCount = {},
	}
	setmetatable(waypoint, Waypoint)
	waypoints[#waypoints+1] = waypoint
	return waypoint
end

local function GetWaypointDist2D(a, b)
	local dx = a.x - b.x
	local dz = a.z - b.z
	return sqrt(dx * dx + dz * dz)
end

local function AddConnection(a, b)
	local edge = {dist = GetWaypointDist2D(a, b)}
	a.adj[b] = edge
	b.adj[a] = edge
end

-- load chunk
local chunk = LoadFile("LuaRules/Configs/craig/maps/" .. Game.mapName .. ".smf.lua")
if (chunk == nil) then
	Warning("No waypoint profile found. Will not use waypoints on this map.")
	return false
end

-- execute chunk
setfenv(chunk, { AddWaypoint = AddWaypoint, AddConnection = AddConnection })
chunk()
Log(#waypoints, " waypoints succesfully loaded.")

-- make map of teams to allyTeams
-- this must contain not only AI teams, but also player teams!
for _,t in ipairs(Spring.GetTeamList()) do
	if (t ~= GAIA_TEAM_ID) then
		local _,_,_,_,_,at = Spring.GetTeamInfo(t)
		teamToAllyteam[t] = at
	end
end

-- find GAIA_ALLYTEAM_ID
local _,_,_,_,_,at = Spring.GetTeamInfo(GAIA_TEAM_ID)
GAIA_ALLYTEAM_ID = at

end
return WaypointMgr
end

-- commit: 7b17e5e6741b7ce8e2299e550b4373f84411980f
