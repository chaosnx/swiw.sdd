--[[ Helper to create unit air transports. To use this, you should define the
following global variables:
   * PLACES : The pieces where the passengers will be attached
   * NEAR_DIST : The distance to consider we are close to the unit to become
   loaded/unloaded. 100 by default
   * DROP_OFFSET : The unloading point respect the center of the transport (just
   x and zcoordinates are required). {0, 0} by default
   * DROP_DELAY : Delay between units drop. 1500 by default
Optionally, you can define the following functions to control the behavior:
   * BEGIN_TRANSPORT(paxID) : Called when an unit is loaded. Useful to make
   animations
   * TRANSPORT_DROP(paxID, x, y, z) : Called when an unit should be dettached.
   Useful to make animations
After that, you can include this file, and start the thread PickupAndDropFixer.
This class offers the global variable units_loaded to allow the user make fine
control.
This module takes the control of:
   * script.QueryTransport
   * script.BeginTransport
   * script.TransportDrop
   * script.MoveRate
--]]

units_loaded = {}
if NEAR_DIST == nil then
    NEAR_DIST = 100
end
if DROP_OFFSET == nil then
    DROP_OFFSET = {0, 0}
end
if DROP_DELAY == nil then
    DROP_DELAY = 1500
end


function script.QueryTransport(passengerID)
    return PLACES[#units_loaded]
end

function script.BeginTransport(passengerID)
    units_loaded[#units_loaded + 1] = passengerID
    if BEGIN_TRANSPORT ~= nil then
        BEGIN_TRANSPORT(passengerID)
    end
end

function script.TransportDrop(passengerID, x, y, z)
    for i,unit in pairs(units_loaded) do
        if passengerID == unit then
            table.remove(units_loaded, i)
            break
        end
    end
    Spring.UnitScript.DropUnit(passengerID)
    Spring.SetUnitPosition(passengerID, x, y, z)
    if TRANSPORT_DROP ~= nil then
        TRANSPORT_DROP(passengerID, x, y, z)
    end
end

local function getPassengerId() 
    -- See https://github.com/ZeroK-RTS/Zero-K/blob/master/scripts/corvalk.lua
    local cmd = Spring.GetCommandQueue(unitID, 1)
    local unitId = nil
    
    if cmd and cmd[1] then
        if cmd[1]['id'] == CMD.LOAD_UNITS then
            unitId = cmd[1]['params'][1]
        end
    end

    return unitId
end

local function isValidCargo(passenger)
    -- See https://github.com/ZeroK-RTS/Zero-K/blob/master/scripts/corvalk.lua
    return passenger and Spring.ValidUnitID(passenger)
end

local function getCommandId() 
    -- See https://github.com/ZeroK-RTS/Zero-K/blob/master/scripts/corvalk.lua
    local cmd=Spring.GetCommandQueue(unitID, 1)
    if cmd and cmd[1] then        
        return cmd[1]['id']        
    end
    return nil
end

local function getDropPoint() 
    -- See https://github.com/ZeroK-RTS/Zero-K/blob/master/scripts/corvalk.lua
    local cmd=Spring.GetCommandQueue(unitID, 1)
    local dropx, dropy, dropz = nil    
    
    if cmd and cmd[1] then                    
        if cmd[1]['id'] == CMD.UNLOAD_UNIT or cmd[1]['id'] == CMD.UNLOAD_UNITS then
            dropx, dropy, dropz = cmd[1]['params'][1], cmd[1]['params'][2], cmd[1]['params'][3]                
        end
    end
    return {dropx, dropy, dropz}
end

local function isNearPickupPoint(passengerId, requiredDist)
    -- See https://github.com/ZeroK-RTS/Zero-K/blob/master/scripts/corvalk.lua
    local px, py, pz = Spring.GetUnitBasePosition(passengerId)
    if not px then
        return false
    end
    
    local px2, py2, pz2 = Spring.GetUnitBasePosition(unitID)
    if not px2 then
        return false
    end
    
    local dx = px2 - px
    local dz = pz2 - pz
    local dist = (dx^2 + dz^2)
    
    if dist < requiredDist^2 then    
        return true
    else
        return false
    end    
end

local function isNearDropPoint(transportUnitId, requiredDist)
    -- See https://github.com/ZeroK-RTS/Zero-K/blob/master/scripts/corvalk.lua
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
    -- See https://github.com/ZeroK-RTS/Zero-K/blob/master/scripts/corvalk.lua
    moveRate = curRate
end

local H, R = Spring.GetUnitHeight(unitID), Spring.GetUnitRadius(unitID)
local SX, SY, SZ, OX, OY, OZ = Spring.GetUnitCollisionVolumeData(unitID)
local springSphereMod = false
local function editSpringSphereToLand()
    -- Shrink the spring sphere to let the unit get close enough to the floor to
    -- pickup/drop units
    local px, py, pz = Spring.GetUnitBasePosition(unitID)
    local miny = Spring.GetGroundHeight(px, pz) + 0.5 * SY
    r = py - miny
    if r > R then
        r = R
    elseif r < 0.5 * SY then
        r = 0.5 * SY
    end

    Spring.SetUnitRadiusAndHeight(unitID, r, H)
    springSphereMod = true
end

local function restoreSpringSphere()
    if not springSphereMod then
        return
    end
    Spring.SetUnitRadiusAndHeight(unitID, R, H)
    springSphereMod = false
end

local function isLoading()
    local passengerId = getPassengerId()
    if passengerId and (getCommandId() == CMD.LOAD_UNITS) and isValidCargo(passengerId) and isNearPickupPoint(passengerId, NEAR_DIST) then
        return true
    end
    return false
end

local function isUnloading()
    if #units_loaded > 0 and (getCommandId() == CMD.UNLOAD_UNIT or getCommandId() == CMD.UNLOAD_UNITS) and isNearDropPoint(unitID, NEAR_DIST) and moveRate == 0 then
        return true
    end
    return false
end

local function getMaximumRadius()
    if #units_loaded <= 0 then
        return 0
    end
    local r = 0
    for i,pax in pairs(units_loaded) do
        r_pax = Spring.GetUnitRadius(pax)
        if r_pax > r then
            r = r_pax
        end
    end
    return r
end

function PickupAndDropFixer()
    -- See https://github.com/ZeroK-RTS/Zero-K/blob/master/scripts/corvalk.lua
    while true do
        if isLoading() then
            -- We are not moving (but we should wait to land)
            while isLoading() do
                editSpringSphereToLand()
                Sleep(100)
            end
        else
            restoreSpringSphere()
        end

        if isUnloading() then
            -- We are not moving (but we should wait to land)
            Sleep(7000)
            
            -- Get the drop point
            dropPoint = getDropPoint()
            local dx, dy, dz = Spring.GetUnitDirection(unitID)
            local px = dropPoint[1] + dx * DROP_OFFSET[2] - dz * DROP_OFFSET[1]
            local pz = dropPoint[3] + dz * DROP_OFFSET[2] + dx * DROP_OFFSET[1]
            local dr = getMaximumRadius()
            -- Edit the first drop point depending on the number of loaded units
            dx = -dz
            dz = dx
            px = px - dx * 0.5 * dr * (#units_loaded - 1)
            pz = pz - dz * 0.5 * dr * (#units_loaded - 1)
            while isUnloading() do
                -- Compute the drop point in the row
                local x = px + dx * dr * (#units_loaded - 1)
                local z = pz + dz * dr * (#units_loaded - 1)
                local y = Spring.GetGroundHeight(x, z)
                if y >= 0 then
                    script.TransportDrop(units_loaded[#units_loaded], x,
                                                                      y,
                                                                      z)
                end
                Sleep(DROP_DELAY)
            end
        end

        Sleep(500)        
    end
end
