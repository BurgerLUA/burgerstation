

proc/should_static_view()
	return (VIEW_RANGE >= world.maxx/2 || VIEW_RANGE >= world.maxy/2)

/*
proc/get_offset_x(var/atom/atom_a,var/atom/atom_b)
	return (atom_a.x*TILE_SIZE) - (atom_b.x*TILE_SIZE)

proc/get_offset_y(var/atom/atom_a,var/atom/atom_b)
	return (atom_a.y*TILE_SIZE) - (atom_b.y*TILE_SIZE)

proc/get_true_offset_x(var/atom/atom_a,var/atom/atom_b)
	return (atom_a.x*TILE_SIZE + atom_a.pixel_x - initial(atom_a.pixel_x)) - (atom_b.x*TILE_SIZE + atom_b.pixel_x - initial(atom_b.pixel_x))

proc/get_true_offset_y(var/atom/atom_a,var/atom/atom_b)
	return (atom_a.y*TILE_SIZE + atom_a.pixel_y - initial(atom_a.pixel_y)) - (atom_b.y*TILE_SIZE + atom_b.pixel_y - initial(atom_b.pixel_y))
*/

#define is_valid(A) (A && !A.qdeleting)

#define INITIALIZE(D)																								\
	if(D.initialized) {																								\
		log_error("ERROR: [D.get_debug_name()] was initialized more than once! in [__FILE__]:[__LINE__]");										\
	}																												\
	else {																											\
		if(!D.Initialize()) {log_error("ERROR: [D.get_debug_name()] did not run Initialize() properly! in [__FILE__]:[__LINE__]")};				\
		if(!D.PostInitialize()) {log_error("ERROR: [D.get_debug_name()] did not run PostInitialize() properly! in [__FILE__]:[__LINE__]")};		\
		D.initialized = TRUE;																						\
	}

#define GENERATE(D)																									\
	if(D.generated)	{																								\
		log_error("ERROR: [D.get_debug_name()] was generated more than once! in [__FILE__]:[__LINE__]");											\
	}																												\
	else {																											\
		if(!D.Generate()) {log_error("ERROR: [D.get_debug_name()] did not run Generate() properly! in [__FILE__]:[__LINE__]")};					\
		D.generated = TRUE;																							\
	}

#define FINALIZE(D)																									\
	if(D.finalized) {																								\
		log_error("ERROR: [D.get_debug_name()] was finalized more than once! in [__FILE__]:[__LINE__]");											\
	}																												\
	else {																											\
		if(!D.Finalize()) {log_error("ERROR: [D.get_debug_name()] did not run Finalize() properly! in [__FILE__]:[__LINE__]")};					\
		D.finalized = TRUE;																							\
	}

/proc/CREATE(var/atom/A,var/atom/desired_loc)
	A = new A(desired_loc)
	INITIALIZE(A)
	GENERATE(A)
	FINALIZE(A)
	return A

/proc/CREATE_SAFE(I,desired_loc)
	var/mob/living/advanced/player/P = locate() in viewers(VIEW_RANGE,desired_loc)
	if(!P)
		CREATE(I,desired_loc)

proc/create_destruction(var/turf/T,var/list/objects_to_spawn,var/material_id = null)
	for(var/k in objects_to_spawn)
		if(!ispath(k))
			var/atom/movable/M = k
			animate(M,pixel_x = rand(-8,8), pixel_y = rand(-8,8), time = 3)
			continue
		var/spawn_count = objects_to_spawn[k] ? objects_to_spawn[k] : 1
		for(var/i=1,i<=spawn_count,i++)
			var/obj/M = new k(T)
			if(istype(M,/obj/item/material/) && material_id)
				var/obj/item/material/M2 = M
				M2.material_id = material_id
			INITIALIZE(M)
			FINALIZE(M)
			M.update_sprite()
			//GENERATE(M)
			animate(M,pixel_x = rand(-8,8), pixel_y = rand(-8,8), time = 3)

	return TRUE


