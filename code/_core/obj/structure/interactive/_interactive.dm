obj/structure/interactive/
	name = "interactive structure"
	desc = "What does it do?"
	mouse_over_pointer = MOUSE_ACTIVE_POINTER

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