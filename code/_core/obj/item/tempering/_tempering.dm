/obj/item/tempering
	name = "tempering object"
	icon = 'icons/obj/item/tempering.dmi'
	icon_state = "error"

	var/obj/item/temper_whitelist //Type

	value = -1

	var/increase = 5
	var/limit = 125
	var/minimum = 100


/obj/item/tempering/click_on_object(var/mob/caller,var/atom/object,location,control,params)

	var/atom/defer_object = object.defer_click_on_object(location,control,params)

	if(is_item(defer_object))
		if(can_temper(caller,defer_object))
			on_temper(caller,defer_object)
			return TRUE

	return ..()

/obj/item/tempering/proc/can_temper(var/mob/caller,var/obj/item/I)

	if(!istype(I,temper_whitelist))
		caller.to_chat(span("warning","You can't temper \the [I.name] with \the [src.name]!"))
		return FALSE

	return TRUE

/obj/item/tempering/proc/on_temper(var/mob/caller,var/obj/item/I)
	visible_message("\The [caller.name] improves \the [I.name] with \the [src.name].")
	qdel(src)
	return TRUE