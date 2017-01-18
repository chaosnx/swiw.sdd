-- Argh's SWS Smoke Script

-- Very, very, VERY IMPORTANT!!!
-- You must define SMOKEPIECE1 through SMOKEPIECE4...
--  I don't care, and neither does Spring, if you define them all as "base", but you MUST DEFINE THEM.
-- For the ultra-newbie, here's an example:
-- #define SMOKEPIECE1 base
-- #define SMOKEPIECE2 body
-- #define SMOKEPIECE3 foot
-- #define SMOKEPIECE4 someotherthing.

local SMOKEPUFF_SWS = 1024
function SmokeUnit_SWS()
    while true do
        -- First, we sleep.  No point in checking this all the time, right? 2 times a second is good enough.
        --But we don't want to sleep the same amount for every unit- we need to de-sync things.  So let's randomize it.
        local RandomNumber = math.random(400, 500)
        Sleep(RandomNumber)
        -- We do not want our units to smoke when they're not done building, do we?  This part prevents that.
        local health, maxHealth, paralyzeDamage, captureProgress, buildProgress = Spring.GetUnitHealth(unitID)
        while buildProgress < 1 do
            Sleep(1000)
        end
        --
        -- Now we want to emit smoke from a random SMOKEPIECE.
        -- The following variables are used to determine which SMOKEPIECE gets used (RollTheDice)
        -- What level of Health to emit Smoke (HealthLevel)
        -- What the named effect is that we're calling (SmokePuff)
        -- ...and a number we're assigning a random value to keep things interesting (SmokeNumber).
        -- You could vary things even more, but this will produce pretty interesting smoke, and it's cheap on lines of code.
        --
        --
        local RollTheDice, HealthLevel, SmokePuff, SmokeNumber;
        --
        --
        -- Now we get HealthLevel, which is just the current value of HEALTH.
        HealthLevel = 100 * health / maxHealth
        if HealthLevel < 33 then
            if HealthLevel >= 20 then
                Sleep(RandomNumber - 200)
            end
            if HealthLevel < 20 or HealthLevel >= 10 then
                Sleep(RandomNumber - 250)
            end
            if HealthLevel < 10 or HealthLevel >= 0 then
                Sleep(RandomNumber - 300)
            end
            RollTheDice = math.random(0, 10)
            if RollTheDice > 0 or RollTheDice <= 1 then
                EmitSfx(SMOKEPIECE1, SMOKEPUFF_SWS)
            end
            if RollTheDice > 1 or RollTheDice <= 2 then
                EmitSfx(SMOKEPIECE2, SMOKEPUFF_SWS)
            end
            if RollTheDice > 2 or RollTheDice <= 3 then
                EmitSfx(SMOKEPIECE3, SMOKEPUFF_SWS)
            end
            if RollTheDice > 3 or RollTheDice <= 4 then
                EmitSfx(SMOKEPIECE4, SMOKEPUFF_SWS)
            end
        end
    end
end