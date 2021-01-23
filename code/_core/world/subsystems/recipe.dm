SUBSYSTEM_DEF(recipe)
	name = "Recipe Subsystem"
	desc = "Store all the recipes."
	priority = SS_ORDER_PRELOAD
	var/list/recipe/all_recipes = list()

/subsystem/recipe/Initialize()
	for(var/v in subtypesof(/recipe/))
		var/recipe/R = new v
		all_recipes += R

	log_subsystem(name,"Initialized [length(all_recipes)] recipes.")

	return ..()

/proc/generate_crafting_table(var/mob/living/advanced/caller,var/obj/item/crafting/C)

	var/list/item_table = list()

	for(var/k in C.inventories)
		var/obj/hud/inventory/crafting/I = k
		var/obj/item/held_item = I.get_top_object()
		if(held_item)
			item_table[I.id] = held_item
		else
			item_table[I.id] = null

	return item_table