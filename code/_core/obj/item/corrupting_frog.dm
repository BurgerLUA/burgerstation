/obj/item/corrupting_frog
	name = "corrupting frog"
	icon = 'icons/obj/item/corrupting_frog.dmi'
	icon_state = "inventory"
	desc = "One frog was harmed in the making of this item."
	desc_extended = "A magical wooden frog doll that has the ability to sacrifice one item into another similiar item. Must be used on an item on the ground. Has one use, then disappears."
	rarity = RARITY_MYTHICAL
	value = 2000
	value_burgerbux = 1

/obj/item/corrupting_frog/click_on_object(var/mob/caller,var/atom/object,location,control,params)

	if(!is_item(object) || !is_turf(object.loc))
		return ..()

	var/obj/item/O = object

	if(!O.is_safe_to_delete())
		return ..()

	var/list/found_subtypes = subtypesof(O.type)
	for(var/k in found_subtypes)
		if(!SSbalance.stored_value[k])
			found_subtypes -= k

	if(!length(found_subtypes)) //Couldn't find anything.
		found_subtypes = subtypesof(O.parent_type) - O.type
		for(var/k in found_subtypes)
			if(!SSbalance.stored_value[k])
				found_subtypes -= k

	if(!length(found_subtypes))
		caller.to_chat(span("warning","\The [src.name] doesn't seem to work on \the [O.name]..."))
		return TRUE

	var/turf/T = get_turf(O)

	var/old_object_name = O.name

	qdel(O)

	var/obj/item/I = pick(found_subtypes)
	I = new I(T)
	INITIALIZE(I)
	GENERATE(I)
	FINALIZE(I)

	visible_message(
		span("notice","With the flick of \the [src.name], \the [caller.name] turns \the [old_object_name] into \the [I.name]!"),
		span("notice","With the flick of \the [src.name], you turn \the [old_object_name] into \the [I.name]!")
	)

	play_sound('sound/weapons/magic/zap_large.ogg',T)

	qdel(src)

	return TRUE