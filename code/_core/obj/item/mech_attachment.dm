/obj/item/mech_attachment
	name = "mech attachment device"
	desc = "What makes it stick."
	desc_extended = "A special attachment brace that connects a compatible device or weapon to a mech. Just attach an object to it, then attach this device to the mech."

	var/obj/item/attached_item


/obj/item/mech_attachment/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	object = object.defer_click_on_object(location,control,params)

	if(is_item(object))
		var/obj/item/I = object
		I.drop_item(src)
		attached_item = I

	return ..()


/obj/item/mech_attachment/proc/attach(var/atom/caller,var/atom/object)