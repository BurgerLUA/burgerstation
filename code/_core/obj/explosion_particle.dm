/obj/explosion_particle
	name = "explosion"
	desc = "KaBOOM!"

	icon = 'icons/obj/effects/fire.dmi'
	icon_state = "3"

/obj/explosion_particle/New(var/desired_loc)

	. = ..()

	spawn(3)
		icon_state = "2"
		sleep(2)
		icon_state = "1"
		sleep(2)
		qdel(src)

	return .