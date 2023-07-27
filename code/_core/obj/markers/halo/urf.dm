var/global/list/all_urf_markers = list()

/obj/marker/urf
	name = "urf marker"
	var/spawn_type

/obj/marker/urf/New(var/desired_loc)

	if(spawn_type && name)
		if(!all_urf_markers[name])
			all_urf_markers[name] = list()

		all_urf_markers[name] += src
	else
		log_error("Warning! URF marker [src.get_debug_name()] is invalid!")

	return ..()

/obj/marker/urf/soe
	name = "SOE Operative"
	spawn_type = /mob/living/advanced/player/urf/soe

/obj/marker/urf/soe_commander
	name = "URF Commander"
	spawn_type = /mob/living/advanced/player/urf/soe/commander