-- Ensure the poses are already defined
if PISTOL_STANCE1 == nil then
    include "general/standard_commands.lua"
end

if USE_STANCE == PISTOL_STANCE1 then
    include "general/pistol_poses.lua"
elseif USE_STANCE == ROCKET_STANCE1 then
elseif USE_STANCE == RIFLE_STANCE1 then
elseif USE_STANCE == RIFLE_STANCE2 then
    include "general/rifle2_poses.lua"
elseif USE_STANCE == WOOKIEE_STANCE then
    include "general/wookiee_poses.lua"
elseif USE_STANCE == SBD_STANCE then
end
