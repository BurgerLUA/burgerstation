/obj/structure/interactive/localmachine/snowflake/hint
	name = "hint"
	desc = "Treating you like a child since 1958."
	invisibility = 101

	icon = 'icons/hud/hints.dmi'
	icon_state = ""

	var/icon_state_enter = "none"
	var/icon_state_exit = "none"

	plane = PLANE_EFFECT

/obj/structure/interactive/localmachine/snowflake/hint/Crossed(var/atom/movable/O,var/atom/new_loc,var/atom/old_loc)

	if(ismob(O))
		set_icon_state_mob(O,icon_state_enter)

	return ..()

/obj/structure/interactive/localmachine/snowflake/hint/Uncrossed(var/atom/movable/O,var/atom/new_loc,var/atom/old_loc)

	if(ismob(O))
		set_icon_state_mob(O,icon_state_exit)

	return ..()


/obj/structure/interactive/localmachine/snowflake/hint/walk
	icon_state = "movement"
	icon_state_enter = "movement"
	icon_state_exit = "none"

/obj/structure/interactive/localmachine/snowflake/hint/click
	icon_state = "none"
	icon_state_enter = "interaction"
	icon_state_exit = "none"