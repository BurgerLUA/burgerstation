/obj/hud/button/intent
	name = "intent"
	desc = "harm intent or bust"
	desc_extended = "Where you press determines where you attack."
	icon_state = "intent"
	screen_loc = "RIGHT-2,BOTTOM"

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


/mob/living/proc/set_mouse_pointer(var/desired_icon)
	if(!client)
		return FALSE
	client.mouse_pointer_icon = desired_icon
	return TRUE

/mob/living/proc/set_intent(var/desired_intent,var/force)

	if(intent == desired_intent && !force)
		return FALSE

	intent = desired_intent

	if(stand && stand.linked_stand && stand.linked_stand.ai)
		if(intent != INTENT_HARM)
			stand.linked_stand.ai.set_objective(null)
		stand.linked_stand.ai.set_active(intent == INTENT_HARM)

	for(var/obj/hud/button/intent/I in buttons)
		I.update_sprite()
		I.active = (I.intent == intent)
		I.update_overlays()

	if(client)
		switch(intent)
			if(INTENT_HELP)
				set_mouse_pointer('icons/pointers/help_switch.dmi')
			if(INTENT_DISARM)
				set_mouse_pointer('icons/pointers/disarm_switch.dmi')
			if(INTENT_GRAB)
				set_mouse_pointer('icons/pointers/grab_switch.dmi')
			if(INTENT_HARM)
				set_mouse_pointer('icons/pointers/harm_switch.dmi')

		var/icon_to_use = intent == INTENT_HELP ? 'icons/pointers/help.dmi' : 'icons/pointers/non_help.dmi'
		CALLBACK("\ref[src]_intent_switch",10,src,.proc/set_mouse_pointer,icon_to_use)


	return TRUE

/obj/hud/button/intent/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	. = ..()

	if(. && is_living(caller))
		var/mob/living/L = caller
		L.set_intent(intent)

	return .

/obj/hud/button/intent/update_overlays()

	overlays.Cut()

	. = ..()

	if(active)
		var/icon/I = new/icon(initial(icon),"[icon_state]_active")
		add_overlay(I)

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