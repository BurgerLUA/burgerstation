/obj/item/marker
	name = "marker pen"
	desc = "Rename items!"
	desc_extended = "An almost magical pen that lets you rename certain items. One time use. Don't abuse this."

	icon = 'icons/obj/item/marker.dmi'
	icon_state = "inventory"

	value = 500

/obj/item/marker/click_on_object(var/mob/caller as mob,var/atom/object,location,control,params)

	object = object.defer_click_on_object(location,control,params)

	if(!is_item(object))
		return ..()

	var/obj/item/I = object

	var/confrim = input("Are you sure you wish to rename \the [I.name]? The marker will be spent after this operation!","Marker Rename","Cancel") as null|anything in list("Yes","No","Cancel")

	if(confrim != "Yes")
		return TRUE

	caller.to_chat(span("danger","Note that abuse of the rename feature will result in a ban."))

	var/desired_name = input("What would you like to rename \the [I.name] to? Enter nothing to cancel.","Rename Item.",I.name) as text

	if(!desired_name)
		return TRUE

	desired_name = sanitize(desired_name,50)

	if(!desired_name)
		return TRUE

	caller.visible_message(span("notice","\The [caller.name] renames \the [I.name] to [desired_name]."))

	I.name = desired_name

	caller.to_chat(span("notice","\The [src] is spent."))
	qdel(src)

	return ..()