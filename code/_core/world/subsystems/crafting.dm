var/global/list/all_recipes = list()

SUBSYSTEM_DEF(recipe)
	name = "Recipe Subsystem"
	desc = "Store all the recipes."
	priority = SS_ORDER_PRELOAD

/subsystem/recipe/Initialize()
	for(var/v in subtypesof(/recipe/))
		var/recipe/R = new v
		if(R.id)
			all_recipes[R.id] = R
		else
			qdel(R)

	log_subsystem(name,"Initialized [length(all_recipes)] recipes.")


/proc/generate_crafting_table(var/mob/living/advanced/caller,var/obj/item/crafting/C)

	var/list/item_table = list()

	for(var/obj/hud/inventory/crafting/I in C.inventories)
		var/obj/item/held_item = I.get_top_held_object()
		if(held_item)
			item_table[I.id] = held_item
		else
			item_table[I.id] = null

	return item_table

/*
/proc/attempt_to_craft(var/mob/living/advanced/caller,var/obj/item/crafting/crafting_table)

	var/obj/hud/inventory/crafting/result/product_slot

	for(var/obj/hud/inventory/crafting/result/R in caller.inventory)
		if(R.get_top_held_object())
			caller.to_chat(span("notice","Remove the already completed item in the product slot before doing this!"))
			return FALSE
		else
			product_slot = R

	var/list/item_table = generate_crafting_table(caller,src)

	for(var/R_id in all_recipes)
		var/recipe/R = all_recipes[R_id]

		var/list/recipe_check = R.check_recipe(item_table,crafting_table)
		if(length(recipe_check)) //We can craft
			for(var/obj/item/I in recipe_check)
				if(is_inventory(I.loc))
					var/obj/hud/inventory/I2 = I.loc
					I2.remove_object(I,get_turf(caller))
				qdel(I)

			var/obj/item/I = new R.product(caller.loc)
			product_slot.add_held_object(I,caller,FALSE,TRUE)
			return I

	caller.to_chat(span("notice","You fail to craft anything..."))
	return FALSE
*/