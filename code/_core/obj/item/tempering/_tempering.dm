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



	if(is_item(object))
		if(can_temper(caller,object))
			INTERACT_CHECK
			INTERACT_CHECK_OBJECT
			INTERACT_DELAY(5)
			if(caller.attack_flags & CONTROL_MOD_ALT)
				on_temper(caller,object)
				return TRUE
			else
				var/choice = input("Do you want to temper \the [object.name]?","Alt+Click to skip this next time") as null|anything in list("Yes","No")
				if(choice == "Yes")
					on_temper(caller,object)
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