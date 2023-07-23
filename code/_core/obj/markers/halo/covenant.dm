var/global/list/all_covenant_markers = list()

/obj/marker/covenant
	name = "covenant marker"
	var/spawn_type

/obj/marker/covenant/New(var/desired_loc)

	if(name)
		if(!all_covenant_markers[name])
			all_covenant_markers[name] = list()

		all_covenant_markers[name] += src
	else
		log_error("Warning! Covenant marker [src.get_debug_name()] is invalid!")

	return ..()

/obj/marker/covenant/elite_m
	name = "Elite"
	spawn_type = /mob/living/advanced/player/covenant/elite_minor

/obj/marker/covenant/elite_mj
	name = "Elite Major"
	spawn_type = /mob/living/advanced/player/covenant/elite_major

/obj/marker/covenant/elite_ultra
	name = "Elite Ultra"
	spawn_type = /mob/living/advanced/player/covenant/elite_ultra

/obj/marker/covenant/elite_shipmaster
	name = "Elite Shipmaster"
	spawn_type = /mob/living/advanced/player/covenant/elite_shipmaster

/obj/marker/covenant/grunt_m
	name = "Grunt Minor"
	spawn_type = /mob/living/advanced/player/covenant/unggoy_minor

/obj/marker/covenant/kig_yar
	name = "Jackal Marksman"
	spawn_type = /mob/living/advanced/player/covenant/kig_yar