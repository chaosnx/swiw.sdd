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
gun = piece("gun")
flare = piece("flare")
head = piece("head")
head2 = piece("head2")
head3 = piece("head3")
helmet = piece("helmet")
lekku = piece("lekku")

bMoving = false
runSpeed = 0
maxAngle = 0
randomSeed = math.random(10, 60)
alreadyEngaged = false
inBunker = 0
randHead = 1
idleAnim = false
maxSpeed = 0
cantCloak = false

REBEL = 1
USE_STANCE = RIFLE_STANCE2
NORMAL_SPEED = 14
NORMAL_MAX_ANGLE = 150
SLOW_SPEED = 7
SLOW_MAX_ANGLE = 75
CLOAK_MAX_SPEED = 13.8
CLOAK_SPEED = 9
CLOAK_MAX_ANGLE = 100
MUZZLEFLASH1 = SFX.CEG+0
BURST1 = 3
BURST_RATE1 = 10
include "general/infantry.lua"
function HEADEXTRAS1()
    Hide(lekku)
end
function HEADEXTRAS2()
    Show(lekku)
end
include "general/rebel_randomhead.lua"

function script.Create()
    Hide(flare)
    bMoving = false
    randomSeed = math.random(10, 60)
    maxSpeed = Spring.GetUnitMoveTypeData(unitID).maxSpeed
    ChooseRandomHead()
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

function CloakControl()
    local recloak = Spring.GetUnitIsCloaked(unitID)
    while(cantCloak) do
        Spring.SetUnitCloak(unitID, false, 1000000000)
        Sleep(30)
    end
    if(recloak) then
        ud = UnitDefs[unitDefID]
        Spring.SetUnitCloak(unitID,
                            true,
                            tonumber(ud.customParams.decloakdistance))
    end
end

function StartPlantBomb()
    if Spring.GetUnitIsDead(unitID) then
        StopPlantBomb()
        return
    end

    cantCloak = true
    StartThread(CloakControl)
end

function StopPlantBomb()
    cantCloak = false
end

CORPSES = {"reb_i_veterantrooper_dead_seq1_head1",
           "reb_i_veterantrooper_dead_seq1_head2",
           "reb_i_veterantrooper_dead_seq1_head3",
           "reb_i_veterantrooper_dead_seq2_head1",
           "reb_i_veterantrooper_dead_seq2_head2",
           "reb_i_veterantrooper_dead_seq2_head3",
           "reb_i_veterantrooper_dead_seq3_head1",
           "reb_i_veterantrooper_dead_seq3_head2",
           "reb_i_veterantrooper_dead_seq3_head3",
           "reb_i_veterantrooper_dead_seq4_head1",
           "reb_i_veterantrooper_dead_seq4_head2",
           "reb_i_veterantrooper_dead_seq4_head3"}
USES_BMOVING = 1
STOP_UNIT = 1


function POST_ANIMATION()
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

    POST_ANIMATION()
end

function ANIMATION1()
    Turn(base, x_axis, math.rad(45), math.rad(90))
    Turn(torso, x_axis, math.rad(-15), math.rad(70))
    Turn(head, x_axis, math.rad(-20), math.rad(70))
    Turn(luparm, x_axis, math.rad(-60), math.rad(60))
    Turn(luparm, y_axis, 0, math.rad(60))
    Turn(luparm, z_axis, math.rad(-20), math.rad(60))
    Turn(lloarm, x_axis, math.rad(-30), math.rad(60))
    Turn(lloarm, y_axis, 0, math.rad(60))
    Turn(lloarm, z_axis, math.rad(50), math.rad(60))
    Turn(ruparm, x_axis, math.rad(-45), math.rad(60))
    Turn(ruparm, y_axis, 0, math.rad(60))
    Turn(ruparm, z_axis, 0, math.rad(60))
    Turn(rloarm, x_axis, 0, math.rad(60))
    Turn(rloarm, y_axis, 0, math.rad(60))
    Turn(rloarm, z_axis, math.rad(-30), math.rad(60))
    Turn(lthigh, x_axis, math.rad(15), math.rad(70))
    Turn(lleg, x_axis, math.rad(10), math.rad(70))
    Turn(rthigh, x_axis, math.rad(-15), math.rad(70))
    Turn(rleg, x_axis, math.rad(30), math.rad(70))
    WaitForTurn(base, x_axis)

    Turn(base, x_axis, math.rad(80), math.rad(110))
    Turn(pelvis, x_axis, math.rad(-15), math.rad(70))
    Turn(torso, x_axis, math.rad(25), math.rad(70))
    Turn(luparm, x_axis, math.rad(-150), math.rad(190))
    Turn(ruparm, x_axis, math.rad(-60), math.rad(70))
    Turn(rloarm, x_axis, math.rad(10), math.rad(70))
    Turn(rloarm, z_axis, math.rad(-140), math.rad(70))
    Turn(lthigh, x_axis, math.rad(20), math.rad(70))
    Turn(rthigh, x_axis, math.rad(20), math.rad(70))
    WaitForTurn(base, x_axis)

    Turn(head, x_axis, math.rad(20), math.rad(110))
    Turn(rleg, x_axis, 0, math.rad(90))
    WaitForTurn(head, x_axis)

    POST_ANIMATION()
end

function ANIMATION2()
    Move(pelvis, y_axis, -7, 15)
    Turn(torso, x_axis, math.rad(14), math.rad(140))
    Turn(head, x_axis, math.rad(17), math.rad(140))
    Turn(rthigh, x_axis, math.rad(-50), math.rad(200))
    Turn(rthigh, y_axis, 0, math.rad(200))
    Turn(rthigh, z_axis, math.rad(20), math.rad(200))
    Turn(rleg, x_axis, math.rad(140), math.rad(360))
    Turn(lthigh, x_axis, math.rad(-50), math.rad(200))
    Turn(lthigh, y_axis, 0, math.rad(200))
    Turn(lthigh, z_axis, math.rad(-20), math.rad(200))
    Turn(lleg, x_axis, math.rad(140), math.rad(360))
    Turn(ruparm, x_axis, math.rad(-40), math.rad(140))
    Turn(ruparm, z_axis, math.rad(4), math.rad(140))
    Turn(rloarm, x_axis, 0, math.rad(140))
    Turn(rloarm, z_axis, math.rad(23), math.rad(140))
    Turn(luparm, x_axis, math.rad(-44), math.rad(260))
    Turn(luparm, z_axis, math.rad(-3), math.rad(260))
    Turn(lloarm, x_axis, math.rad(12), math.rad(260))
    Turn(lloarm, z_axis, math.rad(100), math.rad(260))
    WaitForTurn(lloarm, z_axis)
    WaitForMove(pelvis, y_axis)

    Move(pelvis, y_axis, -7.75, 25)
    Turn(base, z_axis, math.rad(-60), math.rad(100))
    Turn(torso, z_axis, math.rad(-10), math.rad(100))
    Turn(head, z_axis, math.rad(-30), math.rad(120))
    Turn(lthigh, x_axis, math.rad(-20), math.rad(140))
    Turn(lthigh, z_axis, math.rad(-10), math.rad(140))
    Turn(lleg, x_axis, math.rad(50), math.rad(140))
    Turn(rthigh, z_axis, math.rad(-20), math.rad(200))
    Turn(rleg, x_axis, math.rad(89), math.rad(140))
    Turn(rleg, z_axis, math.rad(-15), math.rad(140))
    Turn(luparm, z_axis, math.rad(20), math.rad(100))
    Turn(lloarm, z_axis, math.rad(60), math.rad(120))
    Turn(ruparm, x_axis, math.rad(-60), math.rad(120))
    Turn(ruparm, z_axis, math.rad(-20), math.rad(140))
    Turn(rloarm, x_axis, math.rad(-20), math.rad(120))
    Turn(rloarm, z_axis, math.rad(10), math.rad(120))
    WaitForTurn(rthigh, z_axis)
    WaitForTurn(base, z_axis)

    POST_ANIMATION()
end

function ANIMATION3()
    Turn(base, x_axis, math.rad(-45), math.rad(90))
    Move(pelvis, y_axis, -1.75, 15)
    Turn(torso, x_axis, math.rad(-10), math.rad(90))
    Turn(torso, y_axis, math.rad(20), math.rad(90))
    Turn(head, x_axis, math.rad(15), math.rad(90))
    Turn(head, y_axis, math.rad(5), math.rad(90))
    Turn(luparm, x_axis, math.rad(-15), math.rad(120))
    Turn(luparm, z_axis, math.rad(-20), math.rad(120))
    Turn(lloarm, x_axis, math.rad(-42), math.rad(120))
    Turn(lloarm, z_axis, math.rad(10), math.rad(120))
    Turn(ruparm, x_axis, math.rad(-40), math.rad(120))
    Turn(ruparm, z_axis, 0, math.rad(120))
    Turn(rloarm, x_axis, math.rad(-20), math.rad(120))
    Turn(rloarm, z_axis, math.rad(-20), math.rad(120))
    Turn(lthigh, x_axis, 0, math.rad(130))
    Turn(rthigh, x_axis, math.rad(-15), math.rad(130))
    WaitForTurn(base, x_axis)

    Turn(base, x_axis, math.rad(-82), math.rad(110))
    WaitForTurn(base, x_axis)

    Turn(head, x_axis, math.rad(-15), math.rad(150))
    Turn(torso, y_axis, math.rad(10), math.rad(120))
    Turn(lthigh, x_axis, 0, math.rad(130))
    Turn(rleg, x_axis, math.rad(30), math.rad(130))
    Turn(luparm, x_axis, math.rad(10), math.rad(130))
    Turn(lloarm, x_axis, math.rad(0), math.rad(120))
    Turn(ruparm, x_axis, math.rad(-20), math.rad(120))
    Turn(rloarm, z_axis, math.rad(-50), math.rad(120))
    Turn(rloarm, x_axis, math.rad(-60), math.rad(120))
    Turn(gun, y_axis, math.rad(40), math.rad(120))
    Turn(gun, z_axis, math.rad(-20), math.rad(120))
    WaitForTurn(gun, y_axis)
    WaitForTurn(rloarm, z_axis)

    POST_ANIMATION()
end

include "general/randomcorpse.lua"  
