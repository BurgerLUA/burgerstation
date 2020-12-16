/obj/item/container/food/meme_pizza
	name = "legendary pineapple pizza"

	icon = 'icons/obj/item/consumable/food/meme.dmi'
	icon_state = "pizza"

	desc = "Who would put fruit on a pizza?"
	desc_extended = "An absolutely legendary pizza that heals you to full health when consumed. Does not work on the dead."

	value = 1000
	rarity = RARITY_LEGENDARY

	scale_sprite = FALSE

	var/servings_left = 2

/obj/item/container/food/meme_pizza/Generate()
	reagents.add_reagent(/reagent/nutrition/bread,10)
	reagents.add_reagent(/reagent/nutrition/cheese/cheddar,5)
	reagents.add_reagent(/reagent/nutrition/tomato,5)
	reagents.add_reagent(/reagent/nutrition/pineapple,5)
	return ..()

/obj/item/container/food/meme_pizza/update_icon()

	icon_state = initial(icon_state)

	if(servings_left <= 1)
		icon_state = "[icon_state]_half"

	return ..()

/obj/item/container/food/meme_pizza/save_item_data(var/save_inventory = TRUE)
	. = ..()
	SAVEVAR("servings_left")
	return .

/obj/item/container/food/meme_pizza/load_item_data_pre(var/mob/living/advanced/player/P,var/list/object_data)
	. = ..()
	LOADVAR("servings_left")
	return .

/obj/item/container/food/meme_pizza/Finalize()
	value = servings_left*0.5*initial(value)
	update_sprite()
	return ..()

/obj/item/container/food/meme_pizza/get_calculated_bites(var/mob/living/caller,var/total_reagents = 1)
	return servings_left

/obj/item/container/food/meme_pizza/feed(var/mob/caller,var/mob/living/target)
	. = ..()
	if(.)
		servings_left = 1 //It's always going to be 1 or nothing. If it's nothing, then that might cause issues.
		value = servings_left*0.5*initial(value)
		if(!target.dead) target.rejuvenate()
		update_sprite()

	return .