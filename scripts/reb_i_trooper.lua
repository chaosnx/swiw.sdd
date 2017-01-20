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
USE_STANCE = PISTOL_STANCE1
NORMAL_SPEED = 11.7
NORMAL_MAX_ANGLE = 130
SLOW_SPEED = 5.8
SLOW_MAX_ANGLE = 65
QUERY_PIECENUM1 = "flare"
MUZZLEFLASH1 = 1024+0
include "general/infantry.lua"
include "general/rebel_randomhead.lua"

function script.Create()
    Hide(Spring.GetUnitScriptPiece(unitID, 1))
    bDying = false
    bMoving = false
    randomSeed = math.random(10, 60)
    maxSpeed = Spring.GetUnitMoveTypeData(unitID).maxSpeed
    ChooseRandomHead()
    WeaponReady()
end

CORPSES = {"reb_i_trooper_dead_seq1_head1",
           "reb_i_trooper_dead_seq1_head2",
           "reb_i_trooper_dead_seq1_head3"}
USES_BMOVING = 1
STOP_UNIT = 1


function ANIMATION0()
    Move(pelvis, y_axis, -2.5, 2.5)
    Turn(base, x_axis, 0.0, math.rad(90))
    Turn(base, z_axis, 0.0, math.rad(90))
    Turn(pelvis, x_axis, 0.0, math.rad(90))
    Turn(pelvis, y_axis, 0.0, math.rad(90))
    Turn(pelvis, z_axis, 0.0, math.rad(90))
    Turn(lthigh, x_axis, -0.4363322854042053, math.rad(90))
    Turn(lthigh, y_axis, -9.384010677856416e-17, math.rad(90))
    Turn(lthigh, z_axis, 2.0803860412227113e-17, math.rad(90))
    Turn(lleg, x_axis, 0.8726646900177002, math.rad(90))
    Turn(lleg, y_axis, 1.7009604780014547e-16, math.rad(90))
    Turn(lleg, z_axis, 7.931709162317874e-17, math.rad(90))
    Turn(rthigh, x_axis, -0.4363322854042053, math.rad(90))
    Turn(rthigh, y_axis, -9.384010677856416e-17, math.rad(90))
    Turn(rthigh, z_axis, 2.0803860412227113e-17, math.rad(90))
    Turn(rleg, x_axis, 0.8726646900177002, math.rad(90))
    Turn(rleg, y_axis, 1.7009604780014547e-16, math.rad(90))
    Turn(rleg, z_axis, 7.931709162317874e-17, math.rad(90))
    Turn(torso, x_axis, 0.2617993950843811, math.rad(90))
    Turn(torso, y_axis, 5.746937229130156e-17, math.rad(90))
    Turn(torso, z_axis, 7.56598945245103e-18, math.rad(90))
    Turn(chest, x_axis, 0.0, math.rad(90))
    Turn(chest, y_axis, 0.0, math.rad(90))
    Turn(chest, z_axis, 0.0, math.rad(90))
    Turn(head, x_axis, 0.3490658104419708, math.rad(90))
    Turn(head, y_axis, 7.594374320606909e-17, math.rad(90))
    Turn(head, z_axis, 1.3390929151600446e-17, math.rad(90))
    Turn(head2, x_axis, 0.0, math.rad(90))
    Turn(head2, y_axis, 0.0, math.rad(90))
    Turn(head2, z_axis, 0.0, math.rad(90))
    Turn(head3, x_axis, 0.0, math.rad(90))
    Turn(head3, y_axis, 0.0, math.rad(90))
    Turn(head3, z_axis, 0.0, math.rad(90))
    Turn(helmet, x_axis, 0.0, math.rad(90))
    Turn(helmet, y_axis, 0.0, math.rad(90))
    Turn(helmet, z_axis, 0.0, math.rad(90))
    Turn(shoulders, x_axis, 0.0, math.rad(90))
    Turn(shoulders, y_axis, 0.0, math.rad(90))
    Turn(shoulders, z_axis, 0.0, math.rad(90))
    Turn(luparm, x_axis, -0.4363322854042053, math.rad(90))
    Turn(luparm, y_axis, -9.384011339600906e-17, math.rad(90))
    Turn(luparm, z_axis, 2.0803847177337312e-17, math.rad(90))
    Turn(lloarm, x_axis, -0.43061891198158264, math.rad(90))
    Turn(lloarm, y_axis, -1.3405135869979858, math.rad(90))
    Turn(lloarm, z_axis, -0.41300398111343384, math.rad(90))
    Turn(ruparm, x_axis, -0.4363322854042053, math.rad(90))
    Turn(ruparm, y_axis, -9.384011339600906e-17, math.rad(90))
    Turn(ruparm, z_axis, 2.0803847177337312e-17, math.rad(90))
    Turn(rloarm, x_axis, -0.4130041301250458, math.rad(90))
    Turn(rloarm, y_axis, 1.3405134677886963, math.rad(90))
    Turn(rloarm, z_axis, 0.43061864376068115, math.rad(90))
    Turn(gun, x_axis, 0.0, math.rad(90))
    Turn(gun, y_axis, 0.0, math.rad(90))
    Turn(gun, z_axis, 0.0, math.rad(90))
    Turn(flare, x_axis, 0.0, math.rad(90))
    Turn(flare, y_axis, 0.0, math.rad(90))
    Turn(flare, z_axis, 0.0, math.rad(90))

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
    WaitForTurn(head2, x_axis)
    WaitForTurn(head2, y_axis)
    WaitForTurn(head2, z_axis)
    WaitForTurn(head3, x_axis)
    WaitForTurn(head3, y_axis)
    WaitForTurn(head3, z_axis)
    WaitForTurn(helmet, x_axis)
    WaitForTurn(helmet, y_axis)
    WaitForTurn(helmet, z_axis)
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

    Sleep(100)

    Turn(base, x_axis, -1.570796251296997, math.rad(180))
    Turn(pelvis, x_axis, 0.0, math.rad(90))
    Turn(pelvis, y_axis, 0.0, math.rad(90))
    Turn(pelvis, z_axis, 0.0, math.rad(90))
    Turn(lthigh, x_axis, 0.0, math.rad(90))
    Turn(lthigh, y_axis, 0.0, math.rad(90))
    Turn(lthigh, z_axis, 0.0, math.rad(90))
    Turn(lleg, x_axis, 0.0, math.rad(90))
    Turn(lleg, y_axis, 0.0, math.rad(90))
    Turn(lleg, z_axis, 0.0, math.rad(90))
    Turn(rthigh, x_axis, -0.2617993950843811, math.rad(90))
    Turn(rthigh, y_axis, -5.746937229130156e-17, math.rad(90))
    Turn(rthigh, z_axis, 7.56598945245103e-18, math.rad(90))
    Turn(rleg, x_axis, 0.5235987901687622, math.rad(90))
    Turn(rleg, y_axis, 1.1102232893229526e-16, math.rad(90))
    Turn(rleg, z_axis, 2.9748366207832464e-17, math.rad(90))
    Turn(torso, x_axis, 0.09960320591926575, math.rad(90))
    Turn(torso, y_axis, 2.207980305070241e-17, math.rad(90))
    Turn(torso, z_axis, 1.1005207916099506e-18, math.rad(90))
    Turn(chest, x_axis, 0.0, math.rad(90))
    Turn(chest, y_axis, 0.0, math.rad(90))
    Turn(chest, z_axis, 0.0, math.rad(90))
    Turn(head, x_axis, 0.0, math.rad(90))
    Turn(head, y_axis, 0.0, math.rad(90))
    Turn(head, z_axis, 0.0, math.rad(90))
    Turn(head2, x_axis, 0.0, math.rad(90))
    Turn(head2, y_axis, 0.0, math.rad(90))
    Turn(head2, z_axis, 0.0, math.rad(90))
    Turn(head3, x_axis, 0.0, math.rad(90))
    Turn(head3, y_axis, 0.0, math.rad(90))
    Turn(head3, z_axis, 0.0, math.rad(90))
    Turn(helmet, x_axis, 0.0, math.rad(90))
    Turn(helmet, y_axis, 0.0, math.rad(90))
    Turn(helmet, z_axis, 0.0, math.rad(90))
    Turn(shoulders, x_axis, 0.0, math.rad(90))
    Turn(shoulders, y_axis, 0.0, math.rad(90))
    Turn(shoulders, z_axis, 0.0, math.rad(90))
    Turn(luparm, x_axis, 0.2237483412027359, math.rad(90))
    Turn(luparm, y_axis, 0.27020737528800964, math.rad(90))
    Turn(luparm, z_axis, 0.7059427499771118, math.rad(90))
    Turn(lloarm, x_axis, -0.23246333003044128, math.rad(90))
    Turn(lloarm, y_axis, -0.37266701459884644, math.rad(90))
    Turn(lloarm, z_axis, -0.09887774288654327, math.rad(90))
    Turn(ruparm, x_axis, 0.14972546696662903, math.rad(90))
    Turn(ruparm, y_axis, -0.4113990068435669, math.rad(90))
    Turn(ruparm, z_axis, -0.3607311248779297, math.rad(90))
    Turn(rloarm, x_axis, -0.15393519401550293, math.rad(90))
    Turn(rloarm, y_axis, -0.9599310159683228, math.rad(90))
    Turn(rloarm, z_axis, 0.329434871673584, math.rad(90))
    Turn(gun, x_axis, 0.0, math.rad(90))
    Turn(gun, y_axis, 0.0, math.rad(90))
    Turn(gun, z_axis, 0.0, math.rad(90))
    Turn(flare, x_axis, 0.0, math.rad(90))
    Turn(flare, y_axis, 0.0, math.rad(90))
    Turn(flare, z_axis, 0.0, math.rad(90))

    WaitForTurn(base, x_axis)
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
    WaitForTurn(head2, x_axis)
    WaitForTurn(head2, y_axis)
    WaitForTurn(head2, z_axis)
    WaitForTurn(head3, x_axis)
    WaitForTurn(head3, y_axis)
    WaitForTurn(head3, z_axis)
    WaitForTurn(helmet, x_axis)
    WaitForTurn(helmet, y_axis)
    WaitForTurn(helmet, z_axis)
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


    Sleep(100)
end

include "general/randomcorpse.lua"