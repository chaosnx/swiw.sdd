local unitName = "imp_b_barracks"

local unitDef =
{
-- Internal settings	
	Category = [[GROUND FACTORY BUILDING]],
	ObjectName = "empire/b-barracks.s3o",	
	TEDClass = "PLANT",
	script = "imp_b_barracks.lua",
	buildPic = "imp_b_barracks.png",
	
    corpse="imp_b_barracks_dead",
    icontype="factory_light",
	soundcategory="KBOTPLANT",
	
	side="Empire",
	
-- Explode
	
    selfdestructcountdown	= 1,
    explodeas				= "LARGE_BUILDING",
    selfdestructas			= "LARGE_BUILDING",
	
-- Unit limitations and properties
	Description 	= "Infantry Center",
	MaxDamage 		= 3000,
	Name 			= "Barracks",
	RadarDistance 	= 600,
	SightDistance 	= 300,	
	Upright 		= true,	
	LevelGround 	= false, -- dont use true because unit has not indicator it's leveling ground.
	IdleAutoHeal	= 0,
	Reclaimable 	= false,
	--cost
	BuildCostMetal 	= 750,
	BuildCostEnergy = 1250,
	BuildTime 		= 38,
	--economy	
	EnergyStorage 	= 0,
	EnergyUse 		= 0,
	MetalStorage 	= 0,
	EnergyMake 		= 0, 
	MakesMetal 		= 0, 
	MetalMake 		= 0,	
	
-- Pathfinding and related
	FootprintX 					= 10,
	FootprintZ 					= 10,
	MaxSlope 					= 20,
	MaxWaterDepth				= 5,
	UseBuildingGroundDecal 		= 1,
	BuildingGroundDecalSizeX	= 13,
	BuildingGroundDecalSizeY	= 13,
	BuildingGroundDecalType 	= "decals/generic-imp.dds",
    -- cobid 						= 10,
    collisionVolumeType 		= "box",
    collisionVolumeScales 		= [[152 40 140]],
    collisionVolumeOffsets 		= [[0 20 0]],
	YardMap 					= [[oooooooocc
									oooooooooc
									oooocccooo
									oooocccooo
									ooccccccoo
									ooccccccoo
									ooccccccoo
									ooccccccoo
									oocccccooc
									cccccccccc]],
	customParams = {
	},
			   
-- Building	
	Builder = true,
    Reclaimable = false,
	ShowNanoSpray = false,
	ShowNanoFrame = false,
	CanBeAssisted = false,	
	WorkerTime = 1,
	BuildOptions = {
		"imp_c_condroid",
		"imp_is_scout",
		"imp_is_assault",
		"imp_is_heavy",
		"imp_is_defense",
		"imp_is_antiair",
		"imp_w_atrt",
		"imp_v_groundtransport",
	},
	SFXtypes = {
		ExplosionGenerator0 = "custom:SMOKEPUFF_SWS_FX",
	}
}

return lowerkeys({ [unitName] = unitDef })