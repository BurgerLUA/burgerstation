

proc/should_static_view()
	return (VIEW_RANGE >= world.maxx/2 || VIEW_RANGE >= world.maxy/2)

proc/get_offset_x(var/atom/atom_a,var/atom/atom_b)
	return (atom_a.x*TILE_SIZE) - (atom_b.x*TILE_SIZE)

proc/get_offset_y(var/atom/atom_a,var/atom/atom_b)
	return (atom_a.y*TILE_SIZE) - (atom_b.y*TILE_SIZE)

proc/get_true_offset_x(var/atom/atom_a,var/atom/atom_b)
	return (atom_a.x*TILE_SIZE + atom_a.pixel_x - initial(atom_a.pixel_x)) - (atom_b.x*TILE_SIZE + atom_b.pixel_x - initial(atom_b.pixel_x))

proc/get_true_offset_y(var/atom/atom_a,var/atom/atom_b)
	return (atom_a.y*TILE_SIZE + atom_a.pixel_y - initial(atom_a.pixel_y)) - (atom_b.y*TILE_SIZE + atom_b.pixel_y - initial(atom_b.pixel_y))

#define is_valid(A) (A && !A.qdeleting)

#define INITIALIZE(D)																								\
	if(D.initialized) {																								\
		CRASH_SAFE("ERROR: [D.get_debug_name()] was initialized more than once!");									\
	}																												\
	else {																											\
		if(!D.Initialize()) {CRASH_SAFE("ERROR: [D.get_debug_name()] did not run Initialize() properly!")};			\
		if(!D.PostInitialize()) {CRASH_SAFE("ERROR: [D.get_debug_name()] did not run PostInitialize() properly!")};	\
		D.initialized = TRUE;																						\
	}

#define GENERATE(D)																									\
	if(D.generated)	{																								\
		CRASH_SAFE("ERROR: [D.get_debug_name()] was generated more than once!");									\
	}																												\
	else {																											\
		if(!D.Generate()) {CRASH_SAFE("ERROR: [D.get_debug_name()] did not run Generate() properly!")};				\
		D.generated = TRUE;																							\
	}

#define FINALIZE(D)																									\
	if(D.finalized) {																								\
		CRASH_SAFE("ERROR: [D.get_debug_name()] was finalized more than once!");									\
	}																												\
	else {																											\
		if(!D.Finalize()) {CRASH_SAFE("ERROR: [D.get_debug_name()] did not run Finalize() properly!")};				\
		D.finalized = TRUE;																							\
	}

#define CREATE(I,desired_loc) var/datum/D = new I(desired_loc);INITIALIZE(D);GENERATE(D);FINALIZE(D)

#define CREATE_SAFE(I,desired_loc) \
	var/mob/living/advanced/player/L1234 = locate() in view(VIEW_RANGE,desired_loc);\
	if(!L1234) {CREATE(I,desired_loc)};

proc/create_destruction(var/turf/T,var/list/objects_to_spawn,var/material_id)
	for(var/k in objects_to_spawn)
		if(!ispath(k))
			var/atom/movable/M = k
			animate(M,pixel_x = rand(-8,8), pixel_y = rand(-8,8), time = 3)
			continue
		var/spawn_count = objects_to_spawn[k] ? objects_to_spawn[k] : 1
		for(var/i=1,i<=spawn_count,i++)
			var/obj/M = new k(T)
			if(istype(M,/obj/item/material/))
				var/obj/item/material/M2 = M
				M2.material_id = material_id
			INITIALIZE(M)
			FINALIZE(M)
			M.update_sprite()
			//GENERATE(M)
			animate(M,pixel_x = rand(-8,8), pixel_y = rand(-8,8), time = 3)

	return TRUE


