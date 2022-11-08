/*
Future reference for everyone who'd be willing to do crafting recipes -
Grid goes like this:
a1,a2,a3
b1,b2,b3
c1,c2,c3
i.e. minecraft-like stick recipe would be like this:
a1,a2,a3
b1,plank,b3
c1,plank,c3
And the code would look like this:
"a1" = null,
"a2" = null,
"a3" = null,
"b1" = null,
"b2" = plank,
"b3" = null,
"c1" = null,
"c2" = plank,
"c3" = null
*/
/recipe/
	var/name = "recipe"
	var/recipe_type = ""
	var/desc = "A recipe."
	var/desc_extended = "Recipe information."

	var/do_debug = FALSE

	var/list/required_item_grid = list( //Second value is the path of the item as string
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
	//List of required items SOMEWHERE in the table. Use path of item as String
	var/list/required_items = list()

	var/list/product = list() // What does it make = chance to make out of 100. More than one item will drop the previous on the ground.
	var/list/amount = list(1) //How many? First product, then second, third... so on. Doesnt check max stack size.
	var/list/reagents_to_add = list() //Reagent to fill resulting container with, if any. Reagent as string = amount, Doesnt check if the container can HOLD that much though.
	var/material_id_result = null  //What material ID should the resulting item have? Leave null if it doesnt have a material_id! Only works for /obj/item/material/ decendents
	var/list/fail_product = list() // If we fail the craft, what should we make? Weighted list, can be null.
	var/fail_amount = 1 //Fail amount of items, because it only gives one type of item, no need to worry about a list.
	var/list/fail_reagents_to_add = list() //Same as above, but for fail products. Won't try to fill something that can't hold anything.
	//Result icon and icon state.
	var/icon = ""
	var/icon_state = ""
	
	var/list/no_consume_ids = list() //What types shouldnt be consumed on craft?

	

	var/secret = FALSE //Its a secret to everybody. Won't show up in "recipe" loot items.

/recipe/proc/on_create(var/mob/living/advanced/caller,var/obj/item/crafting/crafting_table,var/obj/item/created_item)
	return TRUE
	
/recipe/proc/on_fail(var/mob/living/advanced/caller,var/obj/item/crafting/crafting_table,var/obj/item/created_item)
	return TRUE

/recipe/proc/check_recipe(var/list/item_table,var/obj/item/crafting/crafting_table)

	var/list/used_items = list()

	if(length(required_item_grid))
		for(var/grid_id in required_item_grid)
			var/grid_crafting_id_text = required_item_grid[grid_id]
			var/grid_crafting_id = text2path_safe(grid_crafting_id_text)

			if(!grid_crafting_id || grid_crafting_id == null)
				if(do_debug) 
					log_debug("No item is needed for [grid_id]. Skipping.")
				continue
			var/obj/item/held_item_in_grid = item_table[grid_id]
			if(!held_item_in_grid)
				if(do_debug) 
					log_debug("There is no item in [grid_id]. We cannot craft this recipe ([name]) without a [grid_crafting_id] in [grid_id].")
				return list()
			else if(!istype(held_item_in_grid,grid_crafting_id))
				if(do_debug) 
					log_debug("There is an incorrect item in [grid_id]. We cannot craft this recipe ([name]) without a [grid_crafting_id] in [grid_id].")
				return list()
			else
				used_items += held_item_in_grid
				if(grid_crafting_id_text in no_consume_ids)
					used_items[held_item_in_grid] = TRUE
	
	if(length(required_items))
		var/list/found_slots = list()
		for(var/crafting_type_id in required_items)
			var/crafting_id = text2path_safe(crafting_type_id)
			var/amount_to_take = required_items[crafting_type_id]
			var/found=FALSE
			for(var/i = 1, i <= amount_to_take,i++)
				for(var/grid_id in item_table)
					if(grid_id in found_slots)
						continue
					var/obj/item/I = item_table[grid_id]
					if(!I)
						continue
					if(istype(I,crafting_id))
						used_items += I
						found=TRUE
						found_slots += grid_id
						if(crafting_type_id in no_consume_ids)
							used_items[I] = TRUE
						break
			if(!found)
				return list()
	return used_items