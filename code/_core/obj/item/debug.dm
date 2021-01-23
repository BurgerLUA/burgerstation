/obj/item/runtime
	name = "flaw in the world"
	desc = "oh god oh fuck"
	desc_extended = "What the fuck is this? How did you get it? ANSWER ME."
	value = -1

/obj/item/runtime/click_self(var/mob/caller)
	INTERACT_CHECK
	INTERACT_DELAY(10)
	ASSERT(null) //Force a fake error.
	return TRUE


/obj/item/runtime/click_on_object(var/mob/caller as mob,var/atom/object,location,control,params)

	log_debug("caller: [caller.get_debug_name()].")
	log_debug("object: [object.get_debug_name()].")

	return TRUE

/obj/item/runtime/clicked_on_by_object(var/mob/caller as mob,var/atom/object,location,control,params)

	log_debug("caller: [caller.get_debug_name()].")
	log_debug("object: [object.get_debug_name()].")

	return TRUE