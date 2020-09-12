/obj/structure/interactive/vending/
	name = "vending machine"
	desc = "Vends things!"
	icon = 'icons/obj/structure/vending.dmi'
	icon_state = "generic"
	desc_extended = "You can use this to purchase things that are always in stock."

	var/list/obj/item/stored_objects = list()
	var/list/obj/item/stored_types = list()

	collision_flags = FLAG_COLLISION_WALL
	collision_bullet_flags = FLAG_COLLISION_BULLET_NONE
	collision_dir = NORTH | EAST | SOUTH | WEST

	var/is_free = FALSE
	var/free_text = "free"

	initialize_type = INITIALIZE_LATE

	bullet_block_chance = 75

	plane = PLANE_WALL_ATTACHMENTS

	pixel_y = 8

/obj/structure/interactive/vending/Destroy()
	stored_types.Cut()
	stored_objects.Cut()
	return ..()

/obj/structure/interactive/vending/proc/can_purchase_item(var/mob/living/advanced/player/P,var/obj/item/associated_item,var/item_value=0,var/obj/hud/inventory/I)

	if(!is_free && P && P.currency < item_value)
		P.to_chat(span("notice","You don't have enough credits to buy this!"))
		return FALSE

	if(I && length(I.held_objects))
		P.to_chat(span("notice","Your hand needs to be empty in order to buy this!"))
		return FALSE

	return TRUE


/obj/structure/interactive/vending/proc/purchase_item(var/mob/living/advanced/player/P,var/obj/item/associated_item,var/item_value=0,var/obj/hud/inventory/I)

	if(!can_purchase_item(P,associated_item,item_value,I))
		return FALSE

	P.spend_currency(item_value)

	var/obj/item/new_item
	new_item = new associated_item.type(get_turf(src))
	INITIALIZE(new_item)
	GENERATE(new_item)
	FINALIZE(new_item)
	new_item.update_sprite()
	if(P)
		if(item_value)
			P.to_chat(span("notice","You have purchased \the [new_item.name] for [item_value] credit\s."))
		else
			P.to_chat(span("notice","You vend \the [new_item.name]."))
	if(I)
		I.add_object(new_item)

	return TRUE

/obj/structure/interactive/vending/Initialize()

	var/turf/T = get_turf(src)

	for(var/S in stored_types)
		var/obj/item/I = new S(src.loc)
		INITIALIZE(I)
		GENERATE(I)
		FINALIZE(I)
	stored_types.Cut()

	for(var/obj/item/I in T.contents)
		stored_objects += I
		I.force_move(src)
		I.plane = PLANE_HUD_OBJ
		I.pixel_y = 4

	return ..()

/obj/structure/interactive/vending/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	INTERACT_CHECK

	if(!is_player(caller))
		return ..()

	var/mob/living/advanced/player/P = caller

	if(P.active_structure == src)
		P.set_structure_unactive()
	else
		P.set_structure_active(src)

	return ..()

/obj/structure/interactive/vending/proc/show_buttons_to(var/mob/living/advanced/A)

	var/stored_objects_length = length(stored_objects)

	var/row=0
	var/column=0

	for(var/i=1,i<=stored_objects_length,i++)
		if(row >= 8)
			row = 0
			column++
		var/obj/item/I = stored_objects[i]
		var/obj/hud/button/vendor/V = new
		V.associated_item = I
		V.associated_vendor = src
		V.screen_loc = "LEFT+[1 + (column)*3],TOP-[row+1]"
		V.update_owner(A)
		V.update_sprite()
		row++

	var/obj/hud/button/close_vendor/CV = new
	CV.screen_loc = "LEFT+[1 + (column+1)*3],TOP-1"
	CV.update_owner(A)
	CV.update_sprite()

/obj/structure/interactive/vending/proc/hide_buttons_from(var/mob/living/advanced/A)

	for(var/obj/hud/button/vendor/V in A.buttons)
		V.update_owner(null)

	for(var/obj/hud/button/close_vendor/V in A.buttons)
		V.update_owner(null)

/obj/structure/interactive/vending/on_active(var/mob/living/advanced/player/P)
	show_buttons_to(P)
	return ..()

/obj/structure/interactive/vending/on_inactive(var/mob/living/advanced/player/P)
	hide_buttons_from(P)
	return ..()