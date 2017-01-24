include "general/standard_commands.lua"

base = piece("base")
torso = piece("torso")
shoulders = piece("shoulders")
ruparm = piece("ruparm")
luparm = piece("luparm")
rloarm = piece("rloarm")
lloarm = piece("lloarm")
pelvis = piece("pelvis")
rthigh = piece("rthigh")
lthigh = piece("lthigh")
chest = piece("chest")
lleg = piece("lleg")
rleg = piece("rleg")
head = piece("head")
comp1 = piece("comp1")
comp2 = piece("comp2")
blink = piece("blink")
-- Small hack to can use the trooper scripts
gun = comp1
flare = blink


bMoving = false
runSpeed = 0
maxAngle = 0
randomSeed = math.random(10, 60)
alreadyEngaged = false
inBunker = 0
randHead = 1
idleAnim = false
maxSpeed = 0

REBEL = 1
USE_STANCE = SPY_STANCE
NORMAL_SPEED = 14
NORMAL_MAX_ANGLE = 150
CLOAK_MAX_SPEED = 14.2
CLOAK_SPEED = 5
CLOAK_MAX_ANGLE = 100
MUZZLEFLASH1 = SFX.CEG+0
Z_UP = true  -- Use that for DAE exported objects
include "general/infantry.lua"

function script.Create()
    bMoving = false
    randomSeed = math.random(10, 60)
    maxSpeed = Spring.GetUnitMoveTypeData(unitID).maxSpeed
    WeaponReady()
    StartThread(LimitSpeed)
end

function LimitSpeed()
    -- Check that the user is not cheating to get more velocity
    while true do
        if bMoving then
            if(Spring.GetUnitIsCloaked(unitID)) then
                Spring.MoveCtrl.SetGroundMoveTypeData(unitID, "maxSpeed", CLOAK_MAX_SPEED)
                maxAngle = CLOAK_MAX_ANGLE
                runSpeed = CLOAK_SPEED
            else
                Spring.MoveCtrl.SetGroundMoveTypeData(unitID, "maxSpeed", maxSpeed)
                maxAngle = NORMAL_MAX_ANGLE
                runSpeed = NORMAL_SPEED
            end
        end
        Sleep(500)
    end
end

function script.StartBuilding()
    if Spring.GetUnitIsDead(unitID) then
        script.StopBuilding()
        return
    end

    SetUnitValue(COB.INBUILDSTANCE, 1)
    Spring.SetUnitAlwaysVisible(unitID, true)
end

function script.StopBuilding()
    SetUnitValue(COB.INBUILDSTANCE, 0)
    Spring.SetUnitAlwaysVisible(unitID, false)
end

CORPSES = {"reb_i_bothan_dead"}
USES_BMOVING = 1
STOP_UNIT = 1


function ANIMATION0()
    Turn(base, x_axis, math.rad(-30), math.rad(90))
    Move(pelvis, y_axis, 2.5, 2.5)

    Turn(torso, x_axis, math.rad(30), math.rad(90))
    Turn(head, x_axis, math.rad(20), math.rad(90))
    Turn(ruparm, x_axis, math.rad(-60), math.rad(100))
    Turn(ruparm, y_axis, math.rad(-20), math.rad(100))
    Turn(ruparm, z_axis, math.rad(20), math.rad(100))
    Turn(rloarm, x_axis, math.rad(-20), math.rad(100))
    Turn(rloarm, z_axis, math.rad(30), math.rad(100))
    Turn(luparm, x_axis, math.rad(-50), math.rad(100))
    Turn(luparm, y_axis, math.rad(20), math.rad(100))
    Turn(lloarm, x_axis, math.rad(-15), math.rad(100))
    Turn(lloarm, y_axis, math.rad(-25), math.rad(100))
    Turn(lleg, x_axis, math.rad(15), math.rad(100))
    Turn(rthigh, x_axis, math.rad(-24), math.rad(100))
    WaitForTurn(torso, x_axis)

    Turn(base, x_axis, math.rad(-60), math.rad(110))
    Turn(ruparm, x_axis, math.rad(-40), math.rad(100))
    Turn(luparm, x_axis, math.rad(-35), math.rad(100))
    Turn(luparm, z_axis, math.rad(-40), math.rad(100))
    Turn(head, x_axis, math.rad(-20), math.rad(90))
    Turn(rloarm, y_axis, math.rad(-80), math.rad(100))
    Turn(rthigh, x_axis, math.rad(-15), math.rad(100))
    Turn(rleg, x_axis, math.rad(30), math.rad(100))
    WaitForTurn(base, x_axis)

    Turn(base, x_axis, math.rad(-90), math.rad(130))
    Move(pelvis, y_axis, 0, 2.5)
    Turn(head, x_axis, math.rad(10), math.rad(60))
    Turn(torso, x_axis, math.rad(5), math.rad(80))
    Turn(ruparm, x_axis, 0, math.rad(80))
    Turn(rloarm, x_axis, math.rad(5), math.rad(80))
    Turn(rloarm, y_axis, math.rad(-60), math.rad(80))
    Turn(rloarm, z_axis, math.rad(-15), math.rad(80))
    Turn(luparm, x_axis, 0, math.rad(80))
    Turn(lloarm, x_axis, math.rad(-25), math.rad(80))
    Turn(lleg, x_axis, 0, math.rad(80))

    WaitForMove(pelvis, y_axis)
    WaitForTurn(base, x_axis)
    WaitForTurn(base, y_axis)
    WaitForTurn(base, z_axis)
    WaitForTurn(pelvis, x_axis)
    WaitForTurn(pelvis, y_axis)
    WaitForTurn(pelvis, z_axis)
    WaitForTurn(lthigh, x_axis)
    WaitForTurn(lthigh, y_axis)
    WaitForTurn(lthigh, z_axis)
    WaitForTurn(lleg, x_axis)
    WaitForTurn(lleg, y_axis)
    WaitForTurn(lleg, z_axis)
    WaitForTurn(rthigh, x_axis)
    WaitForTurn(rthigh, y_axis)
    WaitForTurn(rthigh, z_axis)
    WaitForTurn(rleg, x_axis)
    WaitForTurn(rleg, y_axis)
    WaitForTurn(rleg, z_axis)
    WaitForTurn(torso, x_axis)
    WaitForTurn(torso, y_axis)
    WaitForTurn(torso, z_axis)
    WaitForTurn(chest, x_axis)
    WaitForTurn(chest, y_axis)
    WaitForTurn(chest, z_axis)
    WaitForTurn(head, x_axis)
    WaitForTurn(head, y_axis)
    WaitForTurn(head, z_axis)
    WaitForTurn(shoulders, x_axis)
    WaitForTurn(shoulders, y_axis)
    WaitForTurn(shoulders, z_axis)
    WaitForTurn(luparm, x_axis)
    WaitForTurn(luparm, y_axis)
    WaitForTurn(luparm, z_axis)
    WaitForTurn(lloarm, x_axis)
    WaitForTurn(lloarm, y_axis)
    WaitForTurn(lloarm, z_axis)
    WaitForTurn(ruparm, x_axis)
    WaitForTurn(ruparm, y_axis)
    WaitForTurn(ruparm, z_axis)
    WaitForTurn(rloarm, x_axis)
    WaitForTurn(rloarm, y_axis)
    WaitForTurn(rloarm, z_axis)
    WaitForTurn(gun, x_axis)
    WaitForTurn(gun, y_axis)
    WaitForTurn(gun, z_axis)
    WaitForTurn(flare, x_axis)
    WaitForTurn(flare, y_axis)
    WaitForTurn(flare, z_axis)
end

include "general/randomcorpse.lua"