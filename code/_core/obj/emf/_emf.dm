/obj/emf
	name = "EMF Bubble"

	var/emf_level = 3

	var/emf_range = VIEW_RANGE*0.5

	invisibility = 101
	alpha = 0
	mouse_opacity = 0

/obj/emf/New(var/desired_loc,var/desired_level,var/desired_range)
	. = ..()
	SSghost.all_emfs += src


	if(desired_level)
		emf_level = desired_level

	if(desired_range)
		emf_range = desired_range

	return .

/obj/emf/Destroy()
	SSghost.all_emfs -= src
	return ..()

//For Debug Purposes
/obj/emf/level_2
	emf_level = 2
	maptext = "Level 2"

/obj/emf/level_3
	emf_level = 3
	maptext = "Level 3"

/obj/emf/level_4
	emf_level = 4
	maptext = "Level 4"

/obj/emf/level_5
	emf_level = 5
	maptext = "Level 5"