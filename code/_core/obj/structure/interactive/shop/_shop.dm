/obj/structure/interactive/shop/

	name = "ITEM NAME HERE"
	desc = "NOT IMPORTANT."

	var/obj/item/stored_item

	var/stored_item_cost
	var/stored_item_burgerbux_cost

	icon = 'icons/obj/structure/shop.dmi'
	icon_state = "debug"

	mouse_opacity = 1

	initialize_type = INITIALIZE_LATE

	var/markup = 1.25

/obj/structure/interactive/shop/high_markup
	markup = 6

/obj/structure/interactive/shop/PreDestroy()
	QDEL_NULL(stored_item)
	. = ..()

/obj/structure/interactive/shop/Initialize()

	. = ..()

	var/list/possible_items = list()
	for(var/obj/item/I in loc.contents)
		possible_items += I

	if(length(possible_items))
		stored_item = pick(possible_items)
		stored_item.drop_item(src)
		possible_items -= stored_item

		for(var/k in possible_items)
			var/obj/item/I = k
			qdel(I)


/obj/structure/interactive/shop/PostInitialize()

	. = ..()

	if(stored_item)

		stored_item.update_sprite()
		update_sprite()

		if(stored_item.value_burgerbux)
			stored_item_burgerbux_cost = stored_item.value_burgerbux
			stored_item_cost = 0
			name = "[stored_item.name] - [stored_item_burgerbux_cost] burgerbux"
		else
			stored_item_cost = max(1,CEILING(stored_item.get_value()*markup,1))
			if(stored_item_cost == 1)
				log_error("Warning: Item of [stored_item] has a low value! Suspected no cost item.")
			name = "[stored_item.name] - [stored_item_cost] credits"

/obj/structure/interactive/shop/Finalize()
	. = ..()
	if(!stored_item)
		qdel(src)
	else
		update_sprite()

/obj/structure/interactive/shop/update_overlays()

	. = ..()

	stored_item.pixel_x = initial(stored_item.pixel_x)
	stored_item.pixel_y = initial(stored_item.pixel_y)

	var/image/U = new/image(icon,icon_state)
	U.appearance = stored_item.appearance
	U.pixel_x = 2
	U.pixel_y = 4
	U.plane = FLOAT_PLANE
	U.layer = FLOAT_LAYER
	add_overlay(U)

	var/image/M = new/image(icon,icon_state)
	M.appearance = stored_item.appearance
	M.plane = FLOAT_PLANE
	M.layer = FLOAT_LAYER
	add_overlay(M)

	var/image/O = new/image(icon,icon_state)
	O.appearance = stored_item.appearance
	O.pixel_x = -2
	O.pixel_y = -4
	O.plane = FLOAT_PLANE
	O.layer = FLOAT_LAYER
	add_overlay(O)

/obj/structure/interactive/shop/update_icon()
	. = ..()
	icon = ICON_INVISIBLE

/obj/structure/interactive/shop/update_sprite()

	. = ..()

	if(locate(/obj/structure/table/) in src.loc.contents)
		pixel_y = 4
	else
		pixel_y = 0


/obj/structure/interactive/shop/get_examine_list(var/mob/examiner)

	. = list()
	. += stored_item.get_examine_list(examiner)

	if(stored_item.is_container)
		var/list/contents = stored_item.inventory_to_list()
		. += div("notice","It contains: [english_list(contents)]")

	if(stored_item_burgerbux_cost)
		. += div("notice","This item is being sold for [stored_item_burgerbux_cost] burgerbux.")
	else
		. += div("notice","This item is being sold for [stored_item_cost] credits.")


/obj/structure/interactive/shop/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	if(!is_player(caller) || !caller.client)
		return ..()

	INTERACT_CHECK
	INTERACT_CHECK_OBJECT
	INTERACT_DELAY(1)

	var/mob/living/advanced/player/P = caller
	var/obj/hud/inventory/I = object

	if(!is_inventory(object))
		P.to_chat(span("notice","Your hand needs to be empty in order to buy this!"))
		return TRUE

	if(stored_item_burgerbux_cost)
		var/savedata/client/globals/GD = GLOBALDATA(caller.client.ckey)
		if(!GD)
			caller.to_chat(span("danger","Globaldata error detected. Report this to burger on discord with error code: Burgerbux."))
			return TRUE
		var/currency = GD.loaded_data["burgerbux"]
		if(currency >= stored_item_burgerbux_cost && P.spend_burgerbux(stored_item_burgerbux_cost))
			var/obj/item/new_item = new stored_item.type(get_turf(src))
			INITIALIZE(new_item)
			GENERATE(new_item)
			FINALIZE(new_item)
			new_item.update_sprite()
			I.add_object(new_item)
			P.to_chat(span("notice","You have successfully purchased \the [new_item] for [stored_item_burgerbux_cost] burgerbux."))
			return TRUE

		P.to_chat(span("notice","You don't have enough burgerbux ([stored_item_burgerbux_cost] burgerbux) to buy this!"))


	else
		if(P.currency >= stored_item_cost && P.spend_currency(stored_item_cost)) //Just in case
			var/obj/item/new_item = new stored_item.type(get_turf(src))
			INITIALIZE(new_item)
			GENERATE(new_item)
			FINALIZE(new_item)
			new_item.update_sprite()
			P.to_chat(span("notice","You have successfully purchased \the [new_item] for [stored_item_cost] credits."))
			if(P.movement_flags & MOVEMENT_RUNNING && new_item.quick_equip(P))
				return TRUE
			P.put_in_hands(new_item,params)
			return TRUE

		P.to_chat(span("notice","You don't have enough credits ([stored_item_cost] credits) to buy this!"))




	return TRUE