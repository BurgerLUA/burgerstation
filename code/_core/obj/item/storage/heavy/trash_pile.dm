/obj/item/storage/heavy/trash_pile
	name = "trash pile"
	desc = "Look inside, if you dare."
	desc_extended = "A large pile of trash containing long discarded items. It could be dangerous to search one.."
	icon = 'icons/obj/structure/trash_piles.dmi'
	icon_state = "trash"

	var/loot/desired_loot = /loot/trash_pile

	var/meatman_spawned = FALSE

/obj/item/storage/heavy/trash_pile/Finalize()
	prune_inventory()
	return ..()

/obj/item/storage/heavy/trash_pile/New(var/desired_loc)
	. = ..()
	icon_state = "[initial(icon_state)]_[rand(1,11)]"
	if(prob(70))
		meatman_spawned = TRUE
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
	if(!meatman_spawned)
		loc.visible_message(span("danger","A disturbed beefman crawls out of \the [src.name]!"))
		var/mob/living/advanced/npc/beefman/B = new(src.loc)
		INITIALIZE(B)
		GENERATE(B)
		FINALIZE(B)
		B.face_atom(caller)
		meatman_spawned = TRUE
	return .