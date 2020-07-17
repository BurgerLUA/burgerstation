/obj/item/mech_attachment
	name = "vehicle attachment device"
	desc = "What makes it stick."
	desc_extended = "A special attachment brace that connects a compatible device or weapon to a mech. Just attach an object to it, then attach this device to the mech."
	icon = 'icons/obj/item/attachment.dmi'
	icon_state = "inventory"

	var/obj/item/attached_item

	value = 300

/obj/item/mech_attachment/click_on_object(var/mob/caller as mob,var/atom/object,location,control,params)

	if(!is_inventory(src.loc))
		return attached_item.click_on_object(caller,object,location,control,params)

	return ..()


/obj/item/mech_attachment/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	object = object.defer_click_on_object(location,control,params)

	if(is_item(object))
		var/obj/item/I = object
		if(I.flags_tool)
			if(I.flags_tool & FLAG_TOOL_SCREWDRIVER)
				unattach(caller)
				return TRUE
		else
			attach(caller,object)
			return TRUE

	return ..()


/obj/item/mech_attachment/update_underlays()

	. = ..()

	if(attached_item)
		var/image/I = new/image
		I.appearance = attached_item.appearance
		underlays += I

	return .

/obj/item/mech_attachment/update_sprite()

	. = ..()

	name = initial(name)

	if(attached_item)
		name = "[name] ([attached_item.name])"

	return .


/obj/item/mech_attachment/proc/attach(var/mob/caller,var/obj/item/I)
	if(attached_item)
		caller?.to_chat(span("warning","There is already a [attached_item.name] attached to \the [src.name]!"))
		return FALSE
	I.drop_item(src)
	attached_item = I
	caller?.to_chat(span("notice","You attach \the [I.name] to \the [src.name]."))
	update_sprite()
	return TRUE

/obj/item/mech_attachment/proc/unattach(var/mob/caller)
	if(!attached_item)
		caller?.to_chat(span("warning","There is nothing to detach from \the [src.name]!"))
		return FALSE
	caller?.to_chat(span("notice","You detach \the [attached_item.name] to \the [src.name]."))
	attached_item.force_move(get_turf(src))
	attached_item = null
	update_sprite()
	return TRUE