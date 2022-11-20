/obj/marker/ore
	name = "ore spawn"

/obj/marker/ore/New(var/desired_loc)
	new /obj/structure/interactive/ore_deposit/random(src.loc)
	return ..()

/obj/marker/ore_deep
	name = "deep ore spawn"

/obj/marker/ore_deep/New(var/desired_loc)
	new /obj/structure/interactive/ore_deposit_ground/random(src.loc)
	return ..()
