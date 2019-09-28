/obj/structure/interactive/shop/

	name = "ITEM NAME HERE"
	desc = "NOT IMPORTANT."

	var/list/stored_items = list()


	var/obj/item/current_item
	var/current_item_cost
	var/current_item_quantity

	icon = 'icons/obj/structure/shop.dmi'
	icon_state = "debug"


/obj/structure/interactive/shop/Initialize()
	. = ..()

	var/turf/T = get_turf(src)

	if(T)
		for(var/obj/item/I in T.contents)
			stored_items += I.type
			qdel(I)

	if(!length(stored_items))
		qdel(src)

	return .

/obj/structure/interactive/shop/update_icon()
	if(current_item)
		appearance = current_item.appearance
		name = "[current_item.name] - [current_item_cost] crystals"
	..()


/obj/structure/interactive/shop/proc/restock()

	if(current_item)
		qdel(current_item)

	if(!length(stored_items))
		LOG_ERROR("Warning: shop at [x],[y] has no items to sell. Please delete it.")
		return FALSE

	var/obj/item/desired_item = pickweight(stored_items)
	current_item = new desired_item(src)

	var/original_item_cost = current_item.value
	var/new_item_cost = original_item_cost
	var/new_quantity = 0

	switch(new_item_cost)
		if(0 to 25)
			new_quantity = rand(20,80)
		if(25 to 100)
			new_quantity = rand(20,50)
		if(100 to 500)
			new_quantity = rand(10,20)
		if(500 to 1000)
			new_quantity = rand(5,10)
		if(1000 to INFINITY)
			new_quantity = rand(1,5)

	switch(new_quantity)
		if(0 to 10)
			new_item_cost *= rand_precise(1,4)
		if(10 to 25)
			new_item_cost *= rand_precise(1,3)
		if(25 to 50)
			new_item_cost *= rand_precise(0.75,2)
		if(50 to INFINITY)
			new_item_cost *= rand_precise(0.5,1.25)

	current_item_cost = round(new_item_cost,min(original_item_cost,5))
	current_item_quantity = round(new_quantity,1)

	current_item.on_spawn()
	current_item.update_icon()
	update_icon()


/obj/structure/interactive/shop/get_examine_text(var/mob/examiner)

	var/returning_text = current_item.get_examine_text(examiner)

	if(current_item.is_container)
		var/list/contents = current_item.inventory_to_list()
		returning_text += div("notice","It contains: [english_list(contents)]")

	returning_text += div("notice","This item is being sold for [current_item_cost] crystals.") + div("notice","There is currently [current_item_quantity] of this item left.")

	return returning_text


/obj/structure/interactive/shop/clicked_by_object(caller,object,location,control,params)

	world.log << "The object is: [object]!"

	INTERACT_CHECK

	if(!is_advanced(caller))
		return FALSE

	var/mob/living/advanced/A = caller

	if(!A.client) //I mean, when the fuck will this ever happen?
		return FALSE

	if(current_item_quantity <= 0)
		A.to_chat(span("notice","This item is out of stock! Come back another time!"))
		return TRUE

	if(!is_currency(object))
		A.to_chat(span("notice","You need at least [current_item_cost] crystal\s in order to buy \the [current_item]."))
		return TRUE

	var/obj/item/currency/C = object

	if(C.value >= current_item_cost)

		var/click_flags = A.client.get_click_flags(params,TRUE)

		if(click_flags & RIGHT_HAND && A.get_right_hand())
			A.to_chat(span("notice","Your right hand needs to be unoccupied in order to buy this!"))
			return

		if(click_flags & LEFT_HAND && A.get_left_hand())
			A.to_chat(span("notice","Your left hand needs to be unoccupied in order to buy this!"))
			return

		C.adjust_value(-current_item_cost)
		current_item_quantity -= 1

		var/obj/item/new_item = new current_item.type(get_turf(A))
		new_item.on_spawn()
		A.pickup(new_item,click_flags & LEFT_HAND)
		new_item.update_icon()
		A.to_chat(span("notice","You successfully purchase \the [new_item] for [current_item_cost] crystal\s."))

		if(current_item_quantity <= 0)
			update_icon()

	else
		A.to_chat(span("notice","You don't have enough crystals to buy this!"))

	return TRUE