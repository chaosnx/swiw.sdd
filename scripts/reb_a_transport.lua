include "general/standard_commands.lua"

base = piece("base")
engines = piece("engines")
e1 = piece("e1")
e2 = piece("e2")
e3 = piece("e3")
lwing = piece("lwing")
lmag = piece("lmag")
l1 = piece("l1")
rwing = piece("rwing")
rmag = piece("rmag")
l2 = piece("l2")

local bMoving = false
local exhaustfx = SFX.CEG+1

SMOKEPIECE1 = base
SMOKEPIECE2 = base
SMOKEPIECE3 = base
SMOKEPIECE4 = base
include "general/smokeunit_sws.lua"

UNIT_ROOT = base
UNIT_BELOW_GROUND_DIST = -30
UNIT_RISE_SPEED = 4
DUSTFX = SFX.CEG+2
DUSTFXPT1 = base
DUSTFXPT2 = engines
DUSTFXPT2 = lwing
include "general/rebel_unit_build.lua"

PLACES = {l1, l2}
LAND_DELAY = 7000
DROP_DELAY = 0
DROP_OFFSET = {0.0, 40.0}
include "general/air_transport.lua"

function Exhaust()
    while true do
        while bMoving do
            EmitSfx(e1, exhaustfx)
            EmitSfx(e2, exhaustfx)
            EmitSfx(e3, exhaustfx)
            Sleep(20)
        end
        Sleep(200)
    end
end

function script.Create()
    StartThread(Exhaust)
    StartThread(SmokeUnit_SWS)
    ConstructionAnim()
    Move(base, y_axis, 0)
    StartThread(PickupAndDropFixer)
end

function script.StartMoving()
    if Spring.GetUnitIsDead(unitID) then
        return
    end
    bMoving = true
end

function script.StopMoving()
    if Spring.GetUnitIsDead(unitID) then
        return
    end
    bMoving = false
end

function script.Killed(recentDamage, maxHealth)
    local severity = recentDamage / maxHealth * 100    
    
    Explode(base, SFX.SHATTER)
    Explode(engines, SFX.SHATTER + SFX.FIRE + SFX.SMOKE)
    if severity <= 25 then
        return 1
    elseif severity <= 50 then
        return 2
    elseif severity <= 99 then
        return 3
    end
    return 3        
end 
