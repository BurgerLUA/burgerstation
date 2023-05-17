/obj/structure/interactive/storage
	name = "lootable storage"
	desc = "Like inventories, but better."
	var/obj/item/storage_storage/storage

	var/loot/stored_loot
	var/loot/stored_loot_per_instance
	var/list/tracked_instance_ckeys

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
			storage.add_object_to_src_inventory(null,I)
	if(stored_loot_per_instance)
		tracked_instance_ckeys = list()


/obj/structure/interactive/storage/proc/examine_storage(var/mob/living/advanced/caller) //caller wants to see inside src

	INTERACT_CHECK
	INTERACT_DELAY(10)

	var/turf/T = get_turf(src)
	var/rarity = 0
	if(is_player(caller))
		var/mob/living/advanced/player/P = caller
		rarity = P.get_rarity()

	if(stored_loot)
		var/list/spawned_loot = SPAWN_LOOT(stored_loot,T,rarity)
		for(var/obj/item/I in spawned_loot)
			storage.add_object_to_src_inventory(caller,I,enable_messages = FALSE,bypass = TRUE,silent=TRUE)
		stored_loot = null

	if(stored_loot_per_instance && caller.ckey && !tracked_instance_ckeys[caller.ckey])
		tracked_instance_ckeys[caller.ckey] = TRUE
		var/list/spawned_instance_loot = SPAWN_LOOT(stored_loot_per_instance,T,rarity)
		for(var/obj/item/I in spawned_instance_loot)
			storage.add_object_to_src_inventory(caller,I,enable_messages = FALSE,bypass = TRUE,silent=TRUE)

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

	stored_loot = /loot/random/trash/lots
	stored_loot_per_instance = /loot/random/medium

	var/chance_none = 0

/obj/structure/interactive/storage/trash_pile/New(var/desired_loc)

	if(prob(chance_none))
		qdel(src)
		return

	icon_state = "[initial(icon_state)]_[rand(1,10)]"

	. = ..()

/obj/structure/interactive/storage/trash_pile/low_chance
	chance_none = 50

var/global/list/possible_trash_enemies = list(
	/mob/living/simple/passive/mouse/grey = 200,
	/mob/living/simple/bat/space = 50,
	/mob/living/advanced/npc/rogue_assistant = 25,
	/mob/living/simple/gutlunch = 25,
	/mob/living/simple/xeno/hunter = 5,
	/mob/living/simple/glockroach = 1,
)

/obj/structure/interactive/storage/trash_pile/station
	stored_loot = /loot/random/trash/lots
	stored_loot_per_instance = /loot/random/low
	chance_none = 0
	var/stored_threat = FALSE

/obj/structure/interactive/storage/trash_pile/station/Finalize()
	. = ..()
	if(prob(50))
		stored_threat = TRUE

/obj/structure/interactive/storage/trash_pile/station/examine_storage(var/mob/living/advanced/caller)

	. = ..()

	if(. && stored_threat && prob(30))
		var/turf/T = get_turf(src)
		stored_threat = FALSE
		if(T)
			var/mob/living/L = pickweight(possible_trash_enemies)
			L = new L(src)
			INITIALIZE(L)
			GENERATE(L)
			FINALIZE(L)
			L.force_move(T)
			if(L.ai)
				L.ai.set_active(TRUE)
			src.visible_message(span("danger","\A [L.name] crawls out of \the [src.name]!"))




/obj/structure/interactive/storage/safe
	name = "safe"
	desc = "The contents are quite safe indeed."
	desc_extended = "A secure safe designed to hold heavy objects."
	icon = 'icons/obj/structure/safe.dmi'
	icon_state = "safe"

	stored_loot = /loot/misc/safe
	stored_loot_per_instance = /loot/random/high

	plane = PLANE_FLOOR_ATTACHMENT
	layer = LAYER_FLOOR_VENT

	var/chance_none = 70

/obj/structure/interactive/storage/safe/New(var/desired_loc)

	if(prob(chance_none))
		qdel(src)
		return

	. = ..()

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
	icon = 'icons/obj/item/bulletbox.dmi'
	icon_state = "ammo"

	stored_loot = /loot/assorted_ammo/lots
	stored_loot_per_instance = /loot/random/magazine

	pixel_y = 7


/obj/structure/interactive/storage/cash_register
	name = "cash register"
	desc = "It's not stealing if everyone is dead."
	desc_extended = "A basic cash register used for processing transactions through an archaic method known as \"paying cash\"."
	icon = 'icons/obj/structure/register.dmi'
	icon_state = "register"

	stored_loot = /loot/currency/cash_register
	stored_loot_per_instance = /loot/currency/pocket_change

	pixel_y = 10