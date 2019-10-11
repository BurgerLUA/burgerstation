/obj/item/crafting/alchemy
	name = "portable alchemy table"
	icon = 'icons/obj/items/ore.dmi'
	icon_state = "alchemy"

	inventories = list(

		/obj/hud/inventory/crafting/slotB1,
		/obj/hud/inventory/crafting/slotB3,

		/obj/hud/inventory/crafting/result
	)

	crafting_id = "alchemy"

/obj/item/crafting/alchemy/attempt_to_craft(var/mob/living/advanced/caller)

	var/obj/hud/inventory/crafting/result/product_slot

	for(var/obj/hud/inventory/crafting/result/R in caller.inventory)
		if(R.get_top_held_object())
			caller.to_chat(span("notice","Remove the already completed item in the product slot before doing this!"))
			return FALSE
		else
			product_slot = R

	var/list/item_table = generate_crafting_table(caller)

	if(!item_table["b3"] || !is_container(item_table["b3"]))
		caller.to_chat(span("notice","You're missing a container in the right slot!"))
		return FALSE

	if(!item_table["b1"] || !is_item(item_table["b1"]))
		caller.to_chat(span("notice","You're missing a valid item in the left slot!"))
		return FALSE

	var/obj/item/I = item_table["b1"]

	var/list/reagents_list = I.reagents ? I.reagents.stored_reagents.Copy() : list()

	/* PRE FUCKERY
	if(I.reagents && I.reagents.stored_reagents)
		for(var/r_id in I.reagents.stored_reagents)
			var/volume = reagents.stored_reagents[R_id]
			reagents_list[r_id] = volume
	*/

	if(I.alchemy_reagents)
		for(var/r_id in I.alchemy_reagents)
			if(reagents_list[r_id])
				reagents_list[r_id] += I.alchemy_reagents[r_id]
			else
				reagents_list[r_id] = I.alchemy_reagents[r_id]

	if(!length(reagents_list))
		caller.to_chat(span("notice","\The [I.name] contains no suitable reagents!"))
		return FALSE

	var/obj/item/container/C = item_table["b3"]

	for(var/k in reagents_list)
		var/v = reagents_list[k]
		C.reagents.add_reagent(k,v,FALSE)

	C.reagents.update_container()

	C.transfer_item(product_slot)

	qdel(I)

	return TRUE




