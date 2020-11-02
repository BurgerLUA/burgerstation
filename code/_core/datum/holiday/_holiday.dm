/holiday/
	var/name = "Holiday Name"

/holiday/proc/horde_post_death(var/mob/living/L)
	return TRUE


/holiday/halloween
	name = "Halloween"



/holiday/halloween/horde_post_death(var/mob/living/L)

	if(prob(25))
		var/turf/T = get_turf(L)
		if(T)
			var/obj/item/storage/bags/goodie/halloween/H = new (T)
			INITIALIZE(H)
			GENERATE(H)
			FINALIZE(H)
			H.Move(get_step(L,L.dir))

	return ..()