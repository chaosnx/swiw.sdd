include "general/standard_commands.lua"

local SIG_AIM = 2
local SIG_DYING = 4

base = piece("base")
gun = piece("gun")
firept1 = piece("firept1")
firept2 = piece("firept2")
trooper = piece("trooper")
wake1 = piece("wake1")
wake2 = piece("wake2")
wake3 = piece("wake3")
wake4 = piece("wake4")
wake5 = piece("wake5")

bMoving = false
OverWater = 0.0

SMOKEPIECE1 = base
SMOKEPIECE2 = base
SMOKEPIECE3 = base
SMOKEPIECE4 = base
include "general/smokeunit_sws.lua"

UNIT_ROOT = base
UNIT_BELOW_GROUND_DIST = -30
UNIT_RISE_SPEED = 4
DUSTFX = SFX.CEG+2
DUSTFXPT1 = gun
include "general/rebel_unit_build.lua"

SMALL_MUZZLE_FLASH_FX_RED = SFX.CEG+1

function ShowWake()
    while true do
        Sleep(300)
        if OverWater <= 10 then
            EmitSfx(wake1, SFX.WAKE)
            EmitSfx(wake2, SFX.WAKE)
            EmitSfx(wake3, SFX.WAKE)
            EmitSfx(wake4, SFX.WAKE)
            EmitSfx(wake5, SFX.WAKE)
            EmitSfx(wake1, SFX.REVERSE_WAKE)
            EmitSfx(wake2, SFX.REVERSE_WAKE)
            EmitSfx(wake3, SFX.REVERSE_WAKE)
            EmitSfx(wake4, SFX.REVERSE_WAKE)
            EmitSfx(wake5, SFX.REVERSE_WAKE)
        end
    end
end

function script.Create()
    StartThread(SmokeUnit_SWS)
    Sleep(100)
    StartThread(ShowWake)    
    ConstructionAnim()
    Move(base, y_axis, 0)
end

function script.setSFXoccupy(WaterLevel)
    OverWater = WaterLevel
end

local RESTORE_DELAY = Spring.UnitScript.GetLongestReloadTime(unitID) * 2

local function RestoreAfterDelay()
    SetSignalMask(SIG_AIM + SIG_DYING)
    Sleep(RESTORE_DELAY)
    Turn(gun, y_axis, 0)
    Turn(gun, x_axis, 0)
end

function script.AimFromWeapon1()
    return gun
end

function script.QueryWeapon1()
    return firept1
end

function script.FireWeapon1()
    if Spring.GetUnitIsDead(unitID) then
        return
    end

    EmitSfx(firept1, SMALL_MUZZLE_FLASH_FX_RED)
    EmitSfx(firept2, SMALL_MUZZLE_FLASH_FX_RED)
end

function script.AimWeapon1(heading, pitch)
    if Spring.GetUnitIsDead(unitID) then
        return false
    end

    Signal(SIG_AIM)
    SetSignalMask(SIG_AIM + SIG_DYING)

    Turn(gun, y_axis, heading)
    Turn(firept1, x_axis, -pitch)
    Turn(firept2, x_axis, -pitch)
    StartThread(RestoreAfterDelay)
    return true
end


function script.Killed(recentDamage, maxHealth)
    local severity = recentDamage / maxHealth * 100

    if OverWater >= 4 and severity <= 25 then
        return 1
    elseif severity <= 50 then
        Explode(base, SFX.SFX.SHATTER)
        return 2
    end
    Explode(gun, SFX.FALL + SFX.FIRE + SFX.SMOKE)
    Explode(base, SFX.SHATTER)
    return 3
end