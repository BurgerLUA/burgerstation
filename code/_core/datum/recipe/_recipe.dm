/recipe/
	var/name = "recipe"
	var/recipe_type = ""
	var/desc = "A recipe."
	var/desc_extended = "Recipe information."

	var/do_debug = FALSE

	var/list/required_item_grid = list( //The second value is the craft_id of the item.
		/*
		"a1" = null,
		"a2" = null,
		"a3" = null,

		"b1" = null,
		"b2" = null,
		"b3" = null,

		"c1" = null,
		"c2" = null,
		"c3" = null
		*/
	)

	var/list/required_items = list()

	var/obj/item/product

	//Result icon and icon state.
	var/icon = ""
	var/icon_state = ""

	var/transfer_reagents = FALSE

/recipe/proc/on_create(var/mob/living/advanced/caller,var/obj/item/crafting/crafting_table,var/obj/item/created_item)

	return TRUE

/recipe/proc/check_recipe(var/list/item_table,var/obj/item/crafting/crafting_table)

	if(crafting_table.crafting_id != recipe_type)
		return list()

	var/list/used_items = list()

	if(length(required_item_grid))
		for(var/grid_id in required_item_grid)
			var/grid_crafting_id = required_item_grid[grid_id]
			if(!grid_crafting_id || grid_crafting_id == null)
				if(do_debug) log_debug("No item is needed for [grid_id]. Skipping.")
				continue
			var/obj/item/held_item_in_grid = item_table[grid_id]
			if(!held_item_in_grid)
				if(do_debug) log_debug("There is no item in [grid_id]. We cannot craft this recipe ([name]) without a [grid_crafting_id] in [grid_id].")
				return list()
			else if(held_item_in_grid.crafting_id != grid_crafting_id)
				if(do_debug) log_debug("There is an incorrect item in [grid_id]. We cannot craft this recipe ([name]) without a [grid_crafting_id] in [grid_id].")
				return list()
			else
				used_items += held_item_in_grid

	if(length(required_items))
		for(var/crafting_id in required_items)
			var/found_id = FALSE
			for(var/grid_id in item_table)
				var/obj/item/I = item_table[grid_id]
				if(!I)
					continue
				if(I.crafting_id == crafting_id)
					used_items += I
					found_id = TRUE
					break
			if(!found_id)
				return list()

	return used_items