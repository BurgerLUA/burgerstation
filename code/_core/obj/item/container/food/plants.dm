/obj/item/container/food/plant
	name = "plant"
	desc = "For vegans."

	icon = 'icons/obj/items/consumable/food/plants.dmi'
	icon_state = "burger"

	consume_verb = "eat"

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