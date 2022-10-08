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

	if(prob(1))
		new /turf/simulated/floor/colored/sand/beach/shallow(src)
	else
		new /turf/simulated/floor/colored/sand/beach(src)
		switch(rand(1,200))
			if(1)
				new /obj/structure/interactive/tree/palm(src)
			if(1 to 3)
				new /obj/structure/scenery/grass/normal(src)
			if(3 to 10)
				new /obj/structure/scenery/rocks(src)
			if(10 to 25)
				new /obj/item/shell(src)
			if(25 to 27)
				new /obj/marker/generation/mob/crab(src)
			if(27 to 28)
				new /obj/marker/generation/mob/lobster(src)

	if(src.loc.type == /area/)
		new /area/mission/beach(src)

	. = ..()