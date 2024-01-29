/obj/hud/button/tooltip
	name = "tooltip"
	mouse_opacity = 0
	alpha = 0
	screen_loc = "TOP,LEFT"

	icon = 'icons/hud/tooltip.dmi'
	icon_state = "tooltip"

	maptext_x = 2
	maptext_y = 3

	maptext_width = TILE_SIZE*4 - 4
	maptext_height = TILE_SIZE*2 - 6

	flags_hud = FLAG_HUD_MOB

	layer = LAYER_HUD_TOOLTIP

/obj/hud/button/tooltip/proc/set_text(desired_text,desired_screen_loc)

	if(!desired_text || !desired_screen_loc)
		animate(src,alpha=0,flags=ANIMATION_PARALLEL,time=2)
		return FALSE

	animate(src,alpha=255,flags=ANIMATION_PARALLEL,time=2)
	screen_loc = desired_screen_loc
	maptext = "<font valign='top'>[desired_text]</font>"

	return TRUE

/obj/hud/button/tooltip/update_owner(mob/desired_owner)

	var/mob/old_owner = owner

	. = ..()

	if(.)
		if(old_owner)
			old_owner.tooltip = null
		if(owner)
			owner.tooltip = src
