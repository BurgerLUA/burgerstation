/client/verb/populate_world()
	set category = "Debug"

	set name = "Populate World"

	var/turf/simulated/floor/valid_floors = list()

	for(var/turf/simulated/floor/F in world)
		var/valid_turf = TRUE
		for(var/atom/movable/A in F.contents)
			if(A.density)
				valid_turf = FALSE
				break

		if(!valid_turf)
			continue

		valid_floors += F

	spawn()
		for(var/i=1,i<=100,i++)
			var/turf/T = pick(valid_floors)
			var/mob/living/advanced/player/debug/P = new(T)
			P.Initialize()
			step(P,pick(NORTH,EAST,SOUTH,WEST))
			sleep(1)


