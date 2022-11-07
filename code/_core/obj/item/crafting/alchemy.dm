/obj/item/crafting/alchemy
	name = "portable alchemy table"
	icon = 'icons/obj/item/ore.dmi'
	icon_state = "alchemy"

	inventories = list(
		/obj/hud/inventory/crafting/slotB1,
		/obj/hud/inventory/crafting/slotB2,
		/obj/hud/inventory/crafting/slotB3,

		/obj/hud/inventory/crafting/result
	)

	crafting_id = "alchemy"

	crafting_type = "alchemy"

	value = 25

	size = SIZE_4

/*
Old code. Maybe someone else will find a use for it....
/obj/item/crafting/alchemy/attempt_to_craft(var/mob/living/advanced/caller)

	var/obj/item/container/C //Final slot container.

	for(var/obj/hud/inventory/crafting/result/R in src.inventories)
		var/obj/item/top_object = R.get_top_object()
		if(top_object.allow_reagent_transfer_to)
			C = top_object
			break

	if(!C)
		caller.to_chat(span("warning","You're missing a valid container in the product slot!"))
		return FALSE

	var/list/item_table = generate_crafting_table(caller,src)

	var/success = FALSE

	for(var/i=1,i<=3,i++)

		var/obj/item/I = item_table["b[i]"]

		if(!I)
			continue

		var/should_delete = FALSE

		var/list/reagents_list = list()

		if(I.alchemy_reagents && length(I.alchemy_reagents))
			should_delete = TRUE //The alchemy reagents were juiced from it.
			for(var/r_id in I.alchemy_reagents)
				if(reagents_list[r_id])
					reagents_list[r_id] += I.alchemy_reagents[r_id]
				else
					reagents_list[r_id] = I.alchemy_reagents[r_id]
		else if(I.allow_reagent_transfer_from)
			should_delete = TRUE

		if(!length(reagents_list) && !(I.reagents && I.reagents.volume_current))
			caller.to_chat(span("warning","\The [I.name] contains no suitable reagents!"))
			continue

		for(var/k in reagents_list)
			var/v = reagents_list[k]
			C.reagents.add_reagent(k,v,TNULL,FALSE,caller = caller)

		if(I.reagents)
			I.reagents.transfer_reagents_to(C.reagents,I.reagents.volume_current,FALSE, caller = caller)

		success = TRUE
		if(should_delete)
			qdel(I)
		else if(I.reagents)
			I.reagents.update_container(caller)

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

	C.reagents.update_container(caller)

	return TRUE
*/
