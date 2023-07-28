var/global/list/all_unsc_markers = list()

/obj/marker/unsc
	name = "unsc marker"
	var/spawn_type

/obj/marker/unsc/New(var/desired_loc)

	if(spawn_type && name)
		if(!all_unsc_markers[name])
			all_unsc_markers[name] = list()

		all_unsc_markers[name] += src
	else
		log_error("Warning! UNSC marker [src.get_debug_name()] is invalid!")

	return ..()

/obj/marker/unsc/odst
	name = "ODST trooper"
	spawn_type = /mob/living/advanced/player/unsc/odst

/obj/marker/unsc/odst_commander
	name = "ODST commander"
	spawn_type = /mob/living/advanced/player/unsc/odst/commander

/obj/marker/unsc/spartan_three
	name = "S-II"
	spawn_type = /mob/living/advanced/player/unsc/spartan