var/global/list/all_graves = list()

/obj/structure/interactive/grave
	name = "gravestone"
	desc = "RIP in peace."
	desc_extended = "A gravestone marking the location of someone's death."

	icon = 'icons/obj/structure/grave.dmi'
	icon_state = "stone"

	collision_flags = FLAG_COLLISION_NONE
	collision_bullet_flags = FLAG_COLLISION_NONE

	// "[owner_name]_[owner_ckey]" = storage
	var/list/storage_data = list()

	anchored = TRUE

/obj/structure/interactive/grave/New(var/desired_loc)
	. = ..()
	all_graves += src

/obj/structure/interactive/grave/Finalize()
	. = ..()
	src.pixel_z = TILE_SIZE*VIEW_RANGE
	animate(src,pixel_z=0,time=SECONDS_TO_DECISECONDS(3))
	CALLBACK("\ref[src]_finish_grave_animation",SECONDS_TO_DECISECONDS(3),src,src::add_details())

/obj/structure/interactive/grave/proc/add_details()

	src.pixel_z = 0 //safety

	var/image/I1 = new/image(initial(icon),"dirt")
	add_overlay(I1)

	var/image/I2 = new/image(initial(icon),"box")
	add_overlay(I2)

/obj/structure/interactive/grave/is_safe_to_delete(var/check_loc = TRUE)
	return FALSE

/obj/structure/interactive/grave/on_crush(var/message=TRUE)
	CRASH("ERROR: Tried crushing a grave object; something that should NEVER be crushed!")

/obj/structure/interactive/grave/PreDestroy()
	CRASH("ERROR: Tried deleting a grave object; something that should NEVER be deleted!")


/obj/structure/interactive/grave/proc/create_storage_for(var/mob/living/advanced/player/P,var/desired_slots=0)

	var/owner_ckey
	if(P.ckey_last)
		owner_ckey = P.ckey_last
	else if(P.death_ckey)
		owner_ckey = P.death_ckey
	if(!owner_ckey)
		log_error("FATAL ERROR: Could not create grave for [P.get_debug_name()]!")
		return null

	var/final_string = "[owner_ckey]_[P.real_name]"

	if(!storage_data[final_string])
		storage_data[final_string] = list()

	var/obj/item/structure_storage/storage = new(src)
	storage.dynamic_inventory_count = desired_slots
	INITIALIZE(storage)
	GENERATE(storage)
	FINALIZE(storage)
	storage_data[final_string] += storage
	return storage

/obj/structure/interactive/grave/proc/get_storage_for(var/mob/living/advanced/player/P)

	var/final_string = "[P.ckey_last]_[P.real_name]"

	if(!length(storage_data) || !storage_data[final_string] || !length(storage_data[final_string]))
		return null

	. = list()

	for(var/obj/item/structure_storage/found_storage as anything in storage_data[final_string])
		for(var/obj/hud/inventory/found_inventory in found_storage.inventories)
			if(!length(found_inventory.contents))
				continue
			. += found_inventory

	return .


/obj/structure/interactive/grave/clicked_on_by_object(var/mob/activator,var/atom/object,location,control,params)

	if(!is_inventory(object)  || !is_player(activator))
		return ..()

	INTERACT_CHECK
	INTERACT_DELAY(10)
	var/mob/living/advanced/player/P = activator

	var/list/obj/hud/inventory/found_inventories = get_storage_for(P)
	if(!length(found_inventories))
		P.to_chat(span("warning","There is nothing in here for you!"))
		return TRUE

	P.clear_inventory_defers() //Remove existing ones.

	var/s=0
	for(var/obj/hud/inventory/I as anything in found_inventories)
		P.add_inventory_defer(I,s)
		s++

	return TRUE
