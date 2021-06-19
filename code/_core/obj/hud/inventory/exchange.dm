






/obj/hud/inventory/exchange
	name = "item exchange"

	max_size = SIZE_8

	flags = FLAGS_HUD_INVENTORY | FLAGS_HUD_SPECIAL

	alpha = 0 //Hidden until enabled
	mouse_opacity = 0 //Off until enabled.
	should_draw = FALSE
	drag_to_take = FALSE

	screen_loc = "CENTER,CENTER"

/obj/hud/inventory/exchange/proc/on_exchange(var/obj/item/inserted_item)
	return FALSE


/obj/hud/inventory/exchange/gold_coins
	name = "gold coins exchange"


/obj/hud/inventory/exchange/gold_coins/on_exchange(var/obj/item/inserted_item)

	if(!istype(inserted_item,/obj/item/currency))
		return FALSE

	var/obj/item/currency/C = inserted_item
	if(C.currency_class != "gold")
		return FALSE


