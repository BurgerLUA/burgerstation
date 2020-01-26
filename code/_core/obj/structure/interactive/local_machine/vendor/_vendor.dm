/obj/structure/interactive/vendor/
	name = "vending machine"
	desc = "Vends things!"
	icon = 'icons/obj/structure/vending.dmi'
	icon_state = "generic"
	desc_extended = "You can use this to purchase things that are always in stock."

	var/list/obj/item/stored_objects = list()
	var/list/obj/item/stored_types = list()

	collision_flags = FLAG_COLLISION_REAL
	collision_bullet_flags = FLAG_COLLISION_BULLET_NONE

	density_north = TRUE
	density_south = TRUE
	density_east  = TRUE
	density_west  = TRUE

	var/is_free = FALSE
	var/free_text = "free"

	var/force_spawn_stored_types = FALSE

/obj/structure/interactive/vendor/Destroy()
	stored_types.Cut()
	stored_objects.Cut()
	return ..()

/obj/structure/interactive/vendor/proc/can_purchase_item(var/mob/living/advanced/player/P,var/obj/item/associated_item,var/item_value=0,var/obj/hud/inventory/I)

	if(!is_free && P && P.currency < item_value && !P.spend_currency(item_value))
		P.to_chat(span("notice","You don't have enough telecrystals to buy this!"))
		return FALSE

	if(I && length(I.held_objects))
		P.to_chat(span("notice","Your hand needs to be empty in order to buy this!"))
		return FALSE

	return TRUE


/obj/structure/interactive/vendor/proc/purchase_item(var/mob/living/advanced/player/P,var/obj/item/associated_item,var/item_value=0,var/obj/hud/inventory/I)

	if(!can_purchase_item(P,associated_item,item_value,I))
		return FALSE

	var/obj/item/new_item
	if(ispath(associated_item))
		new_item = new associated_item(get_turf(src))
	else
		new_item = new associated_item.type(get_turf(src))
	new_item.on_spawn()
	new_item.update_icon()
	if(P)
		if(item_value)
			P.to_chat(span("notice","You have purchased \the [new_item.name] for [item_value] telecrystal\s."))
		else
			P.to_chat(span("notice","You vend \the [new_item.name]."))
	if(I)
		new_item.transfer_item(I)

	return TRUE

/obj/structure/interactive/vendor/Initialize()

	var/turf/T = get_turf(src)

	if(force_spawn_stored_types)
		for(var/obj/item/I in stored_types)
			new I(src)
		stored_types.Cut()

	for(var/obj/item/I in T.contents)
		I.on_spawn()
		stored_objects += I
		I.force_move(src)
		I.update_icon()
		I.plane = PLANE_HUD_OBJ
		I.pixel_y = 4

	return ..()

/obj/structure/interactive/vendor/clicked_on_by_object(var/mob/caller,object,location,control,params)

	INTERACT_CHECK

	if(!is_player(caller))
		return ..()

	var/mob/living/advanced/player/P = caller

	if(P.active_structure == src)
		P.set_structure_unactive()
	else
		P.set_structure_active(src)

	return ..()

/obj/structure/interactive/vendor/proc/show_buttons_to(var/mob/living/advanced/A)

	var/stored_objects_length = length(stored_objects)
	var/stored_types_length = length(stored_types)

	for(var/i=1,i<=stored_objects_length,i++)
		var/obj/item/I = stored_objects[i]
		var/obj/hud/button/vendor/V = new
		V.associated_item = I
		V.associated_vendor = src
		V.screen_loc = "CENTER-3,CENTER-0.5-[(stored_objects_length+stored_types_length)*0.5]+[i]"
		V.update_owner(A)
		V.update_icon()

	for(var/i=1,i<=stored_types_length,i++)
		var/obj/item/I = stored_types[i]
		var/obj/hud/button/vendor/V = new
		V.associated_item = I
		V.associated_vendor = src
		V.screen_loc = "CENTER-3,CENTER-0.5-[(stored_objects_length+stored_types_length)*0.5]+[i+stored_objects_length]"
		V.update_owner(A)
		V.update_icon()

/obj/structure/interactive/vendor/proc/hide_buttons_from(var/mob/living/advanced/A)
	for(var/obj/hud/button/vendor/V in A.buttons)
		V.update_owner(null)

/obj/structure/interactive/vendor/on_active(var/mob/living/advanced/player/P)
	show_buttons_to(P)
	return ..()

/obj/structure/interactive/vendor/on_inactive(var/mob/living/advanced/player/P)
	hide_buttons_from(P)
	return ..()