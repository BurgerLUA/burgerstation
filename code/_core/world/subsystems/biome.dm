SUBSYSTEM_DEF(biome)
	name = "Biome Subsystem"
	desc = "Handle biome generation for the surface level"
	priority = SS_ORDER_FIRST
	var/biome/chosen_biome


/subsystem/biome/Initialize()

	var/biome/B = pick(subtypesof(/biome/))
	chosen_biome = new B

	return TRUE