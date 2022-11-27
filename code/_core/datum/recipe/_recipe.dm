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

	var/list/required_item_grid
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

	var/list/required_item_grid_amount //Assoc list of crafting_id to amount to remove. Blank means assume just 1.


	var/obj/item/product //The created product.
	var/product_amount = 1 //The amount of products to create.

	var/list/product_reagents = list() //Reagent to fill resulting container with, if any. Reagent as string = amount, Doesnt check if the container can HOLD that much though, so it can overfill.

	var/secret = FALSE //Its a secret to everybody. Won't show up in "recipe" loot items.

/recipe/proc/on_create(var/mob/living/advanced/caller,var/obj/item/crafting/crafting_table,var/obj/item/created_item,var/list/item_table)

	//By default, remove all the items.

	for(var/j in item_table)
		var/obj/item/I = j
		var/amount_to_remove = length(required_item_grid_amount) && isnum(required_item_grid_amount[j]) ? required_item_grid_amount[j] : 1
		if(I.reagents && created_item.reagents)
			I.reagents.transfer_reagents_to(created_item.reagents)
		if(amount_to_remove > 0)
			I.add_item_count(-amount_to_remove)

	return TRUE

/recipe/proc/check_recipe(var/list/item_table,var/obj/item/crafting/crafting_table) //Returns items that were used in creation. Return null if fail.

	if(!length(item_table))
		return null

	var/list/used_items = list()

	for(var/grid_id in required_item_grid)

		var/grid_crafting_id = required_item_grid[grid_id] //Path or crafting_id
		var/grid_crafting_id_is_path = ispath(grid_crafting_id)

		if(!grid_crafting_id)
			if(do_debug) log_debug("No item is needed for [grid_id]. Skipping.")
			continue

		var/obj/item/I = item_table[grid_id]
		if(!I)
			if(do_debug) log_debug("There is no item in [grid_id]. We cannot craft this recipe ([name]) without a [grid_crafting_id] in [grid_id].")
			return null

		if(grid_crafting_id_is_path)
			if(!istype(I,grid_crafting_id))
				if(do_debug) log_debug("There is an incorrect item type ([I.type]) in [grid_id]. We cannot craft this recipe ([name]) without a [grid_crafting_id] in [grid_id].")
				return null
		else
			if(grid_crafting_id != I.crafting_id)
				if(do_debug) log_debug("There is an incorrect item crafting_id ([I.crafting_id]) in [grid_id]. We cannot craft this recipe ([name]) without a [grid_crafting_id] in [grid_id].")
				return null

		if(length(required_item_grid_amount) && required_item_grid_amount[grid_crafting_id] && I.amount < required_item_grid_amount[grid_crafting_id])
			if (do_debug) log_debug("There isnt enough of item in [grid_id]! We cannot craft this recipe ([name]) without at least [required_item_grid_amount[grid_crafting_id]] [grid_crafting_id] in [grid_id]. ")
			return null

		if(length(required_item_grid_amount) && isnum(required_item_grid_amount[grid_crafting_id]))
			used_items[I] = required_item_grid_amount[grid_crafting_id]
		else
			used_items[I] = 1

	return used_items
