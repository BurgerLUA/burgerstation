/obj/structure/interactive/shop/

	name = "ITEM NAME HERE"
	desc = "NOT IMPORTANT."

	var/list/stored_items = list()

	var/obj/item/current_item
	var/current_item_cost
	var/current_item_quantity

	icon = 'icons/obj/structure/shop.dmi'
	icon_state = "debug"

/obj/structure/interactive/shop/Destroy()

	all_shops -= src

	stored_items.Cut()

	qdel(current_item)
	current_item = null


	return ..()

/obj/structure/interactive/shop/Initialize()

	. = ..()

	var/turf/T = get_turf(src)

	if(T)
		for(var/obj/item/I in T.contents)
			stored_items += I.type
			qdel(I)

	if(!length(stored_items))
		qdel(src)
		return FALSE

	return .

/obj/structure/interactive/shop/update_icon()
	if(current_item)
		appearance = current_item.appearance
		mouse_opacity = 2
		name = "[current_item.name] - [current_item_cost] crystals"
	..()

/obj/structure/interactive/shop/proc/restock()

	if(current_item)
		qdel(current_item)
		current_item = null

	if(!length(stored_items))
		LOG_ERROR("Warning: shop at [x],[y] has no items to sell. Please delete it.")
		return FALSE

	var/obj/item/desired_item = pickweight(stored_items)
	current_item = new desired_item(src)
	current_item.on_spawn()
	current_item.update_icon()

	var/original_item_cost = current_item.calculate_value()
	var/new_item_cost = original_item_cost
	var/new_quantity = 0

	switch(new_item_cost)
		if(0 to 100)
			new_quantity = rand(75,150)
		if(100 to 250)
			new_quantity = rand(50,125)
		if(250 to 500)
			new_quantity = rand(25,100)
		if(500 to 1000)
			new_quantity = rand(10,50)
		if(1000 to INFINITY)
			new_quantity = rand(3,10)

	switch(new_quantity)
		if(0 to 10)
			new_item_cost *= rand_precise(1,2)
		if(10 to 25)
			new_item_cost *= rand_precise(1,1.75)
		if(25 to 50)
			new_item_cost *= rand_precise(1,1.5)
		if(50 to INFINITY)
			new_item_cost *= rand_precise(1,1.25)

	current_item_cost = round(new_item_cost,min(original_item_cost,5))
	current_item_quantity = round(new_quantity,1)

	update_icon()

/obj/structure/interactive/shop/get_examine_text(var/mob/examiner)

	var/returning_text = current_item.get_examine_text(examiner)

	if(current_item.is_container)
		var/list/contents = current_item.inventory_to_list()
		returning_text += div("notice","It contains: [english_list(contents)]")

	returning_text += div("notice","This item is being sold for [current_item_cost] credits.") + div("notice","There is currently [current_item_quantity] of this item left.")

	return returning_text

/obj/structure/interactive/shop/clicked_on_by_object(var/atom/caller,var/atom/object,location,control,params)

	INTERACT_CHECK

	if(!is_player(caller))
		return TRUE

	var/mob/living/advanced/player/P = caller
	var/atom/defer_object = object.defer_click_on_object()

	if(current_item_quantity <= 0)
		P.to_chat(span("notice","This item is out of stock! Come back another time!"))
		return TRUE

	if(!is_inventory(defer_object))
		P.to_chat(span("notice","Your hand needs to be empty in order to buy this!"))
		return TRUE

	var/obj/hud/inventory/I = defer_object

	if(P.currency >= current_item_cost && P.spend_currency(current_item_cost)) //Just in case
		spawn()
			current_item_quantity -= 1
			var/obj/item/new_item = new current_item.type(get_turf(src))
			new_item.on_spawn()
			new_item.update_icon()
			new_item.calculate_value()
			I.add_object(new_item,TRUE)
			P.to_chat(span("notice","You have successfully purchased \the [new_item] for [current_item_cost] telecrystal\s."))
			if(current_item_quantity <= 0)
				update_icon()

		return TRUE

	P.to_chat(span("notice","You don't have enough telecrystals ([current_item_cost] TC) to buy this!"))

	return TRUE