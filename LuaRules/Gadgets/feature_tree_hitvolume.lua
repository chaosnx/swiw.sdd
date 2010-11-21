function gadget:GetInfo()
  return {
    name      = "Tree Hit Volume Change",
    desc      = "Sets hardcoded trees to a different hitvolume. SWIW version.",
    author    = "Evil4Zerggin",
    date      = "6 January 2008",
    license   = "GNU LGPL, v2.1 or later",
    layer     = 0,
    enabled   = true  --  loaded by default?
  }
end

if (not gadgetHandler:IsSyncedCode()) then
  return false
end

--horizontal radius of trees
local horizScale = 1

local GetFeatureDefID = Spring.GetFeatureDefID
local SetFeatureCollisionVolumeData = Spring.SetFeatureCollisionVolumeData
local strFind = string.find

function gadget:Initialize()
	for _, featureID in ipairs(Spring.GetAllFeatures()) do
		local featureDef = FeatureDefs[GetFeatureDefID(featureID)]
		local name = featureDef.name
		local height = featureDef.radius
		local metal = featureDef.metal
		if (name and strFind(name, "treetype"))
				or metal == 0 then
			SetFeatureCollisionVolumeData(featureID, 
					horizScale, height, horizScale, --scales
					0, 0, 0, --offset
					1, -- cylinder
					1, -- ray-trace
					1 -- y-axis
					)
			--debug
			--Spring.Echo("tree changed")
		end
	end
end

function gadget:FeatureCreated(featureID)
	local featureDef = FeatureDefs[GetFeatureDefID(featureID)]
	local tooltip = featureDef.tooltip
	local height = featureDef.radius
	local metal = featureDef.metal
	if not (
			strFind(tooltip, "Dead") 
			or strFind(tooltip, "Wreck")
			or metal > 0
			) then
		SetFeatureCollisionVolumeData(featureID, 
				horizScale, height, horizScale, --scales
				0, 0, 0, --offset
				1, -- cylinder
				1, -- ray-trace
				1 -- y-axis
				)
		--debug
		--Spring.Echo("tree changed")
	end
end
