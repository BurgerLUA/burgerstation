/obj/hud/button/intent
	name = "intent"
	desc = "harm intent or bust"
	desc_extended = "Where you press determines where you attack."
	icon_state = "intent"
	screen_loc = "RIGHT-1,BOTTOM"

	flags = FLAGS_HUD_MOB

	var/intent = INTENT_HELP

	var/active = FALSE

/obj/hud/button/intent/update_owner()

	. = ..()

	if(is_living(owner))
		var/mob/living/L = owner
		active = L.intent == intent
		update_overlays()

	return .


/obj/hud/button/intent/clicked_on_by_object(var/mob/caller,object,location,control,params)

	. = ..()

	if(is_living(caller))
		var/mob/living/L = caller
		L.intent = intent
		for(var/obj/hud/button/intent/I in L.buttons)
			I.update_sprite()
			I.active = (I.intent == L.intent)
			I.update_overlays()

	return .

/obj/hud/button/intent/update_overlays()

	. = ..()

	if(active)
		var/icon/I = new/icon(initial(icon),"[icon_state]_active")
		overlays += I

	return .

//The reason why this isn't one button is to support button binds.
/obj/hud/button/intent/help
	name = "help intent"
	icon_state = "intent_help"
	intent = INTENT_HELP

/obj/hud/button/intent/harm
	name = "harm intent"
	icon_state = "intent_harm"
	intent = INTENT_HARM

/obj/hud/button/intent/disarm
	name = "disarm intent"
	icon_state = "intent_disarm"
	intent = INTENT_DISARM

/obj/hud/button/intent/grab
	name = "grab intent"
	icon_state = "intent_grab"
	intent = INTENT_GRAB