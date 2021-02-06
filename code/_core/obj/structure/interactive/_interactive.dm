obj/structure/interactive/
	name = "interactive structure"
	desc = "What does it do?"
	mouse_over_pointer = MOUSE_ACTIVE_POINTER

	var/repair_flag = FLAG_TOOL_NONE //Set this to something if it can be repaired by it.

obj/structure/interactive/get_examine_list(var/mob/examiner)

	. = ..()

	if(health)
		var/health_percent = health.health_current/health.health_max
		switch(health_percent)
			if(-INFINITY to 0.2)
				. += div("danger","It's falling apart!")
			if(0.2 to 0.4)
				. += div("danger","It looks seriously damaged.")
			if(0.4 to 0.6)
				. += div("warning","It looks very damaged.")
			if(0.6 to 0.9)
				. += div("warning","It looks damaged.")
			if(0.9 to 0.95)
				. += div("notice","It has a few scrapes.")

	return .

obj/structure/interactive/proc/can_repair(var/mob/living/advanced/caller,var/obj/item/I)

	INTERACT_CHECK_NO_DELAY(src)
	INTERACT_CHECK_NO_DELAY(I)

	if(caller.intent != INTENT_HELP)
		return FALSE

	if(!health)
		return FALSE

	if(health.health_current >= health.health_max)
		caller?.to_chat(span("warning","\The [src.name] is already repaired!"))
		return FALSE

	if(!(I.flags_tool & repair_flag))
		caller?.to_chat(span("warning","\The [I.name] cannot be used to repair \the [src.name]!"))
		return FALSE

	return TRUE


obj/structure/interactive/proc/do_repair(var/mob/living/advanced/caller,var/obj/item/I)
	visible_message(span("notice","\The [caller.name] repairs \the [src.name] with \the [I.name]."))
	health.adjust_loss_smart(brute=-100,burn=-100)

	return TRUE

obj/structure/interactive/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)



	if(repair_flag && is_item(object) && is_advanced(caller) && can_repair(caller,object))
		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		INTERACT_DELAY(5)
		PROGRESS_BAR(caller,src,SECONDS_TO_DECISECONDS(5),.proc/do_repair,caller,object)
		PROGRESS_BAR_CONDITIONS(caller,src,.proc/can_repair,caller,object)
		return TRUE

	return ..()

obj/structure/interactive/proc/check_interactables(var/mob/caller,var/atom/object,location,control,params)

	var/list/valid_interactables = list()

	var/has_multitool = FALSE

	if(is_item(object))
		var/obj/item/I = object
		if(I.flags_tool & FLAG_TOOL_MULTITOOL)
			has_multitool = TRUE

	for(var/obj/item/device/T in contents)
		if(!has_multitool && !T.interactable)
			continue
		valid_interactables += T

	var/valid_length = length(valid_interactables)
	if(!valid_length)
		return FALSE

	var/obj/item/device/T

	if(valid_length == 1)
		T = valid_interactables[1]
	else
		T = input(caller,"Which device do you wish to interact with?","Device Interaction") as null|anything in valid_interactables

	return T