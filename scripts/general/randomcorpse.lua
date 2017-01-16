--[[ randomcorpse.h - general purpose Killed() library for random corpses
Written by Gnome for use with lua functions by Maelstrom
License: Creative Commons Attribution-Noncommercial 3.0 Unported
     http://creativecommons.org/licenses/by-nc/3.0/

Usage:
Put the following #defines in your script:

//REQUIRED//
#define MIN_CORPSENUM        445
    //the first corpse sequence's definition number
#define MAX_corpseType        448
    //the last corpse sequence's def number. If this is not set, then only MIN_CORPSENUM will ever
    //be used.
#define USES_CORPSE_HEADING    1
    //sets the heading the corpse should be spawned at. For example, a random buildangle performed in
    //Create().
#define USES_BMOVING        1
    //if the unit uses bMoving, it will be set to false in the Killed function if this is set to true
#define STOP_UNIT        1
    //sets MAX_SPEED to 1 (basically immobile). This is to fix occasional corpse alignment glitches
    //caused by brakerate
#define RANDOMHEAD        1
    //several rebel infantry have random faces. This invokes a formula which creates a corpse with the
    //proper face. It requires the static-var "randHead" to be 1, 2, or 3.

#define PRE_ANIMATION    turn torso to y-axis <0> speed <70>;\
            turn head to x-axis <0> speed <70>;
    //Anything else you want done before ANY animation starts playing should be done here

#define ANIMATION0    move pelvis to y-axis [2.5] speed [2.5];\
            turn torso to x-axis <30> speed <90>;
#define ANIMATION1    move pelvis to y-axis [-2.5] speed [2.5];\
            turn torso to x-axis <70> speed <90>;\
            explode head type BITMAPONLY | BITMAP1;
//up to #define ANIMATION31
    //The number of animations you include should match the number of animations implied by
    //the values of MIN_CORPSENUM and MAX_corpseType. So if I have five death animations, each
    //ending in a different corpse, ANIMATION0's final resting position should match the corpse
    //defined as MIN_CORPSENUM's value, and ANIMATION4's final position should match MAX_corpseType's
    //corpse.


#include "general/randomcorpse.h"
    //include the file AFTER your #defines

--]]


function script.Killed(recentDamage, maxHealth)
    Signal(SIG_DYING)
	local severity = recentDamage / maxHealth * 100

    if USES_BMOVING then
        bMoving = false
    end
    if STOP_UNIT then
        Spring.MoveCtrl.SetGroundMoveTypeData(unitID, "maxSpeed", 1)
    end

    local n_corpses = #CORPSES
    if RANDOMHEAD then
        n_corpses = n_corpses / N_RANDOMHEAD
    end
    local corpseType = math.random(1, n_corpses)

    if ANIMATION0~= nil and corpseType == 1 then
        ANIMATION0()
    elseif ANIMATION1~= nil and corpseType == 2 then
        ANIMATION1()
    elseif ANIMATION2~= nil and corpseType == 3 then
        ANIMATION2()
    elseif ANIMATION3~= nil and corpseType == 4 then
        ANIMATION3()
    elseif ANIMATION4~= nil and corpseType == 5 then
        ANIMATION4()
    elseif ANIMATION5~= nil and corpseType == 6 then
        ANIMATION5()
    elseif ANIMATION6~= nil and corpseType == 7 then
        ANIMATION6()
    elseif ANIMATION7~= nil and corpseType == 8 then
        ANIMATION7()
    elseif ANIMATION8~= nil and corpseType == 9 then
        ANIMATION8()
    elseif ANIMATION9~= nil and corpseType == 10 then
        ANIMATION9()
    elseif ANIMATION10~= nil and corpseType == 11 then
        ANIMATION10()
    elseif ANIMATION11~= nil and corpseType == 12 then
        ANIMATION11()
    elseif ANIMATION12~= nil and corpseType == 13 then
        ANIMATION12()
    elseif ANIMATION13~= nil and corpseType == 14 then
        ANIMATION13()
    elseif ANIMATION14~= nil and corpseType == 15 then
        ANIMATION14()
    elseif ANIMATION15~= nil and corpseType == 16 then
        ANIMATION15()
    elseif ANIMATION16~= nil and corpseType == 17 then
        ANIMATION16()
    elseif ANIMATION17~= nil and corpseType == 18 then
        ANIMATION17()
    elseif ANIMATION18~= nil and corpseType == 19 then
        ANIMATION18()
    elseif ANIMATION19~= nil and corpseType == 20 then
        ANIMATION19()
    elseif ANIMATION20~= nil and corpseType == 21 then
        ANIMATION20()
    elseif ANIMATION21~= nil and corpseType == 22 then
        ANIMATION21()
    elseif ANIMATION22~= nil and corpseType == 23 then
        ANIMATION22()
    elseif ANIMATION23~= nil and corpseType == 24 then
        ANIMATION23()
    elseif ANIMATION24~= nil and corpseType == 25 then
        ANIMATION24()
    elseif ANIMATION25~= nil and corpseType == 26 then
        ANIMATION25()
    elseif ANIMATION26~= nil and corpseType == 27 then
        ANIMATION26()
    elseif ANIMATION27~= nil and corpseType == 28 then
        ANIMATION27()
    elseif ANIMATION28~= nil and corpseType == 29 then
        ANIMATION28()
    elseif ANIMATION29~= nil and corpseType == 30 then
        ANIMATION29()
    elseif ANIMATION30~= nil and corpseType == 31 then
        ANIMATION30()
    elseif ANIMATION31~= nil and corpseType == 32 then
        ANIMATION31()
    end

    if RANDOMHEAD and randHead > 1 then
        -- corpseType2 = corpseType - corpseType + 8 + randHead;
        if MAX_CORPSENUM then
            corpseType = corpseType + (MAX_CORPSENUM - 1) * randHead
        else
            corpseType = corpseType + randHead
        end
    end

    local bpx, bpy, bpz = Spring.GetUnitBasePosition(unitID)
    Spring.CreateFeature(CORPSES[corpseType],
                         bpx, bpy, bpz,
                         Spring.GetUnitHeading(unitID),
                         Spring.GetUnitTeam(unitID))

    return 0
end
