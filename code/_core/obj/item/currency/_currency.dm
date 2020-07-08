/obj/item/currency/
	name = "telecrystal"
	desc = "Often used as currency in the realm for its rarity and magical properties."
	desc_extended = "A crystal that can be used to teleport stuff. The bigger the stuff, the more crystals you need."

	icon = 'icons/obj/item/currency/telecrystals.dmi'
	icon_state = "1"

	value = 1

/obj/item/currency/New(var/spawn_loc,var/desired_value=0)
	..()
	if(desired_value)
		value = desired_value
	update_sprite()

/obj/item/currency/update_icon()

	if(value <= 10)
		icon_state = "[value]"
	else if(value <= 100)
		icon_state = "[FLOOR(value/10, 1)*10]"
	else if(value <= 1000)
		icon_state = "[FLOOR(value/100, 1)*100]"
	else if(value <= 5000)
		icon_state = "[FLOOR(value/1000, 1)*1000]"
	else
		icon_state = "5000"

	name = "[value] telecrystal\s"

	..()

/obj/item/currency/proc/adjust_value(var/value_amount)
	var/value_added = max(value_amount,-value)
	value += value_added
	update_sprite()
	if(value<=0)
		qdel(src)

	return value_added

/obj/item/currency/Crossed(var/atom/movable/O,var/atom/new_loc,var/atom/old_loc)

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

/obj/item/currency/clicked_on_by_object(var/mob/caller as mob,var/atom/object,location,control,params)

	if(!is_player(caller) || !value)
		return ..()

	var/mob/living/advanced/player/P = caller
	P.adjust_currency(value)
	value = 0 //just in case
	qdel(src)

	return TRUE


/obj/item/currency/lots/New(var/desired_loc)
	return ..(desired_loc,10000)