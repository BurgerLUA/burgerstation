/obj/effect/temp/lightning
	name = "lightning"
	icon = 'icons/obj/effects/lightning.dmi'
	icon_state = "lightning"

/obj/effect/temp/lightning/New(var/desired_loc,var/desired_time)
	. = ..()
	icon_state = "[initial(icon_state)][rand(1,12)]"