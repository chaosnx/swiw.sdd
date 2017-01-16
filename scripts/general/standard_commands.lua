-- Vector-based special effects
SFXTYPE_WAKE1  =  3
-- Point-based (piece origin) special effects
SHATTER = 1  -- Has odd effects in S3O.
EXPLODE_ON_HIT = 2  -- DOES NOT WORK PROPERLY IN SPRING
FALL = 4  -- The piece will fall due to gravity, based partially on myGravity value
SMOKE = 8  -- A smoke trail will follow the piece through the air
FIRE = 16  -- A fire trail will follow the piece through the air
BITMAPONLY = 32  -- DOES NOT WORK PROPERLY IN SPRING

-- Bitmap Explosion Types
BITMAP = 10000001

-- Indices for set/get value
ACTIVATION = 1  -- set or get, used by all scripts that call Activate() through UI or BOS command
STANDINGMOVEORDERS = 2  -- set or get, now works in 0.75b to set all states (Hold Position, Manuever, Roam).  Values 0, 1, 2
STANDINGFIREORDERS = 3  -- set or get, now works in 0.75b to set all states (Hold Fire, Fire at Will, Fire Back).  Values 0, 1, 2
HEALTH = 4  -- set or get, in 0.74b or above
INBUILDSTANCE = 5  -- set or get, used to tell Spring that a Factory is now able to build objects and emit nano-particles
BUSY = 6  -- set or get, will operate in Spring to pause loading state for flying transports only
PIECE_XZ = 7  -- get, for position calculation, returns two values
PIECE_Y = 8  -- get, for position calculation, returns one value
UNIT_XZ = 9  -- get, for position calculation of Unit, reads from centroid of Base
UNIT_Y = 10  -- get, for position calculation of Unit, reads from centroid of Base 
UNIT_HEIGHT = 11  -- get, for position calculation of Unit, reads from .S3O height value
XZ_ATAN = 12  -- get atan of packed x,z coords
XZ_HYPOT = 13  -- get hypot of packed x,z coords
ATAN = 14  -- get ordinary two-parameter atan, as integer
HYPOT = 15  -- get ordinary two-parameter hypot, as integer
GROUND_HEIGHT = 16  -- get, asks Spring for value of GROUND_HEIGHT based on map values
BUILD_PERCENT_LEFT = 17  -- get 0  =  unit is built and ready, 1-100  =  How much is left to build
YARD_OPEN = 18  -- set or get (change which plots we occupy when building opens and closes)
BUGGER_OFF = 19  -- set or get (ask other units to clear the area)  -- This works in Spring, causes Units to try to move a minimum distance away, when invoked!
ARMORED = 20  -- set or get.  Turns on the Armored state.  Uses value of Armor, defined in unit FBI, which is a float, in Spring, as a multiple of health.
IN_WATER = 28  -- get only.  If unit position Y less than 0, then the unit must be in water (0 Y is the water level).
CURRENT_SPEED   = 29  -- set can allow code to halt units, or speed them up to their maximum velocity.
VETERAN_LEVEL   = 32  -- set or get.  Can make units super-accurate, or keep them inaccurate.
MAX_ID = 70  -- get only.  Returns maximum number of units - 1
MY_ID = 71  -- get only.  Returns ID of current unit
UNIT_TEAM = 72  -- get only.  Returns team of unit given with parameter
UNIT_BUILD_PERCENT_LEFT = 73  -- get only.  BUILD_PERCENT_LEFT, but comes with a unit parameter.
UNIT_ALLIED = 74  -- get only.  Is this unit allied to the unit of the current COB script? 1 = allied, 0 = not allied
MAX_SPEED = 75  -- set only.  Alters MaxVelocity for the given unit.
CLOAKED = 76  -- set or get.  Gets current status of cloak.
WANT_CLOAK = 77  -- set or get.  Gets current value of WANT_CLOAK (1 or 0)
GROUND_WATER_HEIGHT = 78  -- get only.  Returns negative values if unit is over water.
UPRIGHT = 79  -- set or get.  Can allow you to set the upRight state of a Unit.
POW = 80  -- get the power of a number
PRINT = 81  -- get only. Prints the value of up to 4 vars / static-vars into the Spring chat
HEADING = 82  -- set and get.  Allows unit HEADING to be returned, SET to keep units from turning.
TARGET_ID = 83  -- get.  Returns ID of currently targeted Unit.  -1 if none, -2 if force-fire, -3 if Intercept, -4 if the Weapon doesn't exist.
LAST_ATTACKER_ID = 84  -- get.  Returns ID of last Unit to attack, or -1 if never attacked.
LOS_RADIUS = 85  -- set.  Sets the LOS Radius (per Ground).
AIR_LOS_RADIUS = 86  -- set.  Sets the LOS Radius (per Air).
RADAR_RADIUS = 87   -- set or get, just like the Unit def.
JAMMER_RADIUS           = 88   -- set or get, just like the Unit def.
SONAR_RADIUS = 89   -- set or get, just like the Unit def.
SONAR_JAM_RADIUS        = 90   -- set or get, just like the Unit def.
SEISMIC_RADIUS = 91   -- set or get, just like the Unit def.
DO_SEISMIC_PING = 92  -- get (get DO_SEISMIC_PING(size)) Emits a Seismic Ping.
CURRENT_FUEL = 93   -- set or get
TRANSPORT_ID = 94  -- get.  Returns ID of the Transport the Unit is in.  -1 if not loaded.
SHIELD_POWER = 95  -- set or get
STEALTH = 96  -- set or get
CRASHING = 97  -- set or get, returns whether aircraft isCrashing state
CHANGE_TARGET = 98  -- set, the value it's set to determines the affected weapon
CEG_DAMAGE = 99  -- set
COB_ID = 100  -- get
PLAY_SOUND = 101  -- get, http:--spring.clan-sy.com/mantis/view.php?id = 690
KILL_UNIT = 102  -- get KILL_UNIT(targetunitid) - kills unit calling it if no unitid specified
ALPHA_THRESHOLD = 103  -- set or get
SET_WEAPON_UNIT_TARGET = 106  -- get (fake set)
SET_WEAPON_GROUND_TARGET = 107  -- get (fake set)
SONAR_STEALTH = 108  -- set or get

LUA0 = 110
LUA1 = 111
LUA2 = 112
LUA3 = 113
LUA4 = 114
LUA5 = 115
LUA6 = 116
LUA7 = 117
LUA8 = 118
LUA9 = 119

FLANK_B_MODE = 120  -- set or get
FLANK_B_DIR = 121  -- set or get, set is through get for multiple args
FLANK_B_MOBILITY_ADD = 122  -- set or get
FLANK_B_MAX_DAMAGE = 123  -- set or get
FLANK_B_MIN_DAMAGE = 124  -- set or get

WEAPON_RELOADSTATE = 125  -- get (frame number of the next shot/burst)
WEAPON_RELOADTIME = 126  -- get (in frames)
WEAPON_ACCURACY = 127  -- get
WEAPON_SPRAY = 128  -- get
WEAPON_RANGE = 129  -- get
WEAPON_PROJECTILESPEED = 130  -- get

MIN = 131  -- get
MAX = 132  -- get
ABS = 133  -- get
GAME_FRAME = 134  -- get

UNIT_VAR_START = 1024
TEAM_VAR_START = 2048
ALLY_VAR_START = 3072
GLOBAL_VAR_START = 4096


--Special Commands, custom hacks
SPEED_CONSTANT = 512
RADIAN_CONSTANT = 256

SIG_AIM1 = 2
SIG_AIM2 = 4
SIG_AIM3 = 8
SIG_AIM4 = 16
SIG_AIM5 = 32
SIG_AIM6 = 64
SIG_AIM7 = 128
SIG_AIM8 = 256
SIG_AIM9 = 512
SIG_AIM10 = 1024
SIG_AIM11 = 2048
SIG_AIM12 = 4096
SIG_AIM13 = 8192
SIG_AIM14 = 16384
SIG_AIM15 = 32768
SIG_AIM16 = 65536