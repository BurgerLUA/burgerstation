SUBSYSTEM_DEF(dirty)
	name = "Dirty Subsystem"
	desc = "Filthy."
	priority = SS_ORDER_LAST

var/global/list/possible_dirty_floor = list(
	/obj/effect/cleanable/tile_rot = 100,
	/obj/effect/cleanable/blood/dried_random = 20,
	/obj/effect/cleanable/blood/splatter/grease = 10,
	/obj/effect/cleanable/scorch = 5,
	/obj/effect/cleanable/cobweb = 10,
	/mob/living/simple/passive/mouse/grey = 1
)

var/global/list/possible_dirty_wall = list(
	/obj/effect/cleanable/rust = 100
)

var/global/list/possible_trash = list(
	/obj/item/trash/random = 100
)

/subsystem/dirty/Initialize()

	for(var/k in SSarea.all_areas)
		var/area/A = SSarea.all_areas[k]
		if(A.flags_area & FLAG_AREA_DIRTY)
			for(var/turf/simulated/S in A.contents)
				if(S.has_dense_atom)
					if(S.density && prob(80))
						var/obj/effect/E = pickweight(possible_dirty_wall)
						E = new E(S)
						INITIALIZE(E)
						GENERATE(E)
						FINALIZE(E)
					CHECK_TICK_HARD
					continue
				if(S.has_opaque_atom)
					continue
				if(prob(80))
					var/obj/effect/E = pickweight(possible_dirty_floor)
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
				CHECK_TICK_HARD

	return TRUE