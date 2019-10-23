/plant_type/
	name = "plant name"
	desc = "plant description"
	id = null
	var/icon_count = 1
	var/harvest_icon = 'icons/obj/items/consumable/food/plants.dmi'
	var/list/reagents = list()

/plant_type/nitrogen_flower
	name = "nitrogen flower"
	desc = "An extremely cold flower filled with liquid nitrogen."
	id = "nitrogen_flower"
	icon_count = 3
	reagents = list(
		nitrogen = 1,
	)


/plant_type/oxygen_fruit
	name = "oxygen fruit"
	desc = "An extremely cold watermelon-like plant filled with liquid oxygen."
	id = "oxygen_fruit"
	icon_count = 3
	reagents = list(
		oxygen = 1,
	)


