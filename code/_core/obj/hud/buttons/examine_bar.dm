/obj/hud/button/examine_bar
	name = "examine bar"
	mouse_opacity = 0
	icon = 'icons/hud/examine_bar.dmi'
	icon_state = "longboy"

	screen_loc = "LEFT,BOTTOM"
	maptext_width = VIEW_RANGE*TILE_SIZE

	maptext = "hello"

	flags_hud = FLAG_HUD_MOB

	layer = -1000

/obj/hud/button/examine_bar/update_owner(mob/desired_owner)

	var/mob/old_owner = owner

	. = ..()

	if(.)
		if(old_owner)
			old_owner.examine_bar = null
		if(owner)
			owner.examine_bar = src
