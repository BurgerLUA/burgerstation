/obj/item/weapon/ranged/energy/halo/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)



	if(istype(object,/obj/item/))

		caller.to_chat(span("warning","What are you trying to do?"))
		return FALSE

	return ..()