/obj/item/storage/heavy/trash_pile
	name = "trash pile"
	desc = "Look inside, if you dare."
	desc_extended = "A large pile of trash containing long discarded items. It could be dangerous to search one.."
	icon = 'icons/obj/structure/trash_piles.dmi'
	icon_state = "trash"

	var/loot/desired_loot = /loot/trash_pile

	var/mob/living/advanced/npc/beefman/stored_beefman

/obj/item/storage/heavy/trash_pile/Destroy()
	QDEL_NULL(stored_beefman)
	return ..()

/obj/item/storage/heavy/trash_pile/Finalize()
	prune_inventory()
	return ..()

/obj/item/storage/heavy/trash_pile/New(var/desired_loc)
	. = ..()
	icon_state = "[initial(icon_state)]_[rand(1,11)]"
	if(prob(10) || z != 1)
		stored_beefman = new(src)
		INITIALIZE(stored_beefman)
		GENERATE(stored_beefman)
		FINALIZE(stored_beefman)
	else if(prob(20))
		new /mob/living/simple/passive/mouse/grey(src.loc)

	return .

/obj/item/storage/heavy/trash_pile/Generate()
	if(desired_loot)
		var/loot/L = SSloot.all_loot[desired_loot]
		if(L) L.create_loot_table(src)
	return ..()

/obj/item/storage/heavy/trash_pile/update_inventory()
	. = ..()
	var/filled_slots = 0
	for(var/k in src.inventories)
		var/obj/hud/inventory/I = k
		filled_slots += length(I.held_objects)
	if(filled_slots <= 0)
		qdel(src)
	return .


/obj/item/storage/heavy/trash_pile/click_self(var/mob/caller)

	. = ..()

	if(. && stored_beefman)
		var/turf/T = get_turf(src)
		T.visible_message(span("danger","A disturbed beefman crawls out of \the [src.name]!"))
		stored_beefman.force_move(T)
		stored_beefman.ai.set_active(TRUE)
		stored_beefman.face_atom(caller)
		stored_beefman = null

	return .