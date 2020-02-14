/obj/item/defib
	name = "defibrillator"
	icon = 'icons/obj/items/defib.dmi'
	desc = "Contains a lot of atoms!"
	desc_extended = "RCDs use this as ammo. Stick inside an RCD when empty to refill it of atoms."

	var/obj/item/defib_paddle/paddle_left
	var/obj/item/defib_paddle/paddle_right

	worn_layer = LAYER_MOB_CLOTHING_BACK
	item_slot = SLOT_TORSO_B

/obj/item/defib/can_be_worn(var/mob/living/advanced/owner,var/obj/hud/inventory/I)
	return TRUE

/obj/item/defib/New(var/desired_loc)

	paddle_left = new /obj/item/defib_paddle(src)
	paddle_left.linked_defib = src

	paddle_right = new /obj/item/defib_paddle(src)
	paddle_right.linked_defib = src

	return ..()


/obj/item/defib/clicked_on_by_object(var/mob/caller as mob,var/atom/object,location,control,params)

	if(is_inventory(object) && is_inventory(src.loc) && is_advanced(caller))
		var/obj/hud/inventory/I = src.loc
		var/obj/hud/inventory/I2 = object
		//var/mob/living/advanced/A = caller
		if(src in I.worn_objects)
			if(paddle_left in src.contents)
				I2.add_held_object(paddle_left)
				return TRUE
			else if(paddle_right in src.contents)
				I2.add_held_object(paddle_right)
				return TRUE

	return ..()


/obj/item/defib_paddle
	name = "defibrillator paddle"
	icon = 'icons/obj/items/defib_paddle.dmi'
	var/obj/item/defib/linked_defib

	throwable = FALSE

/obj/item/defib_paddle/click_on_object(var/mob/caller as mob,var/atom/object,location,control,params)

	if(object == linked_defib)
		drop_item(get_turf(src))
		return TRUE

	return ..()

/obj/item/defib_paddle/drop_item(var/turf/new_location,var/pixel_x_offset = 0,var/pixel_y_offset = 0)

	. = ..()

	if(. && linked_defib)
		src.force_move(linked_defib)

	return .