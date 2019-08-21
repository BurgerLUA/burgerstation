/obj/item/currency/
	name = "bluespace crystals"
	desc = "Often used as currency in the realm for its rarity and magical properties."

	icon = 'icons/obj/items/currency/bluespace.dmi'
	icon_state = "1"

	var/value = 1

/obj/item/currency/New(var/spawn_loc,var/desired_value=0)
	..()
	if(desired_value)
		value = desired_value
	update_icon()

/obj/item/currency/update_icon()

	if(value <= 9)
		icon_state = "[value]"
	else if(value <= 100)
		icon_state = "[floor(value/10)*10]"
	else
		icon_state = "100"

	..()

/obj/item/currency/proc/adjust_value(var/value_amount)
	var/value_added = max(value_amount,-value)
	value += value_added
	update_icon()
	if(value<=0)
		drop_item(get_turf(src))
		qdel(src)

	return value_added

/obj/item/currency/click_on_object(caller,var/atom/object,location,control,params)

	object = object.defer_click_on_object()

	if(object == src)
		return ..()

	if(!is_currency(object))
		return ..()

	if(!is_mob(caller))
		return ..()

	var/mob/M = caller
	var/obj/item/currency/C = object

	if(is_inventory(object.loc))
		M.to_chat(span("notice","You add [C.adjust_value(src.value)] crystals to the [C]. \The [C] now has [C.value] crystals."))
		drop_item()
		qdel(src)
	else
		M.to_chat(span("notice","You take [adjust_value(C.value)] crystals from the [C]. \The [src] now has [value] crystals."))
		C.drop_item()
		qdel(C)

	return TRUE

/obj/item/currency/on_spawn()
	value = 10000
	return ..()