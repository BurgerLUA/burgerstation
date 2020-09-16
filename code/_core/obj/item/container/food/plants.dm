/obj/item/container/food/plant
	name = "plant"
	desc = "For vegans."
	desc_extended = "The trick to not spending money is that there's food pretty much everywhere if you're not afraid of poisoning."

	icon = 'icons/obj/item/consumable/food/plants.dmi'
	icon_state = "burger"

	consume_verb = "eat"


	//Seed stuff
	var/potency = 20 //How much chemicals to add.
	var/yield = 1 //How much does each harvest yield?
	var/growth_speed = 5 //How much to add to growth every 10 seconds when the plant is done growing but is making fruit.

	drop_sound = 'sound/items/drop/herb.ogg'

/obj/item/container/food/plant/save_item_data(var/save_inventory = TRUE)
	. = ..()
	SAVEVAR("icon_state")
	SAVEVAR("potency")
	SAVEVAR("yield")
	SAVEVAR("growth_speed")
	return .

/obj/item/container/food/plant/load_item_data_pre(var/mob/living/advanced/player/P,var/list/object_data)
	. = ..()
	LOADVAR("icon_state")
	LOADVAR("potency")
	LOADVAR("yield")
	LOADVAR("growth_speed")
	return .

/obj/item/container/food/plant/nitrogen_flower
	name = "nitrogen flower"
	icon_state = "nitrogen_flower"

/obj/item/container/food/plant/nitrogen_flower/Generate()
	reagents.add_reagent(/reagent/nitrogen,10)
	return ..()

/obj/item/container/food/plant/oxygen_fruit
	name = "oxygen fruit"
	icon_state = "oxygen_fruit"

/obj/item/container/food/plant/oxygen_fruit/Generate()
	reagents.add_reagent(/reagent/oxygen,10)
	return ..()

/obj/item/container/food/plant/wheat
	name = "wheat"
	icon_state = "wheat"

/obj/item/container/food/plant/wheat/Generate()
	reagents.add_reagent(/reagent/nutrition/wheat_grain,10)
	return ..()


/obj/item/container/food/plant/sugarcane
	name = "sugarcane"
	icon_state = "sugarcane"

/obj/item/container/food/plant/sugarcane/Generate()
	reagents.add_reagent(/reagent/nutrition/sugar/cane,10)
	return ..()