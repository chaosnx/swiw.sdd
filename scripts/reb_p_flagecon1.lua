include "general/standard_commands.lua"

base = piece("base")
sphere = piece("sphere")
pipe = piece("pipe")
upgreebles1 = piece("upgreebles1")
upgreebles2 = piece("upgreebles2")
greebles = piece("greebles")
crates = piece("crates")
c1 = piece("c1")
c2 = piece("c2")
c3 = piece("c3")
smoke1 = piece("smoke1")

SMOKEPIECE1 = base
SMOKEPIECE2 = sphere
SMOKEPIECE3 = upgreebles1
SMOKEPIECE4 = upgreebles2

include "general/smokeunit_sws.lua"

local smoke = SFX.CEG+0
local SIG_ACTIVATED = 4

function script.Create()
    Turn(base, y-axis, math.random(math.rad(-20), math.rad(20)))
    Turn(crates, y-axis, math.random(math.rad(-160), math.rad(160)))
    Turn(c1, y-axis, math.random(math.rad(-40), math.rad(160)))
    Turn(c2, y-axis, math.random(0.0, math.rad(70)))
    Turn(c3, y-axis, math.random(math.rad(-50), 0.0))
    StartThread(StartSmoke)
    StartThread(SmokeUnit_SWS)
end


local function StartSmoke()
    SetSignalMask(SIG_ACTIVATED)

    while true do
        EmitSfx(smoke1, smoke)
        Sleep(100)
    end
end

local function StopSmoke()
    Signal(SIG_ACTIVATED)
end

function script.Activate()
    StartThread(StartSmoke)
    return 0
end

function script.Deactivate()
    StartThread(StopSmoke)
    return 0
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
    else
        return 3        
    end
end