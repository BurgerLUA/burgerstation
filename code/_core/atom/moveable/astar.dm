/atom/movable/proc/a_star_pathfind(var/turf/target_turf)

	. = list()

	for(var/i=1,i<=100,i++)
		var/turf/T = get_turf(src)
		if(T == target_turf)
			return .




