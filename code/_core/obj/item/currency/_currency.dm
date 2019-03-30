/obj/item/currency/
	name = "bluespace crystals"
	desc = "Often used as currency in the realm for its rarity and magical properties."

	icon = 'icons/obj/items/currency/bluespace.dmi'
	icon_state = "1"

	var/value = 1

/obj/item/currency/New(var/spawn_loc)
	..()
	update_icon()

/obj/item/currency/update_icon()

	if(value <= 9)
		icon_state = "[value]"
	else if(value <= 100)
		icon_state = "[floor(value/10)]"
	else
		icon_state = "100"

/obj/item/currency/proc/adjust_value(var/value_amount)
	var/value_added = max(value_amount,-value)
	value += value_added
	update_icon()
	if(value<=0)
		qdel(src)

	return value_added

/obj/item/currency/clicked_by_object(caller,object,location,control,params)

	if(!is_currency(object))
		return ..()

	if(!is_mob(caller))
		return ..()

	var/mob/M = caller
	var/obj/item/currency/C = object

	M.to_chat(span("notice","You add [adjust_value(C.value)] crystals to the [src]. \The [src] now has [value] crystals."))

	return TRUE