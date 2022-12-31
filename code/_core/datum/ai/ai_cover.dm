
/* This is a very custom system that is kind of bad.
/ai/proc/get_potential_cover()

	var/x1 = clamp(owner.x-VIEW_RANGE,0,world.maxx)
	var/y1 = clamp(owner.y-VIEW_RANGE,1,world.maxx)

	var/x2 = clamp(owner.x+VIEW_RANGE,0,world.maxx)
	var/y2 = clamp(owner.y+VIEW_RANGE,1,world.maxx)

	var/turf/T1 = locate(x1,y1,owner.z)
	var/turf/T2 = locate(x2,y2,owner.z)

	var/list/block_turfs = block(T1,T2)

	var/list/cover_coords = new/list[VIEW_RANGE][VIEW_RANGE]

	for(var/k in block_turfs)
		var/turf/T = k
		cover_coords[T.x][T.y] = T.has_opaque_atom && T.has_dense_atom
*/

