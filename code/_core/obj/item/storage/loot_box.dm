/obj/item/storage/loot_box
	name = "loot box"
	desc = "Gacha time"
	desc_extended = "A box filled with discarded items, why did you buy a box filled with literal trash again?."
	icon = 'icons/obj/item/storage/death_box.dmi'
	icon_state = "loot"

	value = 1500

	var/loot/desired_loot = /loot/trash_pile

/obj/item/storage/loot_box/Destroy()
	return ..()

/obj/item/storage/loot_box/Finalize()
	prune_inventory()
	return ..()

/obj/item/storage/loot_box/New(var/desired_loc)
	. = ..()

/obj/item/storage/loot_box/Generate()
	if(desired_loot)
		var/loot/L = SSloot.all_loot[desired_loot]
		if(L) L.create_loot_table(src)
	return ..()

/obj/item/storage/loot_box/update_inventory()
	. = ..()
	var/filled_slots = 0
	for(var/k in src.inventories)
		var/obj/hud/inventory/I = k
		filled_slots += length(I.contents)
	if(filled_slots <= 0)
		qdel(src)

/obj/item/storage/loot_box/click_self(var/mob/caller)
	. = ..()
