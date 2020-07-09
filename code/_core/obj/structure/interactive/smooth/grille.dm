/obj/structure/smooth/table/grill
	name = "electric oven and grill"
	desc = "Cook things with this."
	desc_extended = "You can cook or heat up items by either slotting it inside the oven or dropping it on top of the grill. The oven/grill turns on and off automatically."
	icon = 'icons/obj/structure/smooth/table/grill.dmi'
	icon_state = "grill"

	corner_category = "table_reinforced"
	corner_icons = FALSE

	layer = LAYER_TABLE

	collision_flags = FLAG_COLLISION_WALKING
	collision_bullet_flags = FLAG_COLLISION_BULLET_NONE

	var/temperature_mod = 400
	var/temperature_mod_oven = 500

	bullet_block_chance = 50

/obj/structure/smooth/table/grill/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	INTERACT_CHECK

	if(is_item(object) && is_inventory(object.loc))
		var/obj/item/I = object
		var/obj/hud/inventory/I2 = object.loc
		I2.remove_object(I,get_turf(I2))
		I.force_move(src)
		caller.visible_message(
			span("notice","\The [caller] name slides in \the [I.name] into \the [src.name]."),
			span("notice","You slide in \the [I.name] into \the [src.name]."),
		)
		return TRUE
	else if(is_inventory(object))
		var/obj/hud/inventory/I = object
		var/obj/item/item_to_remove = locate() in src.contents
		if(!item_to_remove)
			caller.to_chat("\The [src.name] is empty!")
			return TRUE
		I.add_object(item_to_remove)
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

/obj/structure/smooth/table/grill/Crossed(var/atom/movable/O,var/atom/new_loc,var/atom/old_loc)
	if(O.reagents)
		src.visible_message(span("notice","The [O.name] starts to cook."))
		O.reagents.special_temperature_mod += (temperature_mod - (T0C + 20))
	return ..()

/obj/structure/smooth/table/grill/Uncrossed(var/atom/movable/O,var/atom/new_loc,var/atom/old_loc)
	if(O.reagents)
		src.visible_message(span("notice","The [O.name] continues to cook off the grille."))
		O.reagents.special_temperature_mod -= (temperature_mod - (T0C + 20))
	return ..()