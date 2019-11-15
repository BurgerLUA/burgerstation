/obj/item/currency/
	name = "telecrystal"
	desc = "Often used as currency in the realm for its rarity and magical properties."

	icon = 'icons/obj/items/currency/telecrystals.dmi'
	icon_state = "1"

	value = 1

/obj/item/currency/New(var/spawn_loc,var/desired_value=0)
	..()
	if(desired_value)
		value = desired_value
	update_icon()

/obj/item/currency/update_icon()

	if(value <= 10)
		icon_state = "[value]"
	else if(value <= 100)
		icon_state = "[floor(value/10)*10]"
	else if(value <= 1000)
		icon_state = "[floor(value/100)*100]"
	else if(value <= 5000)
		icon_state = "[floor(value/1000)*1000]"
	else
		icon_state = "5000"

	name = "[value] telecrystal\s"

	..()

/obj/item/currency/proc/adjust_value(var/value_amount)
	var/value_added = max(value_amount,-value)
	value += value_added
	update_icon()
	if(value<=0)
		qdel(src)

	return value_added

/obj/item/currency/Crossed(var/atom/movable/O)

	if(is_player(O))
		var/mob/living/advanced/player/P = O
		P.adjust_currency(value)
		value = 0
		qdel(src)

	if(is_currency(O))
		var/obj/item/currency/C = O
		C.value += value
		value = 0 //Just in case
		qdel(src)

	return ..()

/obj/item/currency/transfer_item(var/obj/hud/inventory/new_inventory)

	if(new_inventory && new_inventory.owner && is_player(new_inventory.owner))
		var/mob/living/advanced/player/P = new_inventory.owner
		P.adjust_currency(value)
		value = 0 //just in case
		qdel(src)
		return TRUE

	return ..()

/obj/item/currency/clicked_on_by_object(var/mob/caller as mob,var/atom/object,location,control,params)

	if(!is_player(caller) || !value)
		return ..()

	var/mob/living/advanced/player/P = caller
	P.adjust_currency(value)
	value = 0 //just in case
	qdel(src)

	return TRUE