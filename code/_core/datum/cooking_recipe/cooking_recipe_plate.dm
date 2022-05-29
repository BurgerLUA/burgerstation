/cooking_recipe/plate //Recipes that you just make on a plate.

/cooking_recipe/plate/stuffed_legion
	name = "stuffed legion"
	item_requirements = list(
		/obj/item/legion_core
	)
	special_item_requirements = list(
		/obj/item/container/edible/dynamic/meat,
		/obj/item/container/edible/plant
	)
	result = /obj/item/container/edible/stuffed_legion


/cooking_recipe/plate/stuffed_legion/check_item_requirement(var/obj/item/I,var/triggering_id)
	. = ..()
	switch(triggering_id)
		if(/obj/item/container/edible/dynamic/meat)
			var/obj/item/container/edible/dynamic/meat/M = I
			if(!M.reagents || !length(M.reagents.stored_reagents) || !M.reagents.stored_reagents[/reagent/nutrition/meat/goliath])
				return FALSE
		if(/obj/item/container/edible/plant)
			var/obj/item/container/edible/plant/P = I
			if(!istype(P.plant_type,/plant_type/chili))
				return FALSE
