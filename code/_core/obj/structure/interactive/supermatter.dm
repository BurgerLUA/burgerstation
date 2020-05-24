/obj/structure/interactive/supermatter
	name = "supermatter crystal"
	desc = "Looks valuable!"
	desc_extended = "You should send this to central command as soon as possible!"
	icon = 'icons/obj/structure/supermatter.dmi'
	icon_state = "supermatter"

	collision_flags = FLAG_COLLISION_WALKING
	collision_bullet_flags = FLAG_COLLISION_BULLET_INORGANIC

	collision_dir = NORTH | EAST | SOUTH | WEST

	value = 1000

	bullet_block_chance = 90

/obj/structure/interactive/supermatter/unachored
	anchored = FALSE

/obj/structure/interactive/radiation_collector
	name = "radiation collector"
	icon = 'icons/obj/structure/power.dmi'
	icon_state = "rad_collector"

	var/active = FALSE

/obj/structure/interactive/radiation_collector/New(var/desired_loc)
	. = ..()
	update_sprite()
	return .


/obj/structure/interactive/radiation_collector/update_icon()

	icon = initial(icon)
	icon_state = initial(icon_state)

	if(active)
		icon_state = "[icon_state]_on"

	return ..()

/obj/structure/interactive/radiation_collector/on
	active = TRUE
