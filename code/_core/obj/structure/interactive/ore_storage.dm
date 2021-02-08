/obj/structure/interactive/ore_storage
	name = "ore storage"
	desc = "A container that stores ores"
	icon = 'icons/obj/structure/ore_storage.dmi'
	icon_state = "ore_storage_map"

	bullet_block_chance = 75

	density = TRUE

/obj/structure/interactive/ore_storage/update_icon()

	if(THINKING(src))
		icon_state = "ore_storage_1"
	else
		icon_state = "ore_storage"

	return ..()

/obj/structure/interactive/ore_storage/PostInitialize()
	. = ..()
	start_thinking(src)
	update_sprite()
	return .

/obj/structure/interactive/ore_storage/update_icon()
	. = ..()
	icon_state = "ore_storage"
	return .

/obj/structure/interactive/ore_storage/Cross(atom/movable/O)

	if(store_ore(O))
		return FALSE

	return ..()


/obj/structure/interactive/ore_storage/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)



	INTERACT_CHECK
	INTERACT_CHECK_OBJECT
	INTERACT_DELAY(5)

	store_ore(object)

	return TRUE

/obj/structure/interactive/ore_storage/proc/store_ore(var/atom/movable/M)

	if(istype(M,/obj/item/material/ore/))
		var/obj/item/material/ore/O = M
		O.drop_item(src)
		return TRUE

	if(istype(M,/obj/structure/interactive/ore_box))
		var/obj/structure/interactive/ore_box/OB = M
		var/did_store = FALSE
		for(var/obj/item/material/ore/O in OB.contents)
			if(store_ore(O))
				did_store = TRUE
		if(did_store)
			OB.visible_message(span("notice","\The [OB.name] dumps all the ore inside \the [src.name]."))
		return TRUE

	return FALSE

/obj/structure/interactive/ore_storage/think()
	if(length(src.contents))
		var/atom/movable/A = src.contents[1]
		A.force_move(get_step(src,dir))
	return TRUE