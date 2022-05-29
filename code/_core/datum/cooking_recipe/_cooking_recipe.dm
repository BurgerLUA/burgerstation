/cooking_recipe/
	var/name = "Recipe name."
	var/desc = "Recipe description."
	var/list/obj/item/item_requirements
	var/list/obj/item/special_item_requirements
	var/list/reagent_requirements = list()
	var/exact = FALSE //Set to true if the items need to EXACTLY match. For example, a recipe of 3 potatos, 1 carrot will not work if the items compared contain anything more than 3 potatos, 1 carrot.
	var/obj/item/result

	//Generated vars.
	var/priority //Calculated at New(). Used for sorting priority and recipe completion.

/cooking_recipe/New()
	. = ..()
	priority = length(item_requirements) + length(special_item_requirements) + length(reagent_requirements)

	item_requirements = make_associative_count(item_requirements)
	special_item_requirements = make_associative_count(special_item_requirements)

/cooking_recipe/proc/check_item_requirement(var/obj/item/I,var/triggering_id) //Triggering ID being the crafting ID.
	return TRUE

/cooking_recipe/proc/check(var/list/items_to_check,var/reagent_container/container_to_check)

	if(length(reagent_requirements) && (!container_to_check || !length(container_to_check.stored_reagents)))
		return FALSE

	//Check reagents.
	for(var/k in reagent_requirements)
		var/required_volume = reagent_requirements[k]
		if(!container_to_check.stored_reagents[k] || container_to_check.stored_reagents[k] < required_volume)
			return FALSE

	//Check items.
	var/list/local_item_requirements = item_requirements?.Copy()
	var/list/local_special_item_requirements = special_item_requirements?.Copy()

	for(var/k in items_to_check)
		var/obj/item/I = k
		if(local_item_requirements[I.crafting_id])
			local_item_requirements[I.crafting_id] -= 1
			if(!local_item_requirements[I.crafting_id])
				local_item_requirements -= I.crafting_id
		else if(local_special_item_requirements[I.crafting_id])
			if(!check_item_requirement(I,k))
				continue
			local_special_item_requirements[I.crafting_id] -= 1
			if(!local_special_item_requirements[I.crafting_id])
				local_special_item_requirements -= I.crafting_id
		else if(exact)
			return FALSE

	return !(length(local_item_requirements) + length(local_special_item_requirements))