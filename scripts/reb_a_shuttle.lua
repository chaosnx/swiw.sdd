include "general/standard_commands.lua"

base = piece("base")
door = piece("door")
finr = piece("finr")
finl = piece("finl")
enginer = piece("enginer")
rotorsr = piece("rotorsr")
enginel = piece("enginel")
rotorsl = piece("rotorsl")
p1 = piece("p1")
p2 = piece("p2")
p3 = piece("p3")
p4 = piece("p4")
p5 = piece("p5")
p6 = piece("p6")
p7 = piece("p7")
p8 = piece("p8")
p9 = piece("p9")
p10 = piece("p10")

SMOKEPIECE1 = base
SMOKEPIECE2 = base
SMOKEPIECE3 = base
SMOKEPIECE4 = base
include "general/smokeunit_sws.lua"

UNIT_ROOT = base
UNIT_BELOW_GROUND_DIST = -55
UNIT_RISE_SPEED = 4
DUSTFX = SFX.CEG+1
DUSTFXPT1 = base
DUSTFXPT2 = door
include "general/rebel_unit_build.lua"

PLACES = {p1, p2, p3, p4, p5, p6, p7, p8, p9, p10}
LAND_DELAY = 2000
DROP_DELAY = 0
DROP_OFFSET = {0.0, 80.0}
function BEGIN_TRANSPORT(passengerID)
    Turn(door, x_axis, 0, math.rad(120))
    Sleep(1000)
    Turn(door, x_axis, math.rad(-102), math.rad(120))
end
function TRANSPORT_DROP(passengerID)
    Turn(door, x_axis, 0, math.rad(120))
    Sleep(2000)
    Turn(door, x_axis, math.rad(-102), math.rad(120))
end
include "general/air_transport.lua"

function script.Create()
    Turn(door, x_axis, math.rad(-102))
    StartThread(SmokeUnit_SWS)
    ConstructionAnim()
    Move(base, y_axis, 0)
    StartThread(PickupAndDropFixer)
end

function script.Killed(recentDamage, maxHealth)
    local severity = recentDamage / maxHealth * 100

    Explode(base, SFX.SHATTER)
    Explode(enginer, SFX.FALL + SFX.FIRE + SFX.SMOKE)
    Explode(enginel, SFX.FALL + SFX.FIRE + SFX.SMOKE)
    if severity <= 25 then
        return 1
    elseif severity <= 50 then
        return 2
    elseif severity <= 99 then
        return 3
    end
    return 3        
end