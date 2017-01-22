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

local places = {p1, p2, p3, p4, p5, p6, p7, p8, p9, p10}
local men = 1
local passengers = {nil, nil, nil, nil, nil, nil, nil, nil, nil, nil}
local DROP_OFFSET = 80.0

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

function script.Create()
    Turn(door, x_axis, math.rad(-102))
    StartThread(SmokeUnit_SWS)
    ConstructionAnim()
    Move(base, y_axis, 0)
    StartThread(DropFixer)
end

function script.QueryTransport(passengerID)
    return places[men]
end

function script.BeginTransport(passengerID)
    passengers[men] = passengerID
    men = men + 1
    Turn(door, x_axis, 0, math.rad(120))
    Sleep(1000)
    Turn(door, x_axis, math.rad(-102), math.rad(120))
end

function script.TransportDrop(passengerID, x, y, z)
    local bpx, bpy, bpz = Spring.GetUnitBasePosition(unitID)
    men = men - 1
    Turn(door, x_axis, 0, math.rad(120))
    Spring.UnitScript.DropUnit(passengerID)
    Spring.SetUnitPosition(passengerID, x, y, z)
    passengers[men] = nil
    Sleep(5000)
    Turn(door, x_axis, math.rad(-102), math.rad(120))
end

local function getCommandId() 
    local cmd=Spring.GetCommandQueue(unitID, 1)
    if cmd and cmd[1] then        
        return cmd[1]['id']        
    end
    return nil
end

local function getDropPoint() 
    local cmd=Spring.GetCommandQueue(unitID, 1)
    local dropx, dropy, dropz = nil    
    
    if cmd and cmd[1] then                    
        if cmd[1]['id'] == CMD.UNLOAD_UNIT or cmd[1]['id'] == CMD.UNLOAD_UNITS then
            dropx, dropy, dropz = cmd[1]['params'][1], cmd[1]['params'][2], cmd[1]['params'][3]                
        end
    end
    return {dropx, dropy, dropz}
end

local function isNearDropPoint(transportUnitId, requiredDist)
    if transportUnitId == nil then
        return false
    end

    local px, py, pz = Spring.GetUnitBasePosition(transportUnitId)
    local dropPoint = getDropPoint()
    local px2, py2, pz2 = dropPoint[1], dropPoint[2], dropPoint[3]
    if px2 == nil then
        return false
    end
    
    local dx = px - px2
    local dz = pz - pz2 
    local dist = (dx^2 + dz^2)
    
    if dist < requiredDist^2 then
        return true
    else
        return false
    end    
end

local moveRate
function script.MoveRate(curRate)
    moveRate = curRate
    -- See https://github.com/ZeroK-RTS/Zero-K/blob/master/scripts/corvalk.lua
end

local function getMaximumRadius()
    if men <= 1 then
        return 0
    end
    local r = 0
    for i = 1, men - 1 do
        r_pax = Spring.GetUnitRadius(passengers[i])
        if r_pax > r then
            r = r_pax
        end
    end
    return r
end

function DropFixer()
    while true do
        if men > 1 and (getCommandId() == CMD.UNLOAD_UNIT or getCommandId() == CMD.UNLOAD_UNITS) and isNearDropPoint(unitID, 100) then
            -- There is someone loaded, the user called to unload him, and we are close enough
            if moveRate == 0 then
                -- We are not moving
                dropPoint = getDropPoint()
                local dx, dy, dz = Spring.GetUnitDirection(unitID)
                local px = dropPoint[1] + dx * DROP_OFFSET
                local pz = dropPoint[3] + dz * DROP_OFFSET
                local py = Spring.GetGroundHeight(px, pz)
                if py >= 0 then
                    dr = getMaximumRadius()
                    r0 = - 0.5 * dr * (men - 2)
                    dx = -dz
                    dz = dx
                    px = px + dx * r0
                    pz = pz + dz * r0
                    for i = men - 1, 1, -1 do
                        py = Spring.GetGroundHeight(px, pz)
                        script.TransportDrop(passengers[i], px,
                                                            py,
                                                            pz)
                        px = px + dx * dr
                        pz = pz + dz * dr
                    end

                end
            end
        end

        Sleep(500)        
    end
end

function script.Killed(recentDamage, maxHealth)
    local severity = recentDamage / maxHealth * 100

    Explode(base, SFX.NONE)
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