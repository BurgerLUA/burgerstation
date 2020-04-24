proc/should_static_view()
	return (VIEW_RANGE >= world.maxx/2 || VIEW_RANGE >= world.maxy/2)

//Stolen from /tg/
/proc/stoplag()
	while(world.cpu >= 90 || world.tick_usage >= 90)
		sleep(TICK_LAG)

proc/get_offset_x(var/atom/atom_a,var/atom/atom_b)
	return (atom_a.x*TILE_SIZE) - (atom_b.x*TILE_SIZE)

proc/get_offset_y(var/atom/atom_a,var/atom/atom_b)
	return (atom_a.y*TILE_SIZE) - (atom_b.y*TILE_SIZE)

proc/get_true_offset_x(var/atom/atom_a,var/atom/atom_b)
	return (atom_a.x*TILE_SIZE + atom_a.pixel_x - initial(atom_a.pixel_x)) - (atom_b.x*TILE_SIZE + atom_b.pixel_x - initial(atom_b.pixel_x))

proc/get_true_offset_y(var/atom/atom_a,var/atom/atom_b)
	return (atom_a.y*TILE_SIZE + atom_a.pixel_y - initial(atom_a.pixel_y)) - (atom_b.y*TILE_SIZE + atom_b.pixel_y - initial(atom_b.pixel_y))

#define is_valid(A) (!A.qdeleting && A.loc != null)
#define INITIALIZE(A) (A.initialized ? log_error("WARNING: [A]([A.type]) was initialized more than once!") : A.Initialize())
#define SPAWN(A) (A.spawned ? log_error("WARNING: [A]([A.type]) was spawned more than once!") : A.on_spawn())



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
			SPAWN(M)
			animate(M,pixel_x = rand(-8,8), pixel_y = rand(-8,8), time = 3)

	return TRUE