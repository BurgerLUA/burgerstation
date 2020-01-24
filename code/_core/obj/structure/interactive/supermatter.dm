/obj/structure/interactive/supermatter
	name = "supermatter crystal"
	icon = 'icons/obj/structure/supermatter.dmi'
	icon_state = "supermatter"


/obj/structure/interactive/radiation_collector
	name = "radiation collector"
	icon = 'icons/obj/structure/power.dmi'
	icon_state = "rad_collector"

	var/active = FALSE

/obj/structure/interactive/radiation_collector/New(var/desired_loc)
	. = ..()
	update_icon()
	return .


/obj/structure/interactive/radiation_collector/update_icon()

	icon = initial(icon)
	icon_state = initial(icon_state)

	if(active)
		icon_state = "[icon_state]_on"

	return ..()

/obj/structure/interactive/radiation_collector/on
	active = TRUE
