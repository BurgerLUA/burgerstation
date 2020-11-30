/obj/item/container/food/plant
	name = "plant"
	desc = "For vegans."
	desc_extended = "The trick to not spending money is that there's food pretty much everywhere if you're not afraid of poisoning."

	icon = 'icons/obj/item/consumable/food/plants.dmi'
	icon_state = "burger"

	consume_verb = "eat"

	var/plant_type/plant_type

	var/growth_min = 0
	var/growth_max = 100
	var/growth_produce_max = 200

	var/potency = 20
	var/yield = 1
	var/growth_speed = 5

	var/delete_after_harvest = TRUE

	drop_sound = 'sound/items/drop/herb.ogg'

/obj/item/container/food/plant/save_item_data(var/save_inventory = TRUE)
	. = ..()

	SAVEVAR("icon_state")

	SAVEPATH("plant_type")

	SAVEVAR("growth_min")
	SAVEVAR("growth_max")
	SAVEVAR("growth_produce_max")

	SAVEVAR("potency")
	SAVEVAR("yield")
	SAVEVAR("growth_speed")

	SAVEVAR("delete_after_harvest")

	return .

/obj/item/container/food/plant/load_item_data_pre(var/mob/living/advanced/player/P,var/list/object_data)
	. = ..()

	LOADVAR("icon_state")

	LOADPATH("plant_type")

	LOADVAR("growth_min")
	LOADVAR("growth_max")
	LOADVAR("growth_produce_max")

	LOADVAR("potency")
	LOADVAR("yield")
	LOADVAR("growth_speed")

	LOADVAR("delete_after_harvest")

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