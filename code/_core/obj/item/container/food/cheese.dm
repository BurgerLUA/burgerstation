/obj/item/container/food/dynamic/cheese
	name = "cheese"
	desc = "A rat's favorite."

	icon = 'icons/obj/items/consumable/food/cheese.dmi'
	icon_state = "wheel"

	health = /health/obj/item/misc/

	scale_sprite = FALSE

	var/created_date //Timestamp here.
	var/created_time

	scale_sprite = FALSE

/obj/item/container/food/dynamic/cheese/on_spawn()
	created_date = get_date()
	created_time = get_time()
	return ..()

/obj/item/container/food/dynamic/cheese/can_be_attacked(var/atom/attacker)
	return TRUE

/obj/item/container/food/dynamic/cheese/update_icon()

	if(icon_state == "wheel" && reagents.volume_current <= 10)
		icon_state = "wheel_slice"

	else if(has_prefix(icon_state,"block"))
		if(reagents.volume_current > 10)
			icon_state = "block"
		else
			icon_state = "block_slice_[ceiling(reagents.volume_current)]"

	color = reagents.color

	return ..()