
--[[
game/content
-- _G.Spring exists

local unitID = unitID
local unitDefID = unitDefID
local UnitDef = UnitDefs[unitDefID]

local UnitScript = Spring.UnitScript

local EmitSfx = UnitScript.EmitSfx
local Explode = UnitScript.Explode
local GetUnitValue = UnitScript.GetUnitValue
local SetUnitValue = UnitScript.SetUnitValue
local Hide = UnitScript.Hide
local Show = UnitScript.Show

local Move = UnitScript.Move
local Turn = UnitScript.Turn
local Spin = UnitScript.Spin
local StopSpin = UnitScript.StopSpin

local StartThread = UnitScript.StartThread
local Signal = UnitScript.Signal
local SetSignalMask = UnitScript.SetSignalMask
local Sleep = UnitScript.Sleep
local WaitForMove = UnitScript.WaitForMove
local WaitForTurn = UnitScript.WaitForTurn

local x_axis = 1
local y_axis = 2
local z_axis = 3

]]

VFS.Include("LuaRules/Includes/utilities.lua", nil, VFS.ZIP)

--Spring.Echo('_G', table.serialize(_G))

-- for k, v in pairs(_G) do
	-- Spring.Echo(k, v)
-- end

include "general/standard_commands.lua"

local base      = piece "base"
local building1 = piece "building1"
local building2 = piece "building2"
local walle     = piece "walle"
local wallw     = piece "wallw"
local walln     = piece "walln"
local radar     = piece "radar"
local bpt       = piece "bpt"
local shuttle   = piece "shuttle"
local fint      = piece "fint"
local finl      = piece "finl"
local finr      = piece "finr"


SMOKEPIECE1 = base
SMOKEPIECE2 = base
SMOKEPIECE3 = base
SMOKEPIECE4 = base
include "general/smokeunit_sws.lua"

local gameSpeed         = Game.gameSpeed
local pieceNr_pieceName = Spring.GetUnitPieceList ( unitID ) 
local pieceName_pieceNr = Spring.GetUnitPieceMap  ( unitID )

local SIG_ACTIVATE = 2
local SIG_LAND = 3

local isBuilding
local isBuildingNow
local shuttleActive
local shuttleLanded
local shuttleWantTakeoff

local CustomEmitter = function (pieceName, effectName)
	--Spring.Echo(pieceName, effectName)
	local x,y,z,dx,dy,dz    = Spring.GetUnitPiecePosDir(unitID,pieceName)
		   
	Spring.SpawnCEG(effectName, x,y,z, dx, dy, dz)
end

local function Land()
	Spring.Echo('imp_b_barracks Land')
	Signal(SIG_LAND) -- Kill any other copies of this thread
	SetSignalMask(SIG_LAND) -- Allow this thread to be killed by fresh copies
	local builtUnitID = nil
	if (not builtUnitID) then
		Sleep(100)
		builtUnitID = Spring.GetUnitIsBuilding( unitID )
		Spring.Echo('imp_b_barracks Land', builtUnitID )
	end
	-- put build point under base (remove vis)
	--Move(bpt, y_axis, -75)
	-- TODO: You can run any animation that continues throughout the build process here e.g. spin pad
	local progress = select(5, Spring.GetUnitHealth(builtUnitID))
	while (progress < 0.30) do
		Sleep(300)
		progress = select(5, Spring.GetUnitHealth(builtUnitID))
		Spring.Echo('imp_b_barracks build', progress)
	end
	Spring.Echo('imp_b_barracks Land end')

	Spring.Echo('imp_b_barracks Land')
	shuttleActive = 1
	Move        ( shuttle, y_axis, 250, 750)
	WaitForMove ( shuttle, y_axis )
	Move        ( shuttle, y_axis, 125, 325)
	WaitForMove ( shuttle, y_axis )
	Move        ( shuttle, y_axis, 100, 225)
	Turn        ( shuttle, y_axis, math.rad(0), 90 )
	WaitForTurn ( shuttle, y_axis )
	Move        ( shuttle, y_axis, 75, 150)
	WaitForMove ( shuttle, y_axis )
	Move        ( shuttle, y_axis, 75, 150)
	Turn        (    finl, z_axis, math.rad(0), 90 )
	Turn        (    finr, z_axis, math.rad(0), 90 )
	WaitForMove ( shuttle, y_axis )
	Move        ( shuttle, y_axis, 0, 37.5)
	WaitForMove ( shuttle, y_axis )
	
	while (progress > 0.70) do
		Sleep(300)
		progress = select(5, Spring.GetUnitHealth(builtUnitID))
		Spring.Echo('imp_b_barracks build', progress)
	end

	Spring.Echo('imp_b_barracks Takeoff')
	shuttleActive = 1;
	Move        ( shuttle, y_axis, 25, 37)
	WaitForMove ( shuttle, y_axis )
	Move        ( shuttle, y_axis, 50, 75)
	Turn        (    finl, z_axis, math.rad(120), 90 )
	Turn        (    finr, z_axis, math.rad(-120), 90 )
	WaitForMove ( shuttle, y_axis )
	Move        ( shuttle, y_axis, 75, 150)
	WaitForMove ( shuttle, y_axis )
	Move        ( shuttle, y_axis, 100, 225)
	Turn        ( shuttle, y_axis, math.rad(180), 90 )
	WaitForTurn ( shuttle, y_axis )
	Move        ( shuttle, y_axis, 250, 325)
	WaitForMove ( shuttle, y_axis )
	Move        ( shuttle, y_axis, 6250, 750)
	WaitForMove ( shuttle, y_axis )
		
end

local function BuildScript()
	Spring.Echo('imp_b_barracks BuildScript')
	while (true) do
		if (isBuilding) then
			SetUnitValue(COB.BUGGER_OFF, 1)
			isBuildingNow = true		
		end
		Sleep(2000)
	end
end

function script.Create()
	SetUnitValue(COB.YARD_OPEN, 0)
	SetUnitValue(COB.INBUILDSTANCE, 0)
	isBuilding = false
	shuttleActive = 0
	shuttleLanded = 0
	shuttleWantTakeoff=0
	Move( shuttle, y_axis, 6250 )
	Turn( shuttle, y_axis, math.rad(180) )
	Turn( finl, z_axis,  math.rad(120) )
	Turn( finr, z_axis, -math.rad(120) )
	local percent = select(5, Spring.GetUnitHealth(unitID))
	-- local percent = GetUnitValue(COB.BUILD_PERCENT_LEFT) -- BUG always return 0
	while ( percent < 1.0 ) do
		Sleep(100)
		-- percent = GetUnitValue(COB.BUILD_PERCENT_LEFT)
		percent = select(5, Spring.GetUnitHealth(unitID))
		-- Spring.Echo(percent)
	end
	
	Spin( radar, y_axis, math.rad(100) )
    StartThread(BuildScript)
    StartThread(SmokeUnit_SWS)
end

function script.QueryBuildInfo()
	-- Spring.Echo('imp_b_barracks QueryBuildInfo')
	return bpt or base
end

local function OpenCloseAnim(open)
	Spring.Echo('imp_b_barracks OpenCloseAnim', open)
	SetSignalMask(SIG_ACTIVATE) -- Allow this thread to be killed by fresh copies
	Signal(SIG_ACTIVATE) -- Kill any other copies of this thread
	Spring.Echo('YARD_OPEN, BUGGER_OFF, INBUILDSTANCE',GetUnitValue(COB.YARD_OPEN),GetUnitValue(COB.BUGGER_OFF),GetUnitValue(COB.INBUILDSTANCE))
	if open then
		isBuilding = true
	else
		isBuilding = false
	end

	Spring.Echo("OpenCloseAnim", GetUnitValue(COB.YARD_OPEN), open)
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
	Spring.Echo('imp_b_barracks OpenCloseAnim end')
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

-- script.StartBuilding(heading, angle)
function script.StartBuilding(...)
	local t = {...}
	Spring.Echo('imp_b_barracks StartBuilding', table.serialize(t) )
	for k, v in pairs(t) do
		Spring.Echo(k, v)
	end
	if (select('#',t)==2) then 
	end
	StartThread(Land)
end

function script.StopBuilding()
	Spring.Echo('imp_b_barracks StopBuilding' )
	Move(bpt, y_axis, 0)
	-- TODO: You can run any animation that signifies the end of the build process here
	Sleep(5000)
end

function script.Killed(recentDamage, maxHealth)
	Spring.Echo('imp_b_barracks StartBuilding', recentDamage, maxHealth)
    local severity = recentDamage / maxHealth * 100

    Explode(base, SFX.SHATTER)
    if severity <= 25 then
        return 1
    elseif severity <= 50 then
        return 2
    elseif severity <= 99 then
        return 3
    end
    return 3        
end