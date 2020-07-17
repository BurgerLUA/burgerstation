/obj/hud/button/skip
	name = "skip cutscene"
	desc = "I PUT EFFORT INTO THESE."
	desc_extended = "Skips the current cutscene."
	icon_state = "skip"
	screen_loc = "RIGHT,BOTTOM"

	var/sneaking = 0

	flags = FLAGS_HUD_SPECIAL

	has_quick_function = FALSE


/obj/hud/button/skip/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)
	. = ..()

	if(.)
		caller.skip_cutscene = TRUE

	return .
