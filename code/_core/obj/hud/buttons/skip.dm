/obj/hud/button/skip
	name = "skip cutscene"
	desc = "I PUT EFFORT INTO THESE."
	desc_extended = "Skips the current cutscene."
	icon_state = "skip"
	screen_loc = "RIGHT,BOTTOM:12"

	var/sneaking = 0

	flags_hud = FLAG_HUD_SPECIAL

	has_quick_function = FALSE


/obj/hud/button/skip/clicked_on_by_object(var/mob/activator,var/atom/object,location,control,params)

	. = ..()

	if(.)
		activator.skip_cutscene = TRUE