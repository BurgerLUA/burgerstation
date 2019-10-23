/obj/item/container/food/plant
	name = "plant"
	desc = "For vegans."

	icon = 'icons/obj/items/consumable/food/plants.dmi'
	icon_state = "burger"

	consume_verb = "eat"


	//Seed stuff
	var/potency = 20 //How much chemicals to add.
	var/yield = 1 //How much does each harvest yield?
	var/growth_speed = 5 //How much to add to growth every 10 seconds when the plant is done growing but is making fruit.

/obj/item/container/food/plant/nitrogen_flower
	name = "nitrogen flower"
	icon_state = "nitrogen_flower"

/obj/item/container/food/plant/nitrogen_flower/on_spawn()
	reagents.add_reagent("nitrogen",10)


/obj/item/container/food/plant/oxygen_fruit
	name = "oxygen fruit"
	icon_state = "oxygen_fruit"

/obj/item/container/food/plant/oxygen_fruit/on_spawn()
	reagents.add_reagent("oxygen",10)

/obj/item/container/food/plant/wheat
	name = "wheat"
	icon_state = "wheat"

/obj/item/container/food/plant/wheat/on_spawn()
	reagents.add_reagent("wheat_grain",10)


/obj/item/container/food/plant/sugarcane
	name = "sugarcane"
	icon_state = "sugarcane"

/obj/item/container/food/plant/sugarcane/on_spawn()
	reagents.add_reagent("sugarcane",10)