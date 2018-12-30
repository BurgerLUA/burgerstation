/obj/item/use_item_on(var/mob/caller as mob,var/atom/object,location,control,params) //src is used on object

	if(istype(object,/obj/inventory/)) //We're giving the object to the inventory
		var/obj/inventory/I = object
		return transfer_item(I)

	if(..())
		return TRUE

	return attack(caller,object,params)