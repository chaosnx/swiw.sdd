--[[ rebel_unit_build.h - Build animation handler for Rebel units
Written by Gnome, based partially on code by smoth
License: Creative Commons Attribution-Noncommercial 3.0 Unported
	 http://creativecommons.org/licenses/by-nc/3.0/

Usage:
Put the following #defines in your script:

//REQUIRED//
#define UNIT_ROOT base
	//the primary parent piece of the building itself
#define UNIT_BELOW_GROUND_DIST [-15]
	//how far underground the building should start out. used in rising calculation
#define UNIT_RISE_SPEED [0.7]
	//the speed to rise the building during the calculation. this is necessary because
	//too high a speed looks jerky, and too slow a speed means the building is only partially
	// risen upon completion, depending on its buildtime. The general value here is [0.5]-[3]

//OPTIONAL//
#define DUSTFX 1024+7 
	//the fbi-set sfx type to use for the dust clouds. Optional.
#define DUST_ROOT dustrotator
	//this will spin the designated piece around randomly so the dust doesn't always emit from the same
	//place. Make the DUSTFXPT pieces a child of this if you use it. Optional.
#define DUSTFXPT1 dust1
	//up to four dust emitter points can be defined. All are optional
#define DUSTFXPT2 dust2
#define DUSTFXPT3 dust3
#define DUSTFXPT4 dust4
#define EXTRA spin fans around y-axis speed <10>*rand(1,10);
	//any extra commands to run after the build process finishes so you don't need a second loop
	//to delay them. Spinning fans, radars, whatever. Optional.

#include "general/rebel_unit_build.h"
	//include the file AFTER your #defines

Create() {
	[your script stuff]
	start-script ConstructionAnim(); //make sure you add this line to Create() so the animation runs
}

--]]


function ConstructionAnim()
	local hp = 1
	Move(UNIT_ROOT, y_axis, UNIT_BELOW_GROUND_DIST)
	while hp > 0 do
        local health, maxHealth, paralyzeDamage, captureProgress, buildProgress = Spring.GetUnitHealth(unitID)
		hp = 1 - buildProgress
		Move(UNIT_ROOT, y_axis, UNIT_BELOW_GROUND_DIST * hp, UNIT_RISE_SPEED)
		if DUSTFX ~= nil then
			if DUST_ROOT ~= nil then
				local randspin = math.random(0, 32767)
				Turn(DUST_ROOT, y_axis, randspin)
			end
			if DUSTFXPT1 ~= nil then
				EmitSfx(DUSTFXPT1, DUSTFX)
			end
			if DUSTFXPT2 ~= nil then
				EmitSfx(DUSTFXPT2, DUSTFX)
			end
			if DUSTFXPT3 ~= nil then
				EmitSfx(DUSTFXPT3, DUSTFX)
			end
			if DUSTFXPT4 ~= nil then
				EmitSfx(DUSTFXPT4, DUSTFX)
			end
		end
		Sleep(math.random(500, 1100))
	end
	if EXTRA ~= nil then
    	EXTRA()
	end
end