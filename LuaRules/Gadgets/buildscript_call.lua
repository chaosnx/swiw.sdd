--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--
--  file: buildscript_call.lua
--  brief: Calls the COB function BuildStarted(unitID) to alert builders which unit they are building
--  author: Maelstrom
--
--  Copyright (C) 2007.
--  Licensed under the terms of the Creative Commons Attribution-Noncommercial 3.0 Unported
--
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

function gadget:GetInfo()
    return {
        name      = "BuildScript Call",
        desc      = "Calls BuildStarted for builders",
        author    = "Maelstrom",
        date      = "30th September 2007",
        license   = "CC by-nc, version 3.0",
        layer     = -5,
        enabled   = true  --  loaded by default?
    }
end

if (gadgetHandler:IsSyncedCode()) then

    function gadget:UnitCreated(unitID, unitDefID, unitTeam, builderID)
        if (builderID ~= nil) then
            local env = Spring.UnitScript.GetScriptEnv(builderID)
            if env == nil then
                Spring.CallCOBScript(builderID, "BuildStarted", 0, unitID)
            elseif env.BuildStarted ~= nil then
                Spring.UnitScript.CallAsUnit(builderID, env.BuildStarted, 0, unitID)
            end
        end
    end

    function gadget:UnitFromFactory(unitID, unitDefID, unitTeam, factID, factDefID, userOrders)
        local env = Spring.UnitScript.GetScriptEnv(factID)
        if env == nil then
            Spring.CallCOBScript(factID, "BuildEnded", 0, unitID)
        elseif env.BuildEnded ~= nil then
            Spring.UnitScript.CallAsUnit(factID, env.BuildEnded, 0, unitID)
        end
    end

end
