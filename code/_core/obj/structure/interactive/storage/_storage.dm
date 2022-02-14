/obj/structure/interactive/storage
	name = "lootable storage"
	desc = "Like inventories, but better."
	var/obj/item/storage_storage/storage

	var/loot/stored_loot

/obj/structure/interactive/storage/Initialize()
	. = ..()
	storage = new(src)
	INITIALIZE(storage)
	GENERATE(storage)
	FINALIZE(storage)

/obj/structure/interactive/storage/Finalize()
	. = ..()
	if(storage && isturf(loc))
		for(var/obj/item/I in loc.contents)
			storage.add_to_inventory(null,I)

/obj/structure/interactive/storage/proc/examine_storage(var/mob/living/advanced/caller) //caller wants to see inside src

	if(!src.can_caller_interact_with(caller,distance_checks=FALSE))
		return TRUE

	INTERACT_DELAY(10)

	if(!(caller in viewers(VIEW_RANGE,src)))
		return TRUE

	if(stored_loot)
		var/loot/L = SSloot.all_loot[stored_loot]
		L.do_spawn(src)
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