/obj/item/crafting/grinder
	name = "portable grinder"
	icon = 'icons/obj/item/ore.dmi'
	icon_state = "grinder"

	inventories = list(
		/obj/hud/inventory/crafting/slotB1,
		/obj/hud/inventory/crafting/slotB2,
		/obj/hud/inventory/crafting/slotB3,

		/obj/hud/inventory/crafting/result
	)

	crafting_id = "grinder"

	crafting_type = null //This actually doesn't craft anything.

	value = 25


/obj/item/crafting/grinder/attempt_to_craft(var/mob/living/advanced/caller)

	var/obj/item/container/C //Final slot container.

	for(var/obj/hud/inventory/crafting/result/R in caller.inventory)
		var/obj/item/top_object = R.get_top_object()
		C = top_object
		break

	if(!C)
		for(var/obj/hud/inventory/crafting/R in caller.inventory)
			var/obj/item/top_object = R.get_top_object()
			if(is_beaker(top_object))
				C = top_object
				break

	if(!C || !is_beaker(C))
		caller.to_chat(span("warning","You're missing a valid container in the product slot!"))
		return FALSE

	var/list/item_table = generate_crafting_table(caller,src)

	var/success = FALSE

	for(var/i=1,i<=3,i++)

		var/obj/item/I = item_table["b[i]"]

		if(!I || !I.reagents)
			continue

		if(I.reagents)
			I.reagents.transfer_reagents_to(C.reagents,I.reagents.volume_current,FALSE, caller = caller)
			success = TRUE

		if(!is_beaker(I))
			qdel(I)
		else
			I.reagents.update_container()

	if(!success)
		caller.to_chat(span("warning","There are no valid items to process!"))
		return FALSE

	for(var/reagent_type in C.reagents.stored_reagents)
		var/reagent_amount = C.reagents.stored_reagents[reagent_type]
		var/reagent/R = REAGENT(reagent_type)
		if(R.processed_reagent)
			var/temperature = C.reagents.average_temperature
			C.reagents.remove_reagent(reagent_type,reagent_amount,FALSE)
			C.reagents.add_reagent(R.processed_reagent,reagent_amount,temperature,FALSE,FALSE,caller = caller)

	C.reagents.update_container()

	return TRUE