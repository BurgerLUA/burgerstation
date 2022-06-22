SUBSYSTEM_DEF(dirty)
	name = "Dirty Subsystem"
	desc = "Filthy."
	priority = SS_ORDER_LAST

/subsystem/dirty/Initialize()

	for(var/k in SSarea.all_areas)
		var/area/A = SSarea.all_areas[k]
		if(A.flags_area & FLAG_AREA_DIRTY)
			for(var/turf/simulated/S in A.contents)
				if(S.has_dense_atom)
					continue
				if(S.has_opaque_atom)
					continue
				if(prob(80))
					var/obj/effect/E
					if(S.density)
						E = pickweight(possible_dirty_wall)
					else
						E = pickweight(possible_dirty_floor)
					E = new E(S)
					INITIALIZE(E)
					GENERATE(E)
					FINALIZE(E)
				if(!S.density && prob(30))
					var/obj/item/I = pickweight(possible_trash)
					I = new I(S)
					INITIALIZE(I)
					GENERATE(I)
					FINALIZE(I)

	return TRUE