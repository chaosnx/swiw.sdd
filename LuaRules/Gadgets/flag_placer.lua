function gadget:GetInfo()
   return {
      name      = "Flag placer",
      desc      = "Places holobeacons on the map",
      author    = "user/Gnome/TheFatController", --Profile loader segment by Gnome, automatic map parser by user
      date      = "August 2008",
      license   = "CC by-nc, version 3.0",
      layer     = -5,
      enabled   = true  --  loaded by default?
   }
end

--------------------------------------------------------------------------------
-- function localisations
local floor						= math.floor

-- easymetal constants
local EXTRACT_RADIUS = Game.extractorRadius > 125 and Game.extractorRadius or 125
local GRID_SIZE	= Game.squareSize
local THRESH_FRACTION = 0.4
local MAP_WIDTH = floor(Game.mapSizeX / GRID_SIZE)
local MAP_HEIGHT = floor(Game.mapSizeZ / GRID_SIZE)
Spring.Echo("MAP_WIDTH,MAP_HEIGHT,GRID_SIZE",MAP_WIDTH,MAP_HEIGHT,GRID_SIZE)

-- variables
local maxMetal = 1
local metalSpots = {}
local metalSpotCount	= 0
local metalData = {}
local metalDataCount = 0

local buoySpots = {}
local numBuoySpots = 0

local flagTypes = {"a_p_flag"}
local flags = {} -- flags[flagType][index] == flagUnitID
local numFlags = {} -- numFlags[flagType] == numberOfFlagsOfType
local flagTypeData = {} -- flagTypeData[flagType] = {radius = radius, etc}
local flagTypeSpots = {} -- flagTypeSpots[flagType][metalSpotCount] == {x = x_coord, z = z_coord}
local flagTypeCappers = {} -- cappers[flagType][unitID] = true
local flagTypeDefenders	= {} -- defenders[flagType][unitID] = true

for _, flagType in pairs(flagTypes) do
	local cp = UnitDefNames[flagType].customParams
	flagTypeData[flagType] = {
		radius = tonumber(cp.flagradius) or 230, -- radius of flagTypes capping area
		capThreshold = tonumber(cp.capthreshold) or 10, -- number of capping points needed for flagType to switch teams
		regen = tonumber(cp.flagregen) or 1, -- how fast a flagType with no defenders or attackers will reduce capping statuses
		tooltip = UnitDefNames[flagType].tooltip or "Flag", -- what to call the flagType when it switches teams
		limit = cp.flaglimit or Game.maxUnits, -- How many of this flagType a player can hold at once
	}
	flags[flagType] = {}
	numFlags[flagType] = 0
	flagTypeSpots[flagType] = {}
	flagTypeCappers[flagType] = {}
	flagTypeDefenders[flagType] = {}
end

if (gadgetHandler:IsSyncedCode()) then

local spawnList = {}
local placedList = {}
local flagDefs
local mapProfile
local flagnum = 1
local updateFrame = 2
local spawnCount = 0
local gaiaID
local GetUnitsInCylinder		= Spring.GetUnitsInCylinder
local SetUnitNeutral 			= Spring.SetUnitNeutral
local SetUnitBlocking 			= Spring.SetUnitBlocking
local GetUnitDefID 				= Spring.GetUnitDefID
local GetGroundInfo 			= Spring.GetGroundInfo
local GetMetalAmount 			= Spring.GetMetalAmount
local GetGroundHeight			= Spring.GetGroundHeight
local SetUnitCOBValue			= Spring.SetUnitCOBValue
local GetUnitCOBValue 			= Spring.GetUnitCOBValue
local SetUnitAlwaysVisible 		= Spring.SetUnitAlwaysVisible

local function getDistance(x1,z1,x2,z2)
  local dx,dz = x1-x2,z1-z2
  return (dx*dx)+(dz*dz)
end


-- easymetal code starts
local function round(num, idp)
  local mult = 10^(idp or 0)
  return floor(num * mult + 0.5) / mult
end


local function mergeToSpot(spotNum, px, pz, pWeight)
	local sx = metalSpots[spotNum].x
	local sz = metalSpots[spotNum].z
	local sWeight = metalSpots[spotNum].weight

	local avgX, avgZ

	if sWeight > pWeight then
		local sStrength = round(sWeight / pWeight)
		avgX = (sx*sStrength + px) / (sStrength +1)
		avgZ = (sz*sStrength + pz) / (sStrength +1)
	else
		local pStrength = (pWeight / sWeight)
		avgX = (px*pStrength + sx) / (pStrength +1)
		avgZ = (pz*pStrength + sz) / (pStrength +1)
	end

	metalSpots[spotNum].x = avgX
	metalSpots[spotNum].z = avgZ
	metalSpots[spotNum].weight = sWeight + pWeight
end


local function NearSpot(px, pz, dist)
	for k, spot in pairs(metalSpots) do
		local sx, sz = spot.x, spot.z
		if (px-sx)^2 + (pz-sz)^2 < dist then
			return k
		end
	end
	return false
end

local function AnalyzeMetalMap()
	local maxMetal = 1

	for mx_i = 1, MAP_WIDTH do
		for mz_i = 1, MAP_HEIGHT do
			local mx = mx_i * GRID_SIZE
			local mz = mz_i * GRID_SIZE
			-- 104.0.1: Spring.GetGroundInfo returns different values. Better
			-- using Spring.GetMetalAmount
			local mCur = GetMetalAmount(mx / (GRID_SIZE * 2),
			                            mz / (GRID_SIZE * 2))
			--mCur = floor(mCur * 100)
			if (mCur > maxMetal) then
				maxMetal = mCur
			end
		end
	end

	local lowMetalThresh = floor(maxMetal * THRESH_FRACTION)

	for mx_i = 1, MAP_WIDTH do
		for mz_i = 1, MAP_HEIGHT do
			local mx = mx_i * GRID_SIZE
			local mz = mz_i * GRID_SIZE
			-- Storing metalMap may be too much memory consuming. Even more if
			-- a wrong GRID_SIZE is choosen (like it happened before). Hence, is
			-- better calling GetMetalAmount again (since it is pure C
			-- implementation, it would be even faster!).
			local mCur = GetMetalAmount(mx / (GRID_SIZE * 2),
			                            mz / (GRID_SIZE * 2))
			if mCur > lowMetalThresh then
				metalDataCount = metalDataCount +1

				metalData[metalDataCount] = {
					x = mx_i * GRID_SIZE,
					z = mz_i * GRID_SIZE,
					metal = mCur
				}

			end
		end
	end

	table.sort(metalData, function(a,b) return a.metal > b.metal end)

	for index = 1, metalDataCount do
		local mx = metalData[index].x
		local mz = metalData[index].z
		local mCur = metalData[index].metal
		local underwater = GetGroundHeight(mx, mz) <= 0

		local nearSpotNum = NearSpot(mx, mz, EXTRACT_RADIUS*EXTRACT_RADIUS)

		if nearSpotNum then
			mergeToSpot(nearSpotNum, mx, mz, mCur)
		else
			metalSpotCount = metalSpotCount + 1
			metalSpots[metalSpotCount] = {
				x = mx,
				z = mz,
				weight = mCur,
				underwater = underwater
			}
		end
	end

	local controlPoints = { buoy = {}, flag = {} }

	for _, spot in pairs(metalSpots) do
		if spot.underwater then
			table.insert(controlPoints['buoy'], spot)
		else
			table.insert(controlPoints['flag'], spot)
		end
	end

	Spring.Echo('AnalyzeMetalMap', controlPoints)
	return controlPoints
end

-- this function is used to add any additional flagType specific behaviour
function FlagSpecialBehaviour(flagType, flagID, flagTeamID, teamID)
	if flagType == "flag" then
		local env = Spring.UnitScript.GetScriptEnv(flagID)
		Spring.UnitScript.CallAsUnit(flagID, env.script.Create, teamID)
	end
end

function PlaceFlag(spot, flagType, unitID)
	if DEBUG then
		Spring.Echo("{")
		Spring.Echo("	x = " .. spot.x .. ",")
		Spring.Echo("	z = " .. spot.z .. ",")
		Spring.Echo("	initialProduction = 5, --default value. change!")
		Spring.Echo("},")
	end

	local newFlag = unitID or CreateUnit(flagType, spot.x, 0, spot.z, 0, GAIA_TEAM_ID)

	-- this is picked up in game_handleFlagReturns to actually produce the
	-- resources
	if spot.initialProduction then
		SetUnitRulesParam(newFlag, "map_config_init_production", spot.initialProduction, {public = true})
	end

	numFlags[flagType] = numFlags[flagType] + 1
	flags[flagType][numFlags[flagType]] = newFlag
	flagCapStatuses[newFlag] = {}

	SetUnitBlocking(newFlag, false, false, false)
	SetUnitNeutral(newFlag, true)
	SetUnitNoSelect(newFlag, true)
	SetUnitAlwaysVisible(newFlag, true)


	if modOptions and modOptions.always_visible_flags == "0" then
		-- Hide the flags after a 1 second (30 frame) delay so they are ghosted
		GG.Delay.DelayCall(SetUnitAlwaysVisible, {newFlag, false}, 30)
	end

	
	table.insert(GG.flags, newFlag)
end


function gadget:Initialize()

	flagDefs = VFS.Include('gamedata/LuaConfigs/flag_spawner.lua')
	if not flagDefs then
		Spring.Echo("Neutral Flag Spawner - no mod profile found. Gamedata/LuaConfigs/flag_spawner.lua")
		gadgetHandler:RemoveGadget()
	end

	local mapProfileName = string.gsub(Game.mapName, '.smf', '.lua', 1)
	if(VFS.FileExists('maps/' .. mapProfileName)) then
		mapProfile = VFS.Include('maps/' .. mapProfileName)
	end
	
	if(mapProfile) then
		for _,hotspot in ipairs(mapProfile) do
			table.insert(spawnList, {unitName = flagDefs.neutralFlag, x = hotspot.x, z = hotspot.z, feature = hotspot.feature})
		end
	else
	
		-- TODO: for loop this somehow (table values can't be called, table keys can?)
		local generatedSpots = AnalyzeMetalMap()
		-- no flag profile found, use metal map for flag spawns
		if #flagTypeSpots["a_p_flag"] == 0 then
			Spring.Log('flag manager', 'info', "Map Flag Profile not found. Using autogenerated Flag positions...")
			flagTypeSpots['a_p_flag'] = generatedSpots['flag']
		end
		-- no buoy profile found, use metal map for flag spawns
		--if #flagTypeSpots["buoy"] == 0 then
		--	Spring.Log('flag manager', 'info', "Map Buoy Profile not found. Using autogenerated Buoy positions...")
		--	flagTypeSpots['buoy'] = generatedSpots['buoy']
		--end

		-- populated by placeFlag
		Spring.Echo("flagname", flagDefs)
		for _, flagType in pairs(flagTypes) do
			for i = 1, #flagTypeSpots[flagType] do
				local sx, sz = flagTypeSpots[flagType][i].x, flagTypeSpots[flagType][i].z
				--local units = GetUnitsInCylinder(sx, sz, 1)
				--Spring.Echo('units',table.serialize(units),i,sx,sz)
				--for _, unitID in pairs(units) do
					--local name = UnitDefs[GetUnitDefID(unitID)].name
					--if name == flagType then
						--PlaceFlag(flagTypeSpots[flagType][i], flagType, unitID)
						table.insert(spawnList, {unitName = flagDefs.neutralFlag, x = sx, z = sz, feature = flagDefs.defaultFeature})
						--break
					--end
				--end
			end
		end
		
		spawnCount = #spawnList
		
	end
	
	
end

local counter=0 --counts over all frames

function gadget:GameFrame(n)

    if n == updateFrame then
        gaiaID = Spring.GetGaiaTeamID()

        local count = 0
        local limit = (spawnCount / 5)

		for i,spawnDef in pairs(spawnList) do
			local flagID = Spring.CreateUnit(spawnDef.unitName, spawnDef.x, 0, spawnDef.z,0,gaiaID)
			SetUnitNeutral(flagID,true)
--			Spring.SetUnitNoDraw(flagID, true)
--			Spring.SetUnitNoMinimap(flagID, true)
			SetUnitAlwaysVisible(flagID,true)
			counter=counter+1
			-- SetUnitCOBValue(flagID,4096,counter) --4096 = first global var
			-- SetUnitCOBValue(flagID,4096+counter,GetUnitCOBValue(flagID,9)) --9 = UNIT_XZ

			local flag = {}
			flag.x = spawnDef.x
			flag.z = spawnDef.z
			flag.teamID = gaiaID
			flag.allyID = -1
			flag.unitList = {}
			flag.unitRepairList = {}
			flag.unitID = flagID
			flag.unitDefID = GetUnitDefID(flagID)
			flag.name = UnitDefs[flag.unitDefID].name
			flag.alwaysVisible = false
			_G.flags[flagnum] = flag
			flagnum = flagnum + 1		
		
			if spawnDef.feature then
				Spring.CreateFeature(spawnDef.feature,spawnDef.x,100,spawnDef.z,0)
			end
		
			spawnList[i] = nil
			count = count + 1
			if count > limit then
			  updateFrame = n+1
			  break
			end
			
		end
	-- all flags spawned, disable gadget
	if #spawnList == 0 then
		gadgetHandler:RemoveGadget()
	end
    end
end --end GameFrame()

end --end synced
