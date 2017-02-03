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
USE_STANCE = ROCKET_STANCE1
NORMAL_SPEED = 14
NORMAL_MAX_ANGLE = 150
SLOW_SPEED = 7
SLOW_MAX_ANGLE = 77
MUZZLEFLASH1 = SFX.CEG+0
include "general/infantry.lua"
include "general/rebel_randomhead.lua"

function script.Create()
    Hide(flare)
    bMoving = false
    randomSeed = math.random(10, 60)
    maxSpeed = Spring.GetUnitMoveTypeData(unitID).maxSpeed
    WeaponReady()
end

function script.Killed(recentDamage, maxHealth)
    return 1
end
