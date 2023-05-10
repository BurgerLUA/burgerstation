

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

#define INITIALIZE(D)																															\
	if(D.qdeleting) {																															\
		log_error("ERROR: [D.get_debug_name()] tried to initialize while qdeleting! in [__FILE__]:[__LINE__]");									\
	}																																			\
	else if(D.initialized) {																													\
		log_error("ERROR: [D.get_debug_name()] was initialized more than once! in [__FILE__]:[__LINE__]");										\
	}																																			\
	else {																																		\
		if(!D.Initialize()) {log_error("ERROR: [D.get_debug_name()] did not run Initialize() properly! in [__FILE__]:[__LINE__]")};				\
		if(!D.PostInitialize()) {log_error("ERROR: [D.get_debug_name()] did not run PostInitialize() properly! in [__FILE__]:[__LINE__]")};		\
		D.initialized = TRUE;																													\
	}

#define GENERATE(D)																																\
	if(D.qdeleting) {																															\
		log_error("ERROR: [D.get_debug_name()] tried to generate while qdeleting! in [__FILE__]:[__LINE__]");									\
	}																																			\
	if(D.generated)	{																															\
		log_error("ERROR: [D.get_debug_name()] was generated more than once! in [__FILE__]:[__LINE__]");										\
	}																																			\
	else {																																		\
		if(!D.Generate()) {log_error("ERROR: [D.get_debug_name()] did not run Generate() properly! in [__FILE__]:[__LINE__]")};					\
		D.generated = TRUE;																														\
	}

#define FINALIZE(D)																																\
	if(D.qdeleting) {																															\
		log_error("ERROR: [D.get_debug_name()] tried to finalize while qdeleting! in [__FILE__]:[__LINE__]");									\
	}																																			\
	if(D.finalized) {																															\
		log_error("ERROR: [D.get_debug_name()] was finalized more than once! in [__FILE__]:[__LINE__]");										\
	}																																			\
	else {																																		\
		if(!D.Finalize()) {log_error("ERROR: [D.get_debug_name()] did not run Finalize() properly! in [__FILE__]:[__LINE__]")};					\
		D.finalized = TRUE;																														\
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
			INITIALIZE(M)
			if(material_id && istype(M,/obj/item/material/))
				var/obj/item/material/M2 = M
				M2.material_id = material_id
			FINALIZE(M)
			animate(M,pixel_x = rand(-8,8), pixel_y = rand(-8,8), time = 3)

	return TRUE







/**
 * Get a list of turfs in a line from `starting_atom` to `ending_atom`.
 *
 * Uses the ultra-fast [Bresenham Line-Drawing Algorithm](https://en.wikipedia.org/wiki/Bresenham%27s_line_algorithm).
 * This code was stolen from /tg/.
 */

/proc/get_line(atom/starting_atom, atom/ending_atom)
	var/current_x_step = starting_atom.x//start at x and y, then add 1 or -1 to these to get every turf from starting_atom to ending_atom
	var/current_y_step = starting_atom.y
	var/starting_z = starting_atom.z

	var/list/line = list(get_turf(starting_atom))//get_turf(atom) is faster than locate(x, y, z)

	var/x_distance = ending_atom.x - current_x_step //x distance
	var/y_distance = ending_atom.y - current_y_step

	var/abs_x_distance = abs(x_distance)//Absolute value of x distance
	var/abs_y_distance = abs(y_distance)

	var/x_distance_sign = SIGN(x_distance) //Sign of x distance (+ or -)
	var/y_distance_sign = SIGN(y_distance)

	var/x = abs_x_distance >> 1 //Counters for steps taken, setting to distance/2
	var/y = abs_y_distance >> 1 //Bit-shifting makes me l33t.  It also makes get_line() unnessecarrily fast.

	if(abs_x_distance >= abs_y_distance) //x distance is greater than y
		for(var/distance_counter in 0 to (abs_x_distance - 1))//It'll take abs_x_distance steps to get there
			y += abs_y_distance

			if(y >= abs_x_distance) //Every abs_y_distance steps, step once in y direction
				y -= abs_x_distance
				current_y_step += y_distance_sign

			current_x_step += x_distance_sign //Step on in x direction
			line += locate(current_x_step, current_y_step, starting_z)//Add the turf to the list
	else
		for(var/distance_counter in 0 to (abs_y_distance - 1))
			x += abs_x_distance

			if(x >= abs_y_distance)
				x -= abs_y_distance
				current_x_step += x_distance_sign

			current_y_step += y_distance_sign
			line += locate(current_x_step, current_y_step, starting_z)
	return line


/proc/get_line_bullet(atom/starting_atom, atom/ending_atom, collision_flag = FLAG_COLLISION_BULLET_SOLID, return_list = TRUE)

	var/current_x_step = starting_atom.x//start at x and y, then add 1 or -1 to these to get every turf from starting_atom to ending_atom
	var/current_y_step = starting_atom.y
	var/starting_z = starting_atom.z

	var/list/line = list(get_turf(starting_atom))//get_turf(atom) is faster than locate(x, y, z)

	var/x_distance = ending_atom.x - current_x_step //x distance
	var/y_distance = ending_atom.y - current_y_step

	var/abs_x_distance = abs(x_distance)//Absolute value of x distance
	var/abs_y_distance = abs(y_distance)

	var/x_distance_sign = SIGN(x_distance) //Sign of x distance (+ or -)
	var/y_distance_sign = SIGN(y_distance)

	var/x = abs_x_distance >> 1 //Counters for steps taken, setting to distance/2
	var/y = abs_y_distance >> 1 //Bit-shifting makes me l33t.  It also makes get_line() unnessecarrily fast.

	if(abs_x_distance >= abs_y_distance) //x distance is greater than y
		for(var/distance_counter in 0 to (abs_x_distance - 1))//It'll take abs_x_distance steps to get there
			y += abs_y_distance

			if(y >= abs_x_distance) //Every abs_y_distance steps, step once in y direction
				y -= abs_x_distance
				current_y_step += y_distance_sign

			current_x_step += x_distance_sign //Step on in x direction
			var/turf/T = locate(current_x_step, current_y_step, starting_z)
			if(return_list)
				line += T
			if(T.density && T.collision_bullet_flags & collision_flag)
				if(return_list)
					return line
				else
					return T
			if(T.has_dense_atom)
				for(var/k in T.contents)
					var/atom/movable/M = k
					if(M.density && M.collision_bullet_flags & collision_flag)
						if(return_list)
							return line
						else
							return M

	else
		for(var/distance_counter in 0 to (abs_y_distance - 1))
			x += abs_x_distance

			if(x >= abs_y_distance)
				x -= abs_y_distance
				current_x_step += x_distance_sign

			current_y_step += y_distance_sign
			var/turf/T = locate(current_x_step, current_y_step, starting_z)
			if(return_list)
				line += T
			if(T.density && T.collision_bullet_flags & collision_flag)
				if(return_list)
					return line
				else
					return T
			if(T.has_dense_atom)
				for(var/k in T.contents)
					var/atom/movable/M = k
					if(M.density && M.collision_bullet_flags & collision_flag)
						if(return_list)
							return line
						else
							return M
	if(return_list)
		return line
	else
		return null