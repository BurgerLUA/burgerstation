/obj/item/marker
	name = "marker pen"
	desc = "Rename items!"
	desc_extended = "An almost magical pen that lets you rename certain items. One time use. Don't abuse this."

	icon = 'icons/obj/item/marker.dmi'
	icon_state = "inventory"

	value = 50
	value_burgerbux = 2

	weight = 0.1

/obj/item/marker/click_on_object(var/mob/caller as mob,var/atom/object,location,control,params)



	if(!is_item(object) || object == src)
		return ..()

	INTERACT_CHECK
	INTERACT_CHECK_OBJECT

	var/obj/item/I = object

	var/confrim = input("Are you sure you wish to rename \the [I.name]? The marker will be spent after this operation!","Marker Rename","Cancel") as null|anything in list("Yes","No","Cancel")

	if(confrim != "Yes")
		return TRUE

	INTERACT_CHECK
	INTERACT_CHECK_OBJECT

	caller.to_chat(span("danger","Note that abuse of the rename feature will result in a ban."))

	var/desired_name = input("What would you like to rename \the [I.name] to? Enter nothing to cancel.","Rename Item.",I.name) as text

	if(!desired_name)
		return TRUE

	INTERACT_CHECK
	INTERACT_CHECK_OBJECT

	desired_name = sanitize(desired_name,50)

	if(!desired_name)
		return TRUE

	INTERACT_CHECK
	INTERACT_CHECK_OBJECT

	caller.visible_message(span("notice","\The [caller.name] renames \the [I.name] to [desired_name]."),span("notice","You rename \the [I.name] to [desired_name]."))

	log_admin("[caller.get_debug_name()] renamed \"[I.name]\" to \"[desired_name]\".")

	I.name = desired_name

	caller.to_chat(span("warning","\The [src] is spent."))
	qdel(src)

	return TRUE