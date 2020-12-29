/obj/item/broom
	name = "broom"
	icon = 'icons/obj/item/broom.dmi'
	desc = "Make large sweeping statements with this broom."
	desc_extended = "Sweeps all items around the user into a nice tidy tile. Good for garbage collection. Also good for beating people over the head with."

	damage_type = /damagetype/melee/club/broom

	size = SIZE_3

	value = 200

/obj/item/broom/click_on_object(var/mob/caller as mob,var/atom/object,location,control,params)

	if(isturf(object))
		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		INTERACT_DELAY(10)
		var/turf/T = object
		for(var/obj/item/I in orange(T,1))
			if(I.anchored)
				continue
			I.Move(T)
		return TRUE

	return ..()