/obj/structure/interactive/crate/open
	open = TRUE

/obj/structure/interactive/crate/closet
	name = "closet"
	icon = 'icons/obj/structure/closet.dmi'
	icon_state = "closet"

	pixel_y = 2

/obj/structure/interactive/crate/closet/can_prevent_close(var/atom/movable/M)
	if(is_living(M))
		var/mob/living/L = M
		if(L.size > size)
			return TRUE
	return FALSE

/obj/structure/interactive/crate/closet/anchored
	anchored = TRUE

/obj/structure/interactive/crate/engineering
	icon_state = "engineering"

/obj/structure/interactive/crate/medical
	icon_state = "medical"

/obj/structure/interactive/crate/coffin
	name = "coffin"
	icon_state = "coffin"

/obj/structure/interactive/crate/necro
	name = "necro chest"
	icon_state = "necro"

	loot = /loot/lavaland

	collect_contents_on_initialize = FALSE

	desired_light_power = 0.25
	desired_light_range = 1
	desired_light_color = "#FF0000"