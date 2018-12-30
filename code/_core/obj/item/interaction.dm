/obj/item/use_item_on(var/mob/caller as mob,var/atom/object,location,control,params) //src is used on object

	if(istype(object,/obj/inventory/)) //We're attacking an inventory slot
		var/obj/inventory/I = object

		if(length(I.held_objects) && I.held_objects[1] == src)
			return attack_self(caller)



		return transfer_item(I) //We're giving the object to the inventory

	if(..())
		return TRUE

	return attack(caller,object,params)

/obj/item/proc/attack_self(caller) //When the object is held and it is activated in the slot.
	return TRUE