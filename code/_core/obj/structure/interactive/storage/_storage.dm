/obj/structure/interactive/storage
	name = "lootable storage"
	desc = "Like inventories, but better."
	var/obj/item/storage_storage/storage

	var/loot/stored_loot

	anchored = TRUE

/obj/structure/interactive/storage/Initialize()
	. = ..()
	storage = new(src)
	INITIALIZE(storage)
	GENERATE(storage)
	FINALIZE(storage)

/obj/structure/interactive/storage/Finalize()
	. = ..()
	if(storage && src.z)
		for(var/obj/item/I in loc.contents)
			storage.add_to_inventory(null,I)


/obj/structure/interactive/storage/proc/examine_storage(var/mob/living/advanced/caller) //caller wants to see inside src

	if(!src.can_caller_interact_with(caller,distance_checks=FALSE))
		return TRUE

	INTERACT_DELAY(10)

	if(!(caller in viewers(VIEW_RANGE,src)))
		return TRUE

	if(stored_loot)
		var/turf/T = get_turf(src)
		var/rarity = 0
		if(is_player(caller))
			var/mob/living/advanced/player/P = caller
			rarity = P.get_rarity()
		var/list/spawned_loot = SPAWN_LOOT(stored_loot,T,rarity)
		for(var/obj/item/I in spawned_loot)
			storage.add_to_inventory(caller,I,enable_messages = FALSE,bypass = TRUE,silent=TRUE)
		stored_loot = null

	caller.clear_inventory_defers() //Remove existing ones.

	var/s=0
	for(var/k in storage.inventories)
		var/obj/hud/inventory/I = k
		caller.add_inventory_defer(I,s)
		s++

	return TRUE


/obj/structure/interactive/storage/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	if(is_inventory(object) && is_advanced(caller))
		examine_storage(caller)
		return TRUE

	. = ..()


/obj/structure/interactive/storage/trash_pile
	name = "trash pile"
	desc = "Look inside, if you dare."
	desc_extended = "A large pile of trash containing long discarded items. It could be dangerous to search one.."
	icon = 'icons/obj/structure/trash_piles.dmi'
	icon_state = "trash"

	stored_loot = /loot/value/low

	var/mob/living/stored_threat

/obj/structure/interactive/storage/trash_pile/New(var/desired_loc)
	icon_state = "[initial(icon_state)]_[rand(1,10)]"
	. = ..()

/obj/structure/interactive/storage/trash_pile/Destroy()
	. = ..()
	QDEL_NULL(stored_threat)


/obj/structure/interactive/storage/safe
	name = "safe"
	desc = "The contents are quite safe indeed."
	desc_extended = "A secure safe designed to hold heavy objects."
	icon = 'icons/obj/structure/safe.dmi'
	icon_state = "safe"

	stored_loot = /loot/misc/safe

	plane = PLANE_FLOOR_ATTACHMENT
	layer = 1000

	var/chance_none = 70

/obj/structure/interactive/storage/safe/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	. = ..()

	if(. && is_inventory(object) && is_advanced(caller))
		icon_state = "safe_open"

/obj/structure/interactive/storage/safe/Finalize()
	. = ..()
	var/obj/structure/interactive/storage/safe/O_safe = locate() in orange(8,src)
	if(O_safe) qdel(src)



/obj/structure/interactive/storage/ammo_pile
	name = "assorted ammo pile"
	desc = "What an assorted and unsorted mess."
	desc_extended = "Well, they gotta get their ammo from somewhere."
	stored_loot = /loot/ammo
	icon = 'icons/obj/item/bulletbox.dmi'
	icon_state = "ammo"

	pixel_y = 6