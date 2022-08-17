/turf/unsimulated/generation/beach
	name = "beach generation"
	icon_state = "beach"

/turf/unsimulated/generation/beach/path
	icon_state = "beach_path"
	density = FALSE

/turf/unsimulated/generation/beach/generate(var/size = WORLD_SIZE)

	if(!density)
		new /turf/simulated/floor/colored/sand/beach(src)
		if(src.loc.type == /area/) new /area/mission/beach(src)
		disallow_generation = TRUE
		return ..()

	//No noise profile because of how simple it is.
	if(prob(2))
		new /obj/marker/generation/mob/crab(src)
	else if(prob(0.5))
		new /obj/marker/generation/mob/lobster(src)
	else if(prob(0.25))
		new /obj/marker/generation/mob/slime/sand(src)
	else if(prob(0.1))
		new /obj/marker/generation/mob/slime/water(src)

	new /turf/simulated/floor/colored/sand/beach(src)

	if(src.loc.type == /area/)
		new /area/mission/beach(src)

	. = ..()