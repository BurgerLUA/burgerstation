obj/inventory/use_item_on(var/mob/caller as mob,var/atom/object,location,control,params) //The src is used on the object

	if(length(held_objects) && length(held_objects)) //If we have an item in our hands, that item will now be the one that is being used.
		var/obj/item/I = held_objects[1]
		return I.use_item_on(caller,object,location,control,params)

	else if(is_item(object)) //If the object we're attacking can be held, then try to add it.
		return add_object(object)

	else if(src == object && length(worn_objects)) //If the object we're attacking is us, and we are wearing a worn item, then unequip the worn item.
		var/obj/item/clothing/C = worn_objects[length(worn_objects)]
		return (remove_object(C,get_turf(caller)) && add_held_object(C))

	else if(is_inventory(object)) //If the object is another inventory, and it has an item, take the object.
		var/obj/inventory/inv = object

		//Take held items first.
		if(length(inv.held_objects))
			var/obj/item/I = inv.held_objects[1]
			return I.use_item_on(caller,src,location,control,params)
		else if(length(inv.worn_objects))
			var/obj/item/I = inv.worn_objects[1]
			return I.use_item_on(caller,src,location,control,params)

		return FALSE

	return src.attack(caller,object,params)
