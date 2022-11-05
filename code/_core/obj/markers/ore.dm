/obj/marker/ore
	name = "possisble ore spawn"

/obj/marker/ore/New(var/desired_loc)
	var/chance = prob(25)
	if(chance)
		new /obj/structure/interactive/ore_deposit/random(src.loc)
		qdel(src) //We arent needed any more go away.
	else
		call(/obj/marker/ore_deep,New)(desired_loc)
	return ..()

/obj/marker/ore_deep
	name = "possible deep ore spawn"

/obj/marker/ore_deep/New(var/desired_loc)
	var/chance = 1
	if(chance)
		new /obj/structure/interactive/ore_deposit_ground/random(src.loc)
	qdel(src) //We arent needed any more go away.
	return ..()
