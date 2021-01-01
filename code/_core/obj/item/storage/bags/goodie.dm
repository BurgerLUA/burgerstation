/obj/item/storage/bags/goodie
	name = "goodie bag"
	icon = 'icons/obj/item/event_bag.dmi'
	var/loot_generated = FALSE

	var/loot/loot_to_generate

	//We generate loot later to prevent lag."

	dynamic_inventory_count = 8
	container_max_size = SIZE_2
	container_max_slots = 1

/obj/item/storage/bags/goodie/save_item_data(var/save_inventory = TRUE)
	. = ..()
	SAVEVAR("loot_generated")
	return .

/obj/item/storage/bags/goodie/load_item_data_pre(var/mob/living/advanced/player/P,var/list/object_data)
	. = ..()
	LOADVAR("loot_generated")
	return .

/obj/item/storage/bags/goodie/click_self(var/mob/caller)

	if(!loot_generated)

		INTERACT_CHECK
		INTERACT_DELAY(1)

		loot_generated = TRUE

		var/loot/L = LOOT(loot_to_generate)
		var/list/generated_loot = L.create_loot_table(get_turf(src))
		for(var/obj/item/I in generated_loot)
			INITIALIZE(I)
			GENERATE(I)
			FINALIZE(I)
			add_to_inventory(null,I,FALSE,TRUE,silent=TRUE)

		caller.to_chat(span("notice","You unwrap \the [src.name]."))
		return TRUE

	return ..()

/obj/item/storage/bags/goodie/halloween
	name = "halloween goodie bag"
	icon_state = "halloween"

	loot_to_generate = /loot/halloween

	value = 50