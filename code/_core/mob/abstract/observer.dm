/mob/abstract/observer/
	name = "observer"
	desc = "Forever damned. Their spirit is powered by pure salt."
	desc_extended = "Those who perish in this world turn into these beings to then later be resurrected to die again and again."
	icon = 'icons/mob/abstract/ghosts.dmi'
	icon_state = "basic"
	ghost = TRUE
	layer = LAYER_GHOST

	movement_delay = 1

	var/list/spawning_buttons = list(
		/obj/button/join/red,
		/obj/button/join/blue,
		/obj/button/join/green,
		/obj/button/join/yellow
	)

/mob/abstract/observer/Initialize()

	. = ..()

	name = "ghost of [ckey]"


	to_chat(span("greeting","You are a ghost! Click on one of the wishgranters near the corners of the map to join a team, or alternatively, use the buttons below."))

	sight |= SEE_THRU

	for(var/v in spawning_buttons)
		var/obj/button/B = new v
		B.update_owner(src)

/mob/abstract/on_left_click(var/atom/object,location,control,params)
	if(is_wishgranter(object) || is_button(object))
		object.clicked_by_object(src,src,location,control,params)
		return TRUE