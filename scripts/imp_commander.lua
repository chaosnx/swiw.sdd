include "general/standard_commands.lua"

local piece_list =    [[base door1 door2 wall wdoor1 wdoor2
						tl1base tl1turret tl1sleeves tl1b1 tl1f1 tl1b2 tl1f2
						tl2base tl2turret tl2sleeves tl2b1 tl2f1 tl2b2 tl2f2
						tl3base tl3turret tl3sleeves tl3b1 tl3f1 tl3b2 tl3f2
						tl4base tl4turret tl4sleeves tl4b1 tl4f1 tl4b2 tl4f2
						dishriser dishturret dish antennae banners shield1 shield2 bpt
						l1aa1base l1aa1turret l1aa1trooper l1aa1b1 l1aa1f1 l1aa1b2 l1aa1f2 l1aa1b3 l1aa1f3 l1aa1b4 l1aa1f4
						l1aa2base l1aa2turret l1aa2trooper l1aa2b1 l1aa2f1 l1aa2b2 l1aa2f2 l1aa2b3 l1aa2f3 l1aa2b4 l1aa2f4
						l2aa1base l2aa1turret l2aa1b1 l2aa1f1 l2aa1b2 l2aa1f2 l2aa1b3 l2aa1f3 l2aa1b4 l2aa1f4
						l2aa2base l2aa2turret l2aa2b1 l2aa2f1 l2aa2b2 l2aa2f2 l2aa2b3 l2aa2f3 l2aa2b4 l2aa2f4]]

local pieces = {}
for substring in piece_list:gmatch("%S+") do
   pieces[substring] = piece(substring)
end

-- next, hide the inactive upgrades for this variant
local inactive_list = [[wall
						wdoor1
						wdoor2
						banners
						shield1  shield2
						dishriser  dishturret  dish
						tl1base  tl1turret  tl1sleeves  tl1b1  tl1b2
						tl2base  tl2turret  tl2sleeves  tl2b1  tl2b2
						tl3base  tl3turret  tl3sleeves  tl3b1  tl3b2
						tl4base  tl4turret  tl4sleeves  tl4b1  tl4b2
						l1aa1base  l1aa1turret  l1aa1trooper  l1aa1b1  l1aa1b2  l1aa1b3  l1aa1b4
						l1aa2base  l1aa2turret  l1aa2trooper  l1aa2b1  l1aa2b2  l1aa2b3  l1aa2b4
						l2aa1base  l2aa1turret  l2aa1b1  l2aa1b2  l2aa1b3  l2aa1b4
						l2aa2base  l2aa2turret  l2aa2b1  l2aa2b2  l2aa2b3  l2aa2b4]]

local inactives = {}
for substring in inactive_list:gmatch("%S+") do
   table.insert(inactives, substring )
end

local flares_list   = [[tl1f1  tl1f2  tl2f1  tl2f2  tl3f1  tl3f2  tl4f1  tl4f2
						l1aa1f1  l1aa1f2  l1aa1f3  l1aa1f4
						l1aa2f1  l1aa2f2  l1aa2f3  l1aa2f4
						l2aa1f1  l2aa1f2  l2aa1f3  l2aa1f4
						l2aa2f1  l2aa2f2  l2aa2f3  l2aa2f4]]
local flares = {}
for substring in flares_list:gmatch("%S+") do
   table.insert(flares, substring )
end

SMOKEPIECE1 = base
SMOKEPIECE2 = dishriser
SMOKEPIECE3 = shield1
SMOKEPIECE4 = shield2

include "general/smokeunit_sws.lua"

local SIG_ACTIVATE=2
local SIG_BUILDING=4

local function BuildAnim()
	Signal(SIG_BUILDING) -- Kill any other copies of this thread
	SetSignalMask(SIG_BUILDING) -- Allow this thread to be killed by fresh copies
	local door1 = pieces['door1']
	local door2 = pieces['door2']
	local wdoor1 = pieces['wdoor1']
	local wdoor2 = pieces['wdoor2']
	local builtUnitID = Spring.GetUnitIsBuilding( unitID )
	while (not builtUnitID) do
		Sleep(100)
		builtUnitID = Spring.GetUnitIsBuilding( unitID )
	end
	local health, maxHealth, paralyze, capture, build = Spring.GetUnitHealth(builtUnitID)
	while(build < 1.0) do
		if(build <= 10) then
			Move(door1, x_axis,  12.5, 12.5)
			Move(door2, x_axis, -12.5, 12.5)
			Sleep(1000)
			Move(wdoor1, x_axis,  37.5, 12.5)
			Move(wdoor2, x_axis, -37.5, 12.5)
		end
		Sleep(100)
		health, maxHealth, paralyze, capture, build = Spring.GetUnitHealth(builtUnitID)
	end
	Sleep(3000)
	Move(wdoor1, x_axis,  0, 12.5)
	Move(wdoor2, x_axis, -0, 12.5)
	Sleep(1000)
	Move(door1, x_axis,  0, 12.5)
	Move(door2, x_axis,  0, 12.5)
end

function script.Create()
	for k,v in pairs(inactives) do 
		Hide(pieces[v])
	end
	for k,v in pairs(flares) do 
		Hide(pieces[v])
	end

    StartThread(SmokeUnit_SWS)
end

function script.QueryNanoPiece()
	local bpt = pieces['bpt']
	return bpt
end

function script.QueryBuildInfo()
	local bpt = pieces['bpt']
	return bpt
end

local function OpenCloseAnim(open)
	Signal(SIG_ACTIVATE) -- Kill any other copies of this thread
	SetSignalMask(SIG_ACTIVATE) -- Allow this thread to be killed by fresh copies
	if open then
		isBuilding = true
	else
		isBuilding = false
	end
	
	local count = 0
	while not (GetUnitValue(COB.YARD_OPEN) == open) do
		count = count + 1
		if count > 1 then Spring.Echo("Loop needed! Inform FLOZi immediately!!", count, UnitDefs[unitDefID].name) end
		SetUnitValue(COB.BUGGER_OFF, 1)
		Sleep(1500)
		SetUnitValue(COB.YARD_OPEN, open)
	end
	SetUnitValue(COB.BUGGER_OFF, not open)
	SetUnitValue(COB.INBUILDSTANCE, open)
end

-- Called when factory opens
-- Non Threaded Scope Function
function script.Activate()
	-- OpenCloseAnim must be threaded to call Sleep() or WaitFor functions
	StartThread(OpenCloseAnim, 1)
end

-- Called when factory closes
-- Non Threaded Scope Function
function script.Deactivate()
	-- OpenCloseAnim must be threaded to call Sleep() or WaitFor functions
	StartThread(OpenCloseAnim, 0)
end

function script.StartBuilding(heading, pitch)
	StartThread(BuildAnim)
	local bpt = pieces['bpt']
	Move(bpt, y_axis, -75)
	-- TODO: You can run any animation that signifies the end of the build process here
	Sleep(500)
end


function script.StopBuilding()
	local bpt = pieces['bpt']
	Move(pieces['bpt'], y_axis, 0)
	-- TODO: You can run any animation that signifies the end of the build process here
	Sleep(500)
end

function script.Killed(recentDamage, maxHealth)
    local severity = recentDamage / maxHealth * 100

    Explode(base, SFX.NONE)
    if severity <= 25 then
        return 1
    elseif severity <= 50 then
        return 2
    elseif severity <= 99 then
        return 3
    end
    return 3        
end