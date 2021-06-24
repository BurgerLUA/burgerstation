mob/living/on_right_down(object,location,control,params)
	return src.attack(src,object,params)

mob/living/on_left_down(object,location,control,params)
	return src.attack(src,object,params)

/mob/living/on_mouse_wheel(var/atom/object,delta_x,delta_y,location,control,params)
	return object.mouse_wheel_on_object(src,delta_x,delta_y,location,control,params)

/mob/living/proc/set_mouse_pointer(var/desired_icon)
	if(!client)
		return FALSE
	client.mouse_pointer_icon = desired_icon
	return TRUE

/mob/living/proc/update_intent(var/force)

	var/desired_intent = selected_intent
	if(attack_flags & CONTROL_MOD_GRAB)
		desired_intent = INTENT_GRAB
	else if(attack_flags & CONTROL_MOD_DISARM)
		desired_intent = INTENT_DISARM

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