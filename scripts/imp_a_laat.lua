include "general/standard_commands.lua"

base = piece("body")
wings = piece("wings")
ldoor = piece("ldoor")
rdoor = piece("rdoor")
lgun = piece("lgun")
lpt = piece("lpt")
rgun = piece("rgun")
rpt = piece("rpt")
lhinge = piece("lhinge")
lball = piece("lball")
lballpt = piece("lballpt")
lflare = piece("l_flare")
rhinge = piece("rhinge")
rball = piece("rball")
rballpt = piece("rballpt")
rflare = piece("r_flare")
cockpit = piece("cockpit")
p1 = piece("link1")
p2 = piece("link2")
p3 = piece("link3")
p4 = piece("link4")
p5 = piece("link5")
p6 = piece("link6")

SMOKEPIECE1 = base
SMOKEPIECE2 = base
SMOKEPIECE3 = base
SMOKEPIECE4 = base
include "general/smokeunit_sws.lua"

PLACES = {p1, p2, p3, p4, p5, p6}
LAND_DELAY = 2000
DROP_DELAY = 0
DROP_OFFSET = {0.0, 0.0}
include "general/air_transport.lua"

function script.Create()
    Hide(lflare)
    Hide(lballpt)
    Hide(rflare)
    Hide(rballpt)
    StartThread(SmokeUnit_SWS)
    Move(base, y_axis, 0)
    StartThread(PickupAndDropFixer)
end

function script.Killed(recentDamage, maxHealth)
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

local current_gun = 0
local SMALL_MUZZLE_FLASH_FX_RED = SFX.CEG + 1
local MED_MUZZLE_FLASH_FX_GREEN = SFX.CEG + 2

function script.AimFromWeapon1()
    return cockpit
end

function script.QueryWeapon1()
    if current_gun == 0 then
        return lpt
    else
        return rpt
    end
end

function script.FireWeapon1()
    if current_gun == 0 then
        EmitSfx(lflare, SMALL_MUZZLE_FLASH_FX_RED)
        current_gun = 1
        return
    else
        EmitSfx(rflare, SMALL_MUZZLE_FLASH_FX_RED)
        current_gun = 0
        return
    end
end

function script.AimWeapon1(heading, pitch)
    Turn(lpt, x_axis, -pitch)
    Turn(lpt, y_axis, heading)
    Turn(rpt, x_axis, -pitch)
    Turn(rpt, y_axis, heading)
    return true
end

local SIG_AIM = 2
local RESTORE_DELAY = Spring.UnitScript.GetLongestReloadTime(unitID)

local function RestoreAfterDelay()
    SetSignalMask(SIG_AIM)
    Sleep(RESTORE_DELAY)
    WeaponReady()
    return 0
end

function script.AimFromWeapon2()
    return lball
end

function script.QueryWeapon2()
    return lballpt
end

function script.FireWeapon2()
    EmitSfx(lballpt, MED_MUZZLE_FLASH_FX_GREEN)
end

function script.AimWeapon2(heading, pitch)
    Signal(SIG_AIM)
    Turn(lball, x_axis, -pitch)
    Turn(lball, y_axis, heading)
    StartThread(RestoreAfterDelay)
    return true
end

function script.AimFromWeapon3()
    return rball
end

function script.QueryWeapon3()
    return rballpt
end

function script.FireWeapon3()
    EmitSfx(rballpt, MED_MUZZLE_FLASH_FX_GREEN)
end

function script.AimWeapon3(heading, pitch)
    Signal(SIG_AIM)
    Turn(rball, x_axis, -pitch)
    Turn(rball, y_axis, heading)
    StartThread(RestoreAfterDelay)
    return true
end