obj/structure/interactive/
	name = "interactive structure"
	desc = "What does it do?"
	mouse_over_pointer = MOUSE_ACTIVE_POINTER


obj/structure/interactive/clicked_on_by_object(var/mob/caller,object,location,control,params)

	for(var/obj/item/trigger_mechanism/T in contents)
		if(!T.interactable)
			continue
		return T.clicked_on_by_object(caller,object,location,control,params)

	return ..()