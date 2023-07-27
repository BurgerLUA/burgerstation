var/global/list/all_covenant_markers = list()

/obj/marker/covenant
	name = "covenant marker"
	var/spawn_type

/obj/marker/covenant/New(var/desired_loc)

	if(spawn_type && name)
		if(!all_covenant_markers[name])
			all_covenant_markers[name] = list()

		all_covenant_markers[name] += src
	else
		log_error("Warning! Covenant marker [src.get_debug_name()] is invalid!")

	return ..()

/obj/marker/covenant/elite
	name = "Elite"
	spawn_type = /mob/living/advanced/player/covenant/elite

/obj/marker/covenant/grunt_m
	name = "Unggoy"
	spawn_type = /mob/living/advanced/player/covenant/unggoy

/obj/marker/covenant/kig_yar
	name = "Jackal Marksman"
	spawn_type = /mob/living/advanced/player/covenant/kig_yar