/obj/structure/interactive/shop_holder/
	name = "ITEM NAME HERE"
	desc = "NOT IMPORTANT."

	var/list/possible_items = list()
	var/list/possible_prices = list()
	var/list/possible_quantity = list()

	var/item_cost = -1 //This is assigned automatically
	var/obj/item/stored_item //This is assigned automatically
	var/quantity = 0//This is assigned automatically

/obj/structure/interactive/shop_holder/proc/restock()

	if(stored_item)
		qdel(stored_item)

	var/obj/item/desired_item = pickweight(possible_items)
	stored_item = new desired_item(src)
	item_cost = CEILING(possible_prices[stored_item.type]*rand(0.5,4),min(possible_prices[stored_item.type],5))
	quantity = CEILING(1 + (possible_quantity[stored_item.type]-1)*rand(90,110)*0.01,1)

	stored_item.on_spawn()
	stored_item.update_icon()
	update_icon()

/obj/structure/interactive/shop_holder/update_icon()
	if(stored_item)
		appearance = stored_item.appearance
		name = "[name] - [item_cost] crystals"
	..()

/obj/structure/interactive/shop_holder/get_examine_text(var/mob/examiner)

	var/returning_text = stored_item.get_examine_text(examiner)

	if(stored_item.is_container)
		var/list/contents = stored_item.inventory_to_list()
		returning_text += div("notice","It contains: [english_list(contents)]")

	returning_text += div("notice","This item is being sold for [item_cost] crystals.")

	return returning_text

/obj/structure/interactive/shop_holder/clicked_on_by_object(caller,object,location,control,params)

	INTERACT_CHECK

	if(!is_advanced(caller))
		return FALSE

	var/mob/living/advanced/A = caller

	if(!A.client) //I mean, when the fuck will this ever happen?
		return FALSE

	if(quantity <= 0)
		A.to_chat(span("notice","This item is out of stock! Come back another time!"))
		return TRUE

	if(!is_currency(object))
		A.to_chat(span("notice","You need at least [item_cost] crystal\s in order to buy \the [stored_item]."))
		return TRUE

	var/obj/item/currency/C = object

	if(C.value >= item_cost)

		var/click_flags = A.client.get_click_flags(params,TRUE)

		if(click_flags & RIGHT_HAND && A.get_right_hand())
			A.to_chat(span("notice","Your right hand needs to be unoccupied in order to buy this!"))
			return

		if(click_flags & LEFT_HAND && A.get_left_hand())
			A.to_chat(span("notice","Your left hand needs to be unoccupied in order to buy this!"))
			return

		C.adjust_value(-item_cost)
		quantity -= 1

		var/obj/item/new_item = new stored_item.type(get_turf(A))
		new_item.on_spawn()
		new_item.update_icon()
		A.pickup(new_item,click_flags & LEFT_HAND)
		A.to_chat(span("notice","You successfully purchase \the [new_item] for [item_cost] crystal\s."))

	else
		A.to_chat(span("notice","You don't have enough crystals to buy this!"))

	return TRUE