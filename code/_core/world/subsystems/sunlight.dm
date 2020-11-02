SUBSYSTEM_DEF(sunlight)
	name = "Sunlight Subsystem"
	desc = "Manages sunlights."
	priority = SS_ORDER_SUNLIGHT

/subsystem/sunlight/Initialize()

	for(var/k in SSarea.all_areas)
		var/area/A = SSarea.all_areas[k]
		if(A.sunlight_freq > 0 && A.sunlight_color)
			for(var/turf/T in A.contents)
				A.setup_sunlight(T)

	return ..()