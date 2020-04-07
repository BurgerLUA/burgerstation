/obj/structure/interactive/shop/

	name = "ITEM NAME HERE"
	desc = "NOT IMPORTANT."

	var/obj/item/stored_item
	var/stored_item_cost

	icon = 'icons/obj/structure/shop.dmi'
	icon_state = "debug"

	mouse_opacity = 1

/obj/structure/interactive/shop/Destroy()

	qdel(stored_item)
	stored_item = null

	return ..()

/obj/structure/interactive/shop/proc/initialize_shop()

	. = ..()

	var/list/possible_items = list()
	for(var/obj/item/I in loc.contents)
		possible_items += I

	if(!length(possible_items))
		qdel(src)
		return FALSE

	stored_item = pick(possible_items)
	stored_item.force_move(src)
	stored_item.on_spawn()
	possible_items -= stored_item

	for(var/obj/item/I in possible_items)
		qdel(I)

	stored_item_cost = stored_item.calculate_value()

	update_sprite()

	return .

/obj/structure/interactive/shop/update_overlays()
	. = ..()
	var/image/O = new/image(icon,icon_state)
	O.pixel_x = -2
	O.pixel_y = -4
	add_overlay(O)
	return .


/obj/structure/interactive/shop/update_underlays()
	. = ..()
	var/image/U = new/image(icon,icon_state)
	U.pixel_x = 2
	U.pixel_y = 4
	underlays += U
	return .


/obj/structure/interactive/shop/update_sprite()

	if(stored_item)
		stored_item.update_sprite()
		appearance = stored_item.appearance
		mouse_opacity = 1
		name = "[stored_item.name] - [stored_item_cost] credits"

	if(locate(/obj/structure/smooth/table/) in src.loc.contents)
		pixel_y = 4
	else
		pixel_y = 0

	return ..()

/obj/structure/interactive/shop/get_examine_list(var/mob/examiner)

	. = list()

	. += stored_item.get_examine_list(examiner)

	if(stored_item.is_container)
		var/list/contents = stored_item.inventory_to_list()
		. += div("notice","It contains: [english_list(contents)]")

	. += div("notice","This item is being sold for [stored_item_cost] credits.")

	return .

/obj/structure/interactive/shop/clicked_on_by_object(var/atom/caller,var/atom/object,location,control,params)

	INTERACT_CHECK

	if(!is_player(caller))
		return TRUE

	var/mob/living/advanced/player/P = caller
	var/atom/defer_object = object.defer_click_on_object()

	if(!is_inventory(defer_object))
		P.to_chat(span("notice","Your hand needs to be empty in order to buy this!"))
		return TRUE

	var/obj/hud/inventory/I = defer_object

	if(P.currency >= stored_item_cost && P.spend_currency(stored_item_cost)) //Just in case
		spawn()
			var/obj/item/new_item = new stored_item.type(get_turf(src))
			new_item.on_spawn()
			new_item.update_sprite()
			I.add_object(new_item,TRUE)
			P.to_chat(span("notice","You have successfully purchased \the [new_item] for [stored_item_cost] credits."))

		return TRUE

	P.to_chat(span("notice","You don't have enough credits ([stored_item_cost] credits) to buy this!"))

	return TRUE