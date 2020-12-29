/obj/item/matter_cartridge
	name = "matter cartridge"
	icon = 'icons/obj/item/matter_cartridge.dmi'
	icon_state = "rcd"
	desc = "Contains a lot of atoms!"
	desc_extended = "RCDs use this as ammo. Stick inside an RCD when empty to refill it of atoms."
	value = 50

	weight = 5


/obj/item/matter_cartridge/click_on_object(var/mob/caller as mob,var/atom/object,location,control,params)

	INTERACT_CHECK

	object = object.defer_click_on_object(location,control,params)

	INTERACT_CHECK_OTHER(object)
	INTERACT_DELAY(10)

	if(istype(object,/obj/item/rcd/))
		var/obj/item/rcd/R = object
		R.add_matter(R.matter_max)
		caller.to_chat(span("notice","You refill \the [R.name]."))
		qdel(src)
		return TRUE

	return ..()