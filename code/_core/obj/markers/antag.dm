var/global/list/all_antag_markers = list()

/obj/marker/antag
	name = "antag marker"
	var/spawn_type

/obj/marker/antag/New(var/desired_loc)

	if(name)
		if(!all_antag_markers[name])
			all_antag_markers[name] = list()

		all_antag_markers[name] += src
	else
		log_error("Warning! Antagonist marker [src.get_debug_name()] is invalid!")

	return ..()

/obj/marker/antag/syndicate
	name = "Syndicate Operative"
	spawn_type = /mob/living/advanced/player/antagonist/syndicate

/obj/marker/antag/revolutionary
	name = "Revolutionary Soldier"
	spawn_type = /mob/living/advanced/player/antagonist/revolutionary

/obj/marker/antag/wizard
	name = "Wizard Federation Wizard"
	spawn_type = /mob/living/advanced/player/antagonist/wizard

/obj/marker/antag/merc
	name = "Mercenary"
	spawn_type = /mob/living/advanced/player/antagonist/merc

/obj/marker/antag/golem
	name = "Free Golem"
	spawn_type = /mob/living/advanced/player/antagonist/golem