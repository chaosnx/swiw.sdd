--[[ infantry.h - Infantry script handler for SWS
Written by Gnome including work from scripts by Argh and animations by Nemo
License: Creative Commons Attribution-Noncommercial 3.0 Unported
     http://creativecommons.org/licenses/by-nc/3.0/
--]]

--[[
#define USE_PISTOL_STANCE1
#define USE_ROCKET_STANCE1
#define USE_RIFLE_STANCE1
#define NORMAL_SPEED
#define NORMAL_MAX_ANGLE
#define SLOW_SPEED
#define SLOW_MAX_ANGLE
#define CLOAK_MAX_SPEED
#define CLOAK_SPEED
#define CLOAK_MAX_ANGLE
#define QUERY_PIECENUM1
#define BURST1
#define BURST_RATE1
#define MUZZLEFLASH1

static-var bMoving, runSpeed, maxAngle, alreadyEngaged, inBunker, idleAnim, maxSpeed;
--]]

local SIG_AIM = 2
local SIG_DYING = 4
local SIG_IDLE_RUN = 8

include "general/poses.lua"

function WeaponReady()
    alreadyEngaged = false
    STEADY_POSE()

    local cloaked = Spring.GetUnitIsCloaked(unitID)
    if(Spring.GetUnitIsCloaked(unitID)) then
        Spring.MoveCtrl.SetGroundMoveTypeData(unitID, "maxSpeed", CLOAK_MAX_SPEED)
        maxAngle = CLOAK_MAX_ANGLE
        runSpeed = CLOAK_SPEED
    else
        Spring.MoveCtrl.SetGroundMoveTypeData(unitID, "maxSpeed", maxSpeed)
        maxAngle = NORMAL_MAX_ANGLE
        runSpeed = NORMAL_SPEED
    end
    return 0
end

local function Run()
    Signal(SIG_IDLE_RUN)
    SetSignalMask(SIG_IDLE_RUN + SIG_DYING)

    if CLOAK_MAX_SPEED ~= nil and not alreadyEngaged then
        local cloaked = Spring.GetUnitIsCloaked(unitID)
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

    local y = y_axis
    if Z_UP then
        y = z_axis
    end

    Turn(pelvis, x_axis, math.rad(8 * maxAngle) / 100, math.rad(80 * runSpeed))
    Turn(torso, x_axis, math.rad(4 * maxAngle) / 100, math.rad(80 * runSpeed))
    while true do
        if bMoving then
            -- Turn(pelvis, x_axis, math.rad(8 * maxAngle) / 100, math.rad(80 * runSpeed))
            -- Turn(torso, x_axis, math.rad(4 * maxAngle) / 100, math.rad(80 * runSpeed))
            Turn(torso, y, math.rad(-20 * maxAngle) / 100, math.rad(10 * runSpeed))
            Move(pelvis, y, 0, math.rad(200) * runSpeed)
            -- WaitForTurn(pelvis, x_axis)
            -- WaitForTurn(torso, x_axis)
            -- WaitForTurn(torso, y_axis)
            -- WaitForMove(pelvis, y_axis)
        end
        if bMoving then
            Turn(rleg, x_axis, math.rad(85 * maxAngle) / 100, math.rad(30 * runSpeed))
            Turn(lleg, x_axis, math.rad(25 * maxAngle) / 100, math.rad(40 * runSpeed))
            Turn(rthigh, x_axis, math.rad(-45 * maxAngle) / 100, math.rad(20 * runSpeed))
            Turn(rthigh, y_axis, 0, math.rad(20 * runSpeed))
            Turn(rthigh, z_axis, 0, math.rad(20 * runSpeed))
            Turn(lthigh, x_axis, math.rad(20 * maxAngle) / 100, math.rad(20 * runSpeed))
            Turn(lthigh, y_axis, 0, math.rad(20 * runSpeed))
            Turn(lthigh, z_axis, 0, math.rad(20 * runSpeed))
            Move(pelvis, y_axis, 1.75, math.rad(160) * runSpeed)
            WaitForTurn(rleg, x_axis)
            WaitForTurn(lleg, x_axis)
            WaitForTurn(rthigh, x_axis)
            WaitForTurn(rthigh, y_axis)
            WaitForTurn(rthigh, z_axis)
            WaitForTurn(lthigh, x_axis)
            WaitForTurn(lthigh, y_axis)
            WaitForTurn(lthigh, z_axis)
            -- WaitForMove(pelvis, y_axis)
        end

        if bMoving then
            Turn(rleg, x_axis, math.rad(55 * maxAngle) / 100, math.rad(60 * runSpeed))
            Turn(torso, y, math.rad(20 * maxAngle) / 100, math.rad(10 * runSpeed))
            Move(pelvis, y, 0, math.rad(300) * runSpeed)
            Turn(lleg, x_axis, math.rad(85 * maxAngle) / 100, math.rad(30 * runSpeed))
            Turn(rleg, x_axis, math.rad(25 * maxAngle) / 100, math.rad(40 * runSpeed))
            Turn(lthigh, x_axis, math.rad(-45 * maxAngle) / 100, math.rad(20 * runSpeed))
            WaitForTurn(rleg, x_axis)
            -- WaitForTurn(torso, y_axis)
            -- WaitForMove(pelvis, y_axis)
            WaitForTurn(lleg, x_axis)
            WaitForTurn(rleg, x_axis)
            WaitForTurn(lthigh, x_axis)
        end
        if bMoving then
            Turn(rthigh, x_axis, math.rad(20 * maxAngle) / 100, math.rad(30 * runSpeed))
            Move(pelvis, y, 1.75, math.rad(160) * runSpeed)
            Turn(lleg, x_axis, math.rad(55 * maxAngle) / 100, math.rad(60 * runSpeed))
            WaitForTurn(rthigh, x_axis)
            -- WaitForMove(pelvis, y_axis)
            WaitForTurn(lleg, x_axis)
        end
        Sleep(randomSeed)
    end
end

local function IdleAnim01()
    local y = y_axis
    if Z_UP then
        y = z_axis
    end
    local randvar = math.random(8, 20)
    Turn(torso, y, math.rad(1 * randvar), math.rad(50))
    Turn(head, y, math.rad(1 * randvar), math.rad(90))
    WaitForTurn(torso, y)
    WaitForTurn(head, y)
    Sleep(12 * randvar)
    Turn(torso, y, math.rad(1 * randvar), math.rad(50))
    Turn(head, y, math.rad(1 * randvar), math.rad(90))
    WaitForTurn(torso, y_axis)
    WaitForTurn(head, y_axis)
    Sleep(12 * randvar)
end

local function IdleAnim02()
    local y = y_axis
    if Z_UP then
        y = z_axis
    end
    local randvar = math.random(8, 20)
    Turn(torso, y, math.rad(-1 * randvar), math.rad(50))
    Turn(head, y, math.rad(-1 * randvar), math.rad(90))
    WaitForTurn(torso, y)
    WaitForTurn(head, y)
    Sleep(12 * randvar)
    Turn(torso, y, math.rad(-1 * randvar), math.rad(50))
    Turn(head, y, math.rad(-1 * randvar), math.rad(90))
    WaitForTurn(torso, y)
    WaitForTurn(head, y)
    Sleep(12 * randvar)
end

local function Stop()
    Signal(SIG_IDLE_RUN)
    SetSignalMask(SIG_IDLE_RUN + SIG_DYING + SIG_AIM)

    WeaponReady()
    while true do
        idleAnim = true
        local randIdleAnimation = math.random(1, 2)
        if randIdleAnimation == 1 then
            IdleAnim01()
        elseif randIdleAnimation == 2 then
            IdleAnim02()
        end
        idleAnim = false
    end
end

function script.StartMoving()
    if Spring.GetUnitIsDead(unitID) then
        return
    end
    if DECLOAK_WHILE_MOVING then
        -- To decloak the unit, just simply increase the cloaking radius to a
        -- very big value
        Spring.SetUnitCloak(unitID, Spring.GetUnitIsCloaked(unitID), 1000000000)
    end
    bMoving = true
    StartThread(Run)
end

function script.StopMoving()
    if Spring.GetUnitIsDead(unitID) then
        return
    end
    if DECLOAK_WHILE_MOVING then
        ud = UnitDefs[unitDefID]
        Spring.SetUnitCloak(unitID,
                            Spring.GetUnitIsCloaked(unitID),
                            tonumber(ud.customParams.decloakdistance))
    end
    bMoving = false
    StartThread(Stop)
    local x, y, z = Spring.GetUnitBasePosition(unitID)
end

function script.HitByWeaponId(z, x, id, damage)
    if Spring.GetUnitIsDead(unitID) then
        return 0
    end
    if inBunker then
        return 0
    end
    return damage
end

function script.setSFXoccupy(level)
    if Spring.GetUnitIsDead(unitID) then
        return
    end

    if level == 0 then
        local tid = Spring.GetUnitTransporter(unitID)
        local transport = UnitDefs[Spring.GetUnitDefID(tid)].name
        -- local transport = Spring.GetCOBGlobalVar(tid)
        if transport == "reb_p_flagecon1" or transport == "imp_p_flagmil1" or transport == "imp_p_flagecon1" then -- imp bunker
            inBunker = 1
        elseif transport == "imp_d_pillbox" then -- imp pillbox
            inBunker = 1
        elseif transport == "imp_a_laat" then -- imp LAAT
            Signal(SIG_DYING)
            inBunker = 2
            units_in_transport = Spring.GetUnitIsTransporting(tid)
            local laatseat = 0
            for i=1,#units_in_transport do
                if units_in_transport[i] == unitID then
                    laatseat = i
                    break
                end
            end
            if laatseat < 4 then
                Turn(base, y_axis, math.rad(-90))
            else
                Turn(base, y_axis, math.rad(90))
            end
            Move(base, y_axis, -10.5)
            Turn(lthigh, x_axis, math.rad(-90))
            Turn(rthigh, x_axis, math.rad(-90))
            Turn(lleg, x_axis, math.rad(90))
            Turn(rleg, x_axis, math.rad(90))
            WaitForMove(base, y_axis)
            WaitForTurn(lthigh, x_axis)
            WaitForTurn(rthigh, x_axis)
            WaitForTurn(lleg, x_axis)
            WaitForTurn(rleg, x_axis)
        elseif transport == "reb_v_groundtransport" then -- rebel APC
            inBunker = 3
            Hide(pelvis)
            Hide(lthigh)
            Hide(lleg)
            Hide(rthigh)
            Hide(rleg)
            Hide(chest)
            Hide(head)
            Hide(ruparm)
            Hide(rloarm)
            Hide(gun)
            Hide(flare)
            Hide(luparm)
            Hide(lloarm)
            if RANDOMHEAD then
                Hide(helmet)
                if randHead == 2 then
                    Hide(head2)
                elseif randHead == 3 then
                    Hide(head3)
                end
                if HEADEXTRAS1 ~= nil then
                    HEADEXTRAS1()
                end
            end
        end
    else
        if inBunker == 2 or inBunker == 3 then
            Show(pelvis)
            Show(lthigh)
            Show(lleg)
            Show(rthigh)
            Show(rleg)
            Show(chest)
            Show(head)
            Show(ruparm)
            Show(rloarm)
            Show(gun)
            Show(flare)
            Show(luparm)
            Show(lloarm)
            if RANDOMHEAD then
                Show(helmet)
                if randHead == 2 then
                    Show(head2)
                    Hide(head)
                elseif randHead == 3 then
                    Show(head3)
                    Hide(head)
                    if HEADEXTRAS2 ~= nil then
                        HEADEXTRAS2()
                    end
                end
            end

            Turn(base, y_axis, 0)
            Move(base, y_axis, 0)
            Turn(lthigh, x_axis, 0)
            Turn(rthigh, x_axis, 0)
            Turn(lleg, x_axis, 0)
            Turn(rleg, x_axis, 0)
            WaitForTurn(base, y_axis)
            WaitForMove(base, y_axis)
            WaitForTurn(lthigh, x_axis)
            WaitForTurn(rthigh, x_axis)
            WaitForTurn(lleg, x_axis)
            WaitForTurn(rleg, x_axis)

            StartThread(WeaponReady)
        end
        inBunker = 0
    end
end

local RESTORE_DELAY = Spring.UnitScript.GetLongestReloadTime(unitID) * 2

local function RestoreAfterDelay()
    SetSignalMask(SIG_AIM + SIG_DYING)
    Sleep(RESTORE_DELAY)
    WeaponReady()
    return 0
end

function script.AimFromWeapon1()
    return head
end

function script.QueryWeapon1()
    return flare
end

function script.FireWeapon1()
    if Spring.GetUnitIsDead(unitID) then
        return
    end

    if BURST_RATE1 then
        local counter = 1
        while counter <= BURST1 do
            EmitSfx(flare, MUZZLEFLASH1)
            counter = counter + 1
            Sleep(BURST_RATE1)
        end
    else
        EmitSfx(flare, MUZZLEFLASH1)
    end
end

function script.AimWeapon1(heading, pitch)
    if Spring.GetUnitIsDead(unitID) then
        return false
    end

    Signal(SIG_AIM)
    SetSignalMask(SIG_AIM + SIG_DYING)

    if inBunker == 1 then
        -- He is in building process, skip aiming
        return false
    end

    runSpeed = SLOW_SPEED;
    Spring.MoveCtrl.SetGroundMoveTypeData(unitID, "maxSpeed", maxSpeed / 2)
    maxAngle = SLOW_MAX_ANGLE;

    if bMoving then
        alreadyEngaged = AIMING_RUN_POSE(heading, pitch)
    else
        alreadyEngaged = AIMING_STEADY_POSE(heading, pitch)        
    end

    StartThread(RestoreAfterDelay)
    return alreadyEngaged
end

function CanCapture(useless_data)
    if Spring.GetUnitIsDead(unitID) then
        return false
    end

    return not alreadyEngaged
end
