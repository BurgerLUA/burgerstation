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

	crafting_type = /recipe/alchemy/

	value = 25

/obj/item/crafting/alchemy/attempt_to_craft(var/mob/living/advanced/caller)

	var/obj/item/container/C //Final slot container.

	for(var/obj/hud/inventory/crafting/result/R in caller.inventory)
		var/obj/item/top_object = R.get_top_object()
		if(is_container(top_object))
			C = top_object
			break

	if(!C && !is_beaker(C))
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
			for(var/r_id in I.alchemy_reagents)
				if(reagents_list[r_id])
					reagents_list[r_id] += I.alchemy_reagents[r_id]
				else
					reagents_list[r_id] = I.alchemy_reagents[r_id]
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
		if(should_delete || !is_beaker(I))
			qdel(I)
		else if(I.reagents)
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




