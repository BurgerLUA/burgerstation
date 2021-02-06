/obj/structure/smooth/table/grill
	name = "electric oven and grill"
	desc = "Cook things with this."
	desc_extended = "You can cook or heat up items by either slotting it inside the oven or dropping it on top of the grill. The oven/grill turns on and off automatically."
	icon = 'icons/obj/structure/smooth/table/grill.dmi'
	icon_state = "grill"

	corner_category = "table_reinforced"
	corner_icons = FALSE
	var/enabled = FALSE

	layer = LAYER_TABLE

	collision_flags = FLAG_COLLISION_WALKING
	collision_bullet_flags = FLAG_COLLISION_BULLET_NONE

	var/temperature_mod = 590
	var/temperature_mod_oven = 475

	bullet_block_chance = 50

/obj/structure/smooth/table/grill/get_examine_details_list(var/mob/examiner)

	. = ..()

	for(var/k in src.contents)
		var/atom/movable/M = k
		. += span("notice","It contains \the [M.name].")

	return .

/obj/structure/smooth/table/grill/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)



	if(is_item(object))
		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		INTERACT_DELAY(1)
		if(!anchored)
			if(length(src.contents))
				caller.to_chat(span("warning","\The [src.name] is full!"))
				return TRUE
			icon_state = "grill_on"
			enabled = TRUE
			update_atom_light()
		var/obj/item/I = object
		I.drop_item(src)
		caller.visible_message(
			span("notice","\The [caller] name slides in \the [I.name] into \the [src.name]."),
			span("notice","You slide in \the [I.name] into \the [src.name]."),
		)
		return TRUE

	if(is_inventory(object))
		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		INTERACT_DELAY(1)
		var/obj/hud/inventory/I = object
		var/obj/item/item_to_remove = locate() in src.contents
		if(!item_to_remove)
			caller.to_chat(span("warning","\The [src.name] is empty!"))
			return TRUE
		I.add_object(item_to_remove)
		if(!anchored)
			icon_state = "grill_open"
			enabled = FALSE
			update_atom_light()
		return TRUE

	return ..()

/obj/structure/smooth/table/grill/Entered(var/atom/movable/O,var/atom/old_loc)
	if(O.reagents)
		O.reagents.special_temperature_mod += (temperature_mod_oven - (T0C + 20))
	return ..()

/obj/structure/smooth/table/grill/Exited(var/atom/movable/O,var/atom/new_loc)
	if(O.reagents)
		O.reagents.special_temperature_mod -= (temperature_mod_oven - (T0C + 20))
	return ..()

/obj/structure/smooth/table/grill/Crossed(atom/movable/O)
	if(O.reagents && anchored)
		src.visible_message(span("notice","The [O.name] starts to cook."))
		O.reagents.special_temperature_mod += (temperature_mod - (T0C + 20))
	return ..()

/obj/structure/smooth/table/grill/Uncrossed(atom/movable/O)
	if(O.reagents && anchored)
		src.visible_message(span("notice","The [O.name] continues to cook off the grille."))
		O.reagents.special_temperature_mod -= (temperature_mod - (T0C + 20))
	return ..()

/obj/structure/smooth/table/grill/barbecue
	name = "electric portable grill"
	desc = "I just wanna grill for god's sake."
	desc_extended = "You can cook or heat up items by slotting it inside the grill. Can fit one item at a time. The grill turns on and off automatically."
	icon = 'icons/obj/structure/grill.dmi'
	icon_state = "grill"
	anchored = FALSE
	desired_light_range = VIEW_RANGE*0.2
	desired_light_power = 1
	desired_light_color = "#B82E00"
	desired_light_angle = LIGHT_OMNI

/obj/structure/smooth/table/grill/barbecue/update_atom_light()
	if(enabled)
		set_light(desired_light_range, desired_light_power, desired_light_color,desired_light_angle)
	else
		set_light(FALSE)
	return TRUE